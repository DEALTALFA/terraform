# terraform
Run the script file **create_key.sh** for creating the key
* For non-root user
`sudo chmod +x create_key.sh && sudo ./create_key.sh`
* For root user
`chmod +x create_key.sh && ./create+key.sh`

* Then run `terraform init ` to initialize a working directory containing Terraform configuration files 

`terraform apply` to make your infrastucture
and you can login with private key created from script file
