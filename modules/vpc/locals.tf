locals {
  # flatten ensures that this local value is a flat list of objects, rather
  # than a list of lists of objects.

  network_subnets = flatten([
    for network_key, network in var.vpc : [
        for subnet_key, subnet in network.subnets : {
                network_key = network_key
                subnet_key = subnet_key
                secondary_range = subnet.sec-range
                network_id = google_compute_network.vpc_network[network_key].id
                ip_cidr_range = subnet.cidr
                region = subnet.region
            }
        
    ]  
  ])
}


# list_subnets = flatten([
#     for subnet in var.subnets :{
#       name = subnet.name
#       cidr = subnet.cidr
#       region = subnet.region
#     }
# ])
# }