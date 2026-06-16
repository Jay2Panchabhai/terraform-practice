#!/bin/bash
sudo yum install httpd -y
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
sudo echo "<h1> Hello Apache2! </h1>" > /var/www/html/index.html
sudo systemctl restart httpd.service