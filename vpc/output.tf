output "vpc" {
  value = { for key, vpc in google_compute_network.vpc_network : key => vpc.id }
}

output "subnets" {
    value = { for key, subnet in google_compute_subnetwork.subnet : key => { id = subnet.id, network = subnet.network } }
}

