provider "aws" {
  region = "us-east-1"  # Defina sua região da AWS
}

# Definindo variáveis para receber os valores de fora
variable "db_username" {
  description = "O nome de usuário do banco de dados"
  type        = string
  default     = "admin"  # Nome padrão, pode ser alterado
}

variable "db_password" {
  description = "A senha do banco de dados"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "O nome do banco de dados"
  type        = string
  default     = "rappidu"
}

resource "aws_db_instance" "rappidu_db" {
  allocated_storage    = 20      
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  identifier           = var.db_name    
  username             = var.db_username   
  password             = var.db_password   
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = true
  skip_final_snapshot  = true
  storage_type         = "gp2"           
  engine_version       = "8.0"
  backup_retention_period = 7             
}

output "db_endpoint" {
  value = aws_db_instance.rappidu_db.endpoint
}

output "db_username" {
  value = var.db_username
}

output "db_name" {
  value = var.db_name
}