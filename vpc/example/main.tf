module "vpc" {
  source = "../../vpc"
  vpc = {
    "playd" = {
      auto_create_subnetworks = false
      subnets = {
        "first" = {
            cidr = "192.168.70.0/24"
            region = "us-central1"
            sec-range = {
              "pod-range" = {
                ip-range = "10.0.0.0/26"
              }
              "svc-range" = {
                ip-range = "192.168.11.0/25"
              }
            }
        }
      }
    }
}
}