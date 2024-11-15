# Terraform AWS EC2 & EBS Automation

## Overview
This repository contains Terraform configuration files to automate the provisioning of AWS infrastructure. The project launches an EC2 instance, attaches an EBS volume, and uses provisioners to configure the server with Apache and deploy a simple web page.

## Features
- 🚀 **Launches an EC2 instance** using a specified AMI.
- 📦 **Creates and attaches an EBS volume** to the instance.
- 🔧 **Automates server provisioning** with `null_resource` and `remote-exec` to:
  - Format the attached volume
  - Install and configure Apache web server
  - Create an index.html file with a welcome message
  - Restart the Apache service
- 🌐 **Opens the instance's public IP in the browser** using `local-exec`.

## Prerequisites
Make sure you have the following installed:
- [Terraform](https://www.terraform.io/downloads)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- An AWS account with necessary access permissions
- A valid AWS key pair (`aws_tf_key_training.pem`)

## Usage
1. **Clone the Repository**
   ```bash
   git clone https://github.com/vaibhav208/terraform-aws-ec2-ebs-automation.git
   cd terraform-aws-ec2-ebs-automation
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Review the Plan**
   ```bash
   terraform plan
   ```

4. **Apply the Configuration**
   ```bash
   terraform apply -auto-approve
   ```

5. **Access the Web Server**
   - Once the provisioning is complete, your default browser will automatically open with the public IP of the instance.
   - Alternatively, you can find the public IP in the Terraform output.

## Configuration Details
### `provider.tf`
Configures the AWS provider to use the `ap-south-1` region.

### `main.tf`
- **EC2 Instance**: Launches a `t2.micro` instance with the specified AMI.
- **EBS Volume**: Creates a 2GB EBS volume and attaches it to the EC2 instance.
- **Provisioners**:
  - `remote-exec`: Sets up the instance, installs Apache, and serves a simple HTML page.
  - `local-exec`: Opens the web page in your browser automatically after deployment.

## Cleanup
To destroy the resources and avoid incurring unnecessary costs:
```bash
terraform destroy -auto-approve
```

## File Structure
```
.
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## Notes
- Ensure that your `.pem` file is properly configured with the correct path in the `connection` block.
- The security group specified should allow SSH and HTTP access.
