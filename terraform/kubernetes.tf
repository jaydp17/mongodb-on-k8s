output "cluster_name" {
  value = "block-cluster-k8s.jaydp.com"
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-block-cluster-k8s-jaydp-com.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-block-cluster-k8s-jaydp-com.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-block-cluster-k8s-jaydp-com.name}"
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-block-cluster-k8s-jaydp-com.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.ap-south-1a-block-cluster-k8s-jaydp-com.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-block-cluster-k8s-jaydp-com.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-block-cluster-k8s-jaydp-com.name}"
}

output "region" {
  value = "ap-south-1"
}

output "vpc_id" {
  value = "${aws_vpc.block-cluster-k8s-jaydp-com.id}"
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_autoscaling_group" "master-ap-south-1a-masters-block-cluster-k8s-jaydp-com" {
  name                 = "master-ap-south-1a.masters.block-cluster-k8s.jaydp.com"
  launch_configuration = "${aws_launch_configuration.master-ap-south-1a-masters-block-cluster-k8s-jaydp-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.ap-south-1a-block-cluster-k8s-jaydp-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "block-cluster-k8s.jaydp.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-ap-south-1a.masters.block-cluster-k8s.jaydp.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-ap-south-1a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-block-cluster-k8s-jaydp-com" {
  name                 = "nodes.block-cluster-k8s.jaydp.com"
  launch_configuration = "${aws_launch_configuration.nodes-block-cluster-k8s-jaydp-com.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.ap-south-1a-block-cluster-k8s-jaydp-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "block-cluster-k8s.jaydp.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.block-cluster-k8s.jaydp.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-block-cluster-k8s-jaydp-com" {
  availability_zone = "ap-south-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                   = "block-cluster-k8s.jaydp.com"
    Name                                                = "a.etcd-events.block-cluster-k8s.jaydp.com"
    "k8s.io/etcd/events"                                = "a/a"
    "k8s.io/role/master"                                = "1"
    "kubernetes.io/cluster/block-cluster-k8s.jaydp.com" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-block-cluster-k8s-jaydp-com" {
  availability_zone = "ap-south-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                   = "block-cluster-k8s.jaydp.com"
    Name                                                = "a.etcd-main.block-cluster-k8s.jaydp.com"
    "k8s.io/etcd/main"                                  = "a/a"
    "k8s.io/role/master"                                = "1"
    "kubernetes.io/cluster/block-cluster-k8s.jaydp.com" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-block-cluster-k8s-jaydp-com" {
  name = "masters.block-cluster-k8s.jaydp.com"
  role = "${aws_iam_role.masters-block-cluster-k8s-jaydp-com.name}"
}

resource "aws_iam_instance_profile" "nodes-block-cluster-k8s-jaydp-com" {
  name = "nodes.block-cluster-k8s.jaydp.com"
  role = "${aws_iam_role.nodes-block-cluster-k8s-jaydp-com.name}"
}

resource "aws_iam_role" "masters-block-cluster-k8s-jaydp-com" {
  name               = "masters.block-cluster-k8s.jaydp.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.block-cluster-k8s.jaydp.com_policy")}"
}

resource "aws_iam_role" "nodes-block-cluster-k8s-jaydp-com" {
  name               = "nodes.block-cluster-k8s.jaydp.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.block-cluster-k8s.jaydp.com_policy")}"
}

resource "aws_iam_role_policy" "masters-block-cluster-k8s-jaydp-com" {
  name   = "masters.block-cluster-k8s.jaydp.com"
  role   = "${aws_iam_role.masters-block-cluster-k8s-jaydp-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.block-cluster-k8s.jaydp.com_policy")}"
}

resource "aws_iam_role_policy" "nodes-block-cluster-k8s-jaydp-com" {
  name   = "nodes.block-cluster-k8s.jaydp.com"
  role   = "${aws_iam_role.nodes-block-cluster-k8s-jaydp-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.block-cluster-k8s.jaydp.com_policy")}"
}

resource "aws_internet_gateway" "block-cluster-k8s-jaydp-com" {
  vpc_id = "${aws_vpc.block-cluster-k8s-jaydp-com.id}"

  tags = {
    KubernetesCluster                                   = "block-cluster-k8s.jaydp.com"
    Name                                                = "block-cluster-k8s.jaydp.com"
    "kubernetes.io/cluster/block-cluster-k8s.jaydp.com" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-block-cluster-k8s-jaydp-com-d9ba1ead9d2065217b8fde9595aa01f2" {
  key_name   = "kubernetes.block-cluster-k8s.jaydp.com-d9:ba:1e:ad:9d:20:65:21:7b:8f:de:95:95:aa:01:f2"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.block-cluster-k8s.jaydp.com-d9ba1ead9d2065217b8fde9595aa01f2_public_key")}"
}

resource "aws_launch_configuration" "master-ap-south-1a-masters-block-cluster-k8s-jaydp-com" {
  name_prefix                 = "master-ap-south-1a.masters.block-cluster-k8s.jaydp.com-"
  image_id                    = "ami-640d5f0b"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-block-cluster-k8s-jaydp-com-d9ba1ead9d2065217b8fde9595aa01f2.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-block-cluster-k8s-jaydp-com.id}"
  security_groups             = ["${aws_security_group.masters-block-cluster-k8s-jaydp-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-ap-south-1a.masters.block-cluster-k8s.jaydp.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-block-cluster-k8s-jaydp-com" {
  name_prefix                 = "nodes.block-cluster-k8s.jaydp.com-"
  image_id                    = "ami-640d5f0b"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-block-cluster-k8s-jaydp-com-d9ba1ead9d2065217b8fde9595aa01f2.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-block-cluster-k8s-jaydp-com.id}"
  security_groups             = ["${aws_security_group.nodes-block-cluster-k8s-jaydp-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.block-cluster-k8s.jaydp.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.block-cluster-k8s-jaydp-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.block-cluster-k8s-jaydp-com.id}"
}

resource "aws_route_table" "block-cluster-k8s-jaydp-com" {
  vpc_id = "${aws_vpc.block-cluster-k8s-jaydp-com.id}"

  tags = {
    KubernetesCluster                                   = "block-cluster-k8s.jaydp.com"
    Name                                                = "block-cluster-k8s.jaydp.com"
    "kubernetes.io/cluster/block-cluster-k8s.jaydp.com" = "owned"
    "kubernetes.io/kops/role"                           = "public"
  }
}

resource "aws_route_table_association" "ap-south-1a-block-cluster-k8s-jaydp-com" {
  subnet_id      = "${aws_subnet.ap-south-1a-block-cluster-k8s-jaydp-com.id}"
  route_table_id = "${aws_route_table.block-cluster-k8s-jaydp-com.id}"
}

resource "aws_security_group" "masters-block-cluster-k8s-jaydp-com" {
  name        = "masters.block-cluster-k8s.jaydp.com"
  vpc_id      = "${aws_vpc.block-cluster-k8s-jaydp-com.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                                   = "block-cluster-k8s.jaydp.com"
    Name                                                = "masters.block-cluster-k8s.jaydp.com"
    "kubernetes.io/cluster/block-cluster-k8s.jaydp.com" = "owned"
  }
}

resource "aws_security_group" "nodes-block-cluster-k8s-jaydp-com" {
  name        = "nodes.block-cluster-k8s.jaydp.com"
  vpc_id      = "${aws_vpc.block-cluster-k8s-jaydp-com.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                                   = "block-cluster-k8s.jaydp.com"
    Name                                                = "nodes.block-cluster-k8s.jaydp.com"
    "kubernetes.io/cluster/block-cluster-k8s.jaydp.com" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-block-cluster-k8s-jaydp-com.id}"
  source_security_group_id = "${aws_security_group.masters-block-cluster-k8s-jaydp-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-block-cluster-k8s-jaydp-com.id}"
  source_security_group_id = "${aws_security_group.masters-block-cluster-k8s-jaydp-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-block-cluster-k8s-jaydp-com.id}"
  source_security_group_id = "${aws_security_group.nodes-block-cluster-k8s-jaydp-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-block-cluster-k8s-jaydp-com.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-block-cluster-k8s-jaydp-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-block-cluster-k8s-jaydp-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-block-cluster-k8s-jaydp-com.id}"
  source_security_group_id = "${aws_security_group.nodes-block-cluster-k8s-jaydp-com.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-block-cluster-k8s-jaydp-com.id}"
  source_security_group_id = "${aws_security_group.nodes-block-cluster-k8s-jaydp-com.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-block-cluster-k8s-jaydp-com.id}"
  source_security_group_id = "${aws_security_group.nodes-block-cluster-k8s-jaydp-com.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-block-cluster-k8s-jaydp-com.id}"
  source_security_group_id = "${aws_security_group.nodes-block-cluster-k8s-jaydp-com.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-block-cluster-k8s-jaydp-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-block-cluster-k8s-jaydp-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "ap-south-1a-block-cluster-k8s-jaydp-com" {
  vpc_id            = "${aws_vpc.block-cluster-k8s-jaydp-com.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "ap-south-1a"

  tags = {
    KubernetesCluster                                   = "block-cluster-k8s.jaydp.com"
    Name                                                = "ap-south-1a.block-cluster-k8s.jaydp.com"
    SubnetType                                          = "Public"
    "kubernetes.io/cluster/block-cluster-k8s.jaydp.com" = "owned"
    "kubernetes.io/role/elb"                            = "1"
  }
}

resource "aws_vpc" "block-cluster-k8s-jaydp-com" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                                   = "block-cluster-k8s.jaydp.com"
    Name                                                = "block-cluster-k8s.jaydp.com"
    "kubernetes.io/cluster/block-cluster-k8s.jaydp.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "block-cluster-k8s-jaydp-com" {
  domain_name         = "ap-south-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                                   = "block-cluster-k8s.jaydp.com"
    Name                                                = "block-cluster-k8s.jaydp.com"
    "kubernetes.io/cluster/block-cluster-k8s.jaydp.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "block-cluster-k8s-jaydp-com" {
  vpc_id          = "${aws_vpc.block-cluster-k8s-jaydp-com.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.block-cluster-k8s-jaydp-com.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
