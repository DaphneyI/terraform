locals {
    allow-ingress = flatten([
        for key, rule in var.allow-ingress : {
          key = key
          priority = rule.priority 
          network = rule.network
          allow =  rule.allow
          source_tags = rule.source_tags 
          source_ranges = rule.source_ranges
          target_tags = rule.target_tags  
        }
    ])

    allow-egress = flatten([
        for key, rule in var.allow-egress : {
          key = key
          priority = rule.priority 
          network = rule.network
          allow =  rule.allow
          destination_ranges = rule.destination_ranges
          target_tags = rule.target_tags  
        }
    ])

    deny-ingress = flatten([
        for key, rule in var.deny-ingress : {
          key = key
          priority = rule.priority 
          network = rule.network
          deny =  rule.deny
          source_tags = rule.source_tags 
          source_ranges = rule.source_ranges
          target_tags = rule.target_tags  
        }
    ])

    deny-egress = flatten([
        for key, rule in var.deny-egress : {
          key = key
          priority = rule.priority 
          network = rule.network
          deny =  rule.deny
          destination_ranges = rule.destination_ranges
          target_tags = rule.target_tags  
        }
    ])
}