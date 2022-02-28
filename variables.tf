variable "cidr_block" {
  type = list(string)  # A list of Strings
  default = ["10.0.0.0/16","10.0.0.0/24","0.0.0.0/0"]
}

variable "ports" {
  type = list(number) # A list of numbers
  default = [80,22,443,8080,8081]
}

variable "ami" {
  type = string
  default = "ami-bb9a6bc2"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "instance_type_nuxus" {
  type = string
  default = "t2.medium"
}
