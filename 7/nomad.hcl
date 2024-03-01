
variable "name" {
  description = "Deployment name"
  type = string 
}

variable "datacenters" {
  description = "Datacenters to deploy to"
  type = list(string)
}

variable "vault_policies" {
  description = "Vault policy list"
  type = list(string)
}

variable "meta_purpose" {
  description = "Meta Purpose"
  type = string 
}

variable "node_class" {
  description = "Node Class"
  type = string 
}

variable "domain" {
  description = "Domain for Traefik"
  type = string 
}

variable "build_image_name" {
  description = "Build image name"
  type = string 
}

variable "build_image_tag" {
  description = "Build image tag"
  type = string 
}

variable "count" {
  description = ""
  type = number 
}

variable "cpu" {
  description = "Container cpu"
  type = number
}

variable "mem" {
  description = "Container mem"
  type = number 
}

variable "log_level" {
  description = "Log Level"
  type = string
}

# This can be used if we ever want to try and calculate some value through hcl methods, etc... 
locals { }

job "bitcoin" {
  name        = var.name
  // datacenters = var.datacenters
  type        = "service"

  // Base constraints: in a production setting we would want something like this to ensure proper allocation 
  // 
  // constraint {
  //   attribute = "${meta.node-switcher}"
  //   value = "on"
  // }
  // constraint {
  //   attribute = "${meta.purpose}"
  //   value = var.meta_purpose
  // }
  // constraint {
  //   attribute = "${node.class}"
  //   value = var.node_class
  // }

  // Added constraints 
  // TBD..... 

  group "bitcoin" {
    count = var.count 

    network {
      port "main" {
        to     = 8333
      }
      port "jsonrpc" {
        to     = 8332
      }
    }

    service {
      name = "${var.name}-${NOMAD_NAMESPACE}-main"
      provider = "nomad"
      tags = [
        "traefik.enable=true",
        # TODO: Traefic tags for TCP routing, can't remember if I have done this in the past before..... 
      ]
      port = "main"

      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "5s"
      }
    }

    service {
      name = "${var.name}-${NOMAD_NAMESPACE}-jsonrpc"
      provider = "nomad"
      tags = [
        "traefik.enable=true",
        # TODO: Traefic tags for TCP routing, can't remember if I have done this in the past before..... 
      ]
      port = "jsonrpc"

      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "5s"
      }
    }

    task "bitcoin" {
      driver = "docker"
      config {
        image = "${var.build_image_name}:${var.build_image_tag}"
        
        // In case this is needed.... (which it usually should be...)
        //
        // auth {
        //   username = "blah..."
        //   password = "blah..."
        // }

        force_pull = false 
        ports = ["main", "jsonrpc"]
      }

      // If integrated with vault.....
      // 
      // vault {
      //   policies = var.vault_policies
      //   change_mode = "restart"
      // }

      // Secret configs, if needed.....
//       template {
//         data = <<EOH
// BITCOIN_SECRET = {{ with secret "bitcoin" }}{{ .Data.bitcoin_secret }}{{ end }}
// EOH
//         destination = "secrets/config.env"
//         change_mode = "restart"
//         env = true
//       }

      env {
        BITCOIN_LOG_LEVEL = "${var.log_level}"
      }

      resources {
        cpu = var.cpu 
        memory = var.mem 
      }
    }
  }
}

