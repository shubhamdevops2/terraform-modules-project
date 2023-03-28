

resource "aws_eks_node_group" "demo" {
  cluster_name    = aws_eks_cluster.demo.name
  node_group_name = "demo"
  node_role_arn   = var.eks-worker-node-iam.arn
  subnet_ids      = var.subnet-private.*.id
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  depends_on = [
    var.eks-worker-node-AmazonEKSWorkerNodePolicy,
    var.eks-worker-node-AmazonEKS_CNI_Policy,
    var.eks-worker-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
