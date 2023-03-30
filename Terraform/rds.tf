module "db" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = "petclinic"

  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = var.db_instance_type
  allocated_storage = 5
  availability_zone = "${var.aws_region}a"

  db_name  = var.db_name
  username = var.db_user
  password = data.aws_ssm_parameter.dbpassword.value
  port     = "3306"
  multi_az = false
  publicly_accessible = false
  skip_final_snapshot = true


  iam_database_authentication_enabled = true

  vpc_security_group_ids = [aws_security_group.db-sg.id]

  tags = {
    Name = "${var.stack}-db"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = module.vpc.public_subnets

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"
}

output "db_host" {
  value = module.db.db_instance_address
}

output "db_port" {
  value = module.db.db_instance_port
}

output "db_url" {
  value = "jdbc:mysql://${module.db.db_instance_address}/${var.db_name}"
}
