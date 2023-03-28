output "aws_iam_role_ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_execution_role" {
  value = aws_iam_role_policy_attachment.ecs_task_execution_role
}


output "eks-demo-cluster-iam" {
  value = aws_iam_role.demo-cluster
}

output "eks-worker-node-iam" {
  value = aws_iam_role.demo-node
}

output "eks-demo-cluster-AmazonEKSClusterPolicy" {
  value = aws_iam_role_policy_attachment.demo-cluster-AmazonEKSClusterPolicy  
}

output "eks-demo-cluster-AmazonEKSVPCResourceController" {
  value = aws_iam_role_policy_attachment.demo-cluster-AmazonEKSVPCResourceController
  
}


output "eks-worker-node-AmazonEKSWorkerNodePolicy" {
  value = aws_iam_role_policy_attachment.demo-node-AmazonEKSWorkerNodePolicy
}

output "eks-worker-node-AmazonEKS_CNI_Policy" {
  value = aws_iam_role_policy_attachment.demo-node-AmazonEKS_CNI_Policy
}

output "eks-worker-node-AmazonEC2ContainerRegistryReadOnly" {
  value = aws_iam_role_policy_attachment.demo-node-AmazonEC2ContainerRegistryReadOnly  
}


