module "iam" {
    project_id = var.project_id
    source = "../../IAM"
    roles = {
        "mark" = {
            member_type = "user"
            member = "markbloggs@google.com"
            roles = [
                "roles/compute.instanceAdmin.v1",
                "roles/compute.securityAdmin" 
                ]
        }
        "monitoring" = {
            member_type = "serviceAccount"
            member = "monitoring-sa@my-project-id.iam.gserviceaccount.com"
            roles = [
                "roles/monitoring.metricWriter" 
                ]
         }
    }
}