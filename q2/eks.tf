provider "kubernetes" {
    host = data.aws_eks_cluster.eks.endpoint
    token = data.aws_eks_cluster_auth.eks.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority.0.data)
}

data "aws_eks_cluster" "eks" {
    name = module.eks.cluster_id
}
data "aws_eks_cluster_auth" "eks" {
    name = module.eks.cluster_id
}

module "eks"{
    source = "terraform-aws-modules/eks/aws"
    version = "17.1.0"
    cluster_name = var.cluster_name
    cluster_version = "1.24"
    subnets = module.vpc.private_subnets
    tags = {
        Name = "Rattle-EKS-Cluster"
    }
    vpc_id = module.vpc.vpc_id

    workers_group_defaults = {
        root_volume_type = "gp2"
    }
    worker_groups = [
        {
            name = "Worker-Group-1"
            instance_type = "t2.micro"
            asg_desired_capacity = 2
            additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
        },
        {
            name = "Worker-Group-2"
            instance_type = "t2.micro"
            asg_desired_capacity = 1
            additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
        },
    ]
}




