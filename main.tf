module "ec2" {
for_each     = var.instances
  source     = "./modules/ec2"
  env        = var.env
  app_port   = each.value["app-port"]
component_name = each.key
instance_type = each.key ["instance_type"]
}




