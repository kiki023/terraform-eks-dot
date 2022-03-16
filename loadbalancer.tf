resource "kubernetes_service" "ingress_gateway" {
  metadata {
    name = "dotpay-service-backend-demo"
    namespace = "dotpay-dev"
  }
  spec {
    port {
      port = 8080
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

# Create a local variable for the load balancer name.
locals {
  lb_name = split("-", split(".", kubernetes_service.ingress_gateway.status.0.load_balancer.0.ingress.0.hostname).0).0
}

# Read information about the load balancer using the AWS provider.
data "aws_elb" "ingress_gateway" {
  name = local.lb_name
}


# from load balancer
output "load_balancer_name" {
  value = local.lb_name
}

output "load_balancer_hostname" {
  value = kubernetes_service.ingress_gateway.status.0.load_balancer.0.ingress.0.hostname
}

output "load_balancer_info" {
  value = data.aws_elb.ingress_gateway
}
