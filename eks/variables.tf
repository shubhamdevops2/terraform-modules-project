variable "aws_region" {
  type    = string
  default = null
}

# eks cluster name
variable "cluster-name" {
  default = "terraform-eks-demo"
  type    = string
}

variable "vpc" {
}


variable "subnet-private" {
  
}

variable "eks-demo-cluster-iam" {
  
}

variable "eks-demo-cluster-AmazonEKSClusterPolicy" {

}

variable "eks-demo-cluster-AmazonEKSVPCResourceController" {

}

variable "eks-worker-node-iam" {

}

variable "eks-worker-node-AmazonEKSWorkerNodePolicy" {

}

variable "eks-worker-node-AmazonEKS_CNI_Policy" {

}

variable "eks-worker-node-AmazonEC2ContainerRegistryReadOnly" {

}




