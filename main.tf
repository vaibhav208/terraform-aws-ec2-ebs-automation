provider "aws"{
	region = "ap-south-1"
}

resource "aws_instance" "myweb" {
	ami = "ami-001843b876406202a"
	instance_type = "t2.micro"
	key_name = "aws_tf_key_training"
	security_groups = [ "my_tf_sg_web_ssh_allow" ]
	tags = {
		Name = "LW Web Server"
	}
}


resource "aws_ebs_volume" "ebs1" {
	availability_zone = aws_instance.myweb.availability_zone
	size = 2
	tags = {
		Name = " LW Web Server Extra Volume "
	}
}

resource "aws_volume_attachment" "ebs_att"{
	device_name = "/dev/sdh"
	volume_id = aws_ebs_volume.ebs1.id
	instance_id = aws_instance.myweb.id
}

resource "null_resource" "nullremote1" {
  provisioner "remote-exec" {
    inline = [
      "sudo mkfs.xfs /dev/xvdh",
      "sudo yum install httpd -y",
      "sudo mount /dev/xvdh /var/www/html",
      "sudo sh -c 'echo 'welcome to LW' > /var/www/html/index.html'",
      "sudo systemctl restart httpd"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/vaibhav/Downloads/aws_tf_key_training.pem")
    host        = aws_instance.myweb.public_ip
  }
}

resource "null_resource" "nulllocalchrome" {

provisioner "local-exec" {
  command = "start chrome http://${aws_instance.myweb.public_ip}"
}
}
