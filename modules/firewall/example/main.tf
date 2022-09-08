module "firewall" {
  source = "../../firewall"
  allow-ingress = {
    "first" = {
      network = "default"
      source_tags = ["allow_gitlab", "public"]
      target_tags = ["server"]
      source_ranges = null
      priority = 1000
      allow = {
        "one" = {
            protocol = "tcp"
            ports = ["80"]
        }
      }
    }
  }

  deny-ingress = {
    "third" = {
      network = "default"
      source_tags = null
      target_tags = ["server"]
      source_ranges = ["154.34.78.90/12"]
      priority = 1000
      deny = {
        "one" = {
            protocol = "tcp"
            ports = ["80"]
        }
      }
    }
  }

  allow-egress = {
    "second" = {
      network = "default"
      target_tags = ["server"]
      destination_ranges = ["34.67.89.0/24"]
      priority = 1000
      allow = {
        "one" = {
            protocol = "tcp"
            ports = ["80"]
        }
       }
    }
  }

  deny-egress = {
    "fourth" = {
      network = "default"
      target_tags = ["server"]
      destination_ranges = ["134.67.89.0/24"]
      priority = 1000
      deny = {
        "one" = {
            protocol = "tcp"
            ports = ["80"]
        }
      }
    }
  }
}