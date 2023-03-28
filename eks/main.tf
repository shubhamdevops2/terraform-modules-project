#
# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#



# allow outbound rule for nat gateway
resource "aws_security_group" "demo-cluster" {
  name        = "terraform-eks-demo-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.subnet-private.*.cidr_block 
  }

  tags = {
    Name = "terraform-eks-demo-sg"
  }
}

# allow incomming inbound rule for my laptop ip
resource "aws_security_group_rule" "demo-cluster-ingress-workstation-https" {
  cidr_blocks       = [local.workstation-external-cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.demo-cluster.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_eks_cluster" "demo" {
  name     = var.cluster-name
  role_arn = var.eks-demo-cluster-iam.arn

  vpc_config {
    security_group_ids = [aws_security_group.demo-cluster.id]
    subnet_ids         = var.subnet-private.*.id
  }

  depends_on = [
    var.eks-demo-cluster-AmazonEKSClusterPolicy,
    var.eks-demo-cluster-AmazonEKSVPCResourceController,
  ]
}
