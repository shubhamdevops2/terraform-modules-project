### The purpose of this repository is to provide a comprehensive understanding of the architecture involved in the provisioning of a CI/CD server through Terraform.

![Architecture graph](graph.png)

**Above is the image of architecture that I created by terraform I used for EKS,ECS and various other resources and all of them in one VPC.**

Below are the modules that we will be focusing on mainly for CI/CD tools.

1) jenkins-autoscaling - Autoscaling module for jenkins
2) jenkins-worker-node - Ec2 as an worker node for jenkins
3) EKS - kuberenetes server for the deployment
4) ECS - Sonqrube with application load balancer
5) key-pair - To make a common key-pair and access it for other modules.
6) iam - To store all modules roles and policies. Also make it availble for other module.
7) scripts - To store all the scripts in one place and make it available for other modules.
8) cloudwatch - To create a alarms for other modules.
9) vpc - To create single virtual network and to integrate all other modules in single virtual network.




