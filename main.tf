module "vpc" {
  source     = "./vpc"
  aws_region = var.aws_region
}

module "eks" {
  source                                             = "./eks"
  aws_region                                         = var.aws_region
  vpc                                                = module.vpc.vpc
  subnet-private                                     = module.vpc.subnet-private
  eks-demo-cluster-iam                               = module.iam.eks-demo-cluster-iam
  eks-demo-cluster-AmazonEKSClusterPolicy            = module.iam.eks-demo-cluster-AmazonEKSClusterPolicy
  eks-demo-cluster-AmazonEKSVPCResourceController    = module.iam.eks-demo-cluster-AmazonEKSVPCResourceController
  eks-worker-node-iam                                = module.iam.eks-worker-node-iam
  eks-worker-node-AmazonEKSWorkerNodePolicy          = module.iam.eks-worker-node-AmazonEKSWorkerNodePolicy
  eks-worker-node-AmazonEKS_CNI_Policy               = module.iam.eks-worker-node-AmazonEKS_CNI_Policy
  eks-worker-node-AmazonEC2ContainerRegistryReadOnly = module.iam.eks-worker-node-AmazonEC2ContainerRegistryReadOnly
}

module "ecs" {
  source                                   = "./ecs"
  aws_region                               = var.aws_region
  vpc                                      = module.vpc.vpc
  subnet-private                           = module.vpc.subnet-private
  subnet-public                            = module.vpc.subnet-public
  aws_iam_role_ecs_task_execution_role_arn = module.iam.aws_iam_role_ecs_task_execution_role_arn
  ecs_task_execution_role                  = module.iam.ecs_task_execution_role
}


module "cloudwatch" {
  source                    = "./cloudwatch"
  scale_up_policy_arn       = module.ecs.scale_up_policy_arn
  scale_down_policy_arn     = module.ecs.scale_down_policy_arn
  ecs-service-name          = module.ecs.ecs-service-name
  ecs-cluster-name          = module.ecs.ecs-cluster-name
  scale_up_policy-jenkins   = module.jenkins-autoscaling.scale_up_policy
  scale_down_policy-jenkins = module.jenkins-autoscaling.scale_down_policy
}

module "iam" {
  source = "./iam"
}

module "jenkins-autoscaling" {
  source                         = "./jenkins-autoscaling"
  aws_region                     = var.aws_region
  key-name                       = module.key-pair.key-name
  vpc                            = module.vpc.vpc
  subnet-public                  = module.vpc.subnet-public
  jenkins-installation-user-data = module.scripts.jenkins-installation-user-data
  jenkins-cpu-high-alarm         = module.cloudwatch.jenkins-cpu-high-alarm
  jenkins-cpu-low-alarm          = module.cloudwatch.jenkins-cpu-low-alarm

}

module "key-pair" {
  source = "./key-pair"
}

module "scripts" {
  source    = "./scripts"
  cloudinit = { source = "hashicorp/cloudinit" }
}

module "jenkins-worker-node" {
  source        = "./jenkins-worker-node"
  aws_region    = var.aws_region
  key-name      = module.key-pair.key-name
  vpc           = module.vpc.vpc
  subnet-public = module.vpc.subnet-public


}