data "terraform_remote_state" "sg" {
  backend = "local"

  config = {
    path = "../sg/terraform.tfstate"
  }
}

data "terraform_remote_state" "subnet" {
  backend = "local"
  config = {
    path = "../subnet/terraform.tfstate"
  }
}