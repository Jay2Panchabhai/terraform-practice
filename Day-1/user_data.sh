#!/bin/bash
sodo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo "<h1> Hellluuu from apache2 Server </h1>" > /var/www/html/index.html
sudo systemctl restart httpd