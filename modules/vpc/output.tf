output "vpc" {
  value = { for key, vpc in google_compute_network.vpc_network : key => {
    "id" = vpc.id
    "self_link" = vpc.self_link
  } }
}

output "subnets" {
    value = { for key, subnet in google_compute_subnetwork.subnet : key => { 
      "id" = subnet.id
      "network" = subnet.network 
      "self_link" = subnet.self_link
      "secondary_ips" = subnet.secondary_ip_range
    } }
}

