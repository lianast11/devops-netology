locals { 
    web_instance_type_map = {
        stage = "t3.micro"
        prod = "t3.large" 
    }
}
resource "aws_instance" "web" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = local.web_instance_type_map[terraform.workspace]
}