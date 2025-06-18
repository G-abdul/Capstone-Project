# AWS Static Website - Capstone Project

This is a static website hosted on an AWS EC2 instance using an NGINX web server. It was built as part of the Techcrush Cloud Computing Bootcamp Capstone Project.

## 💡 What This Project Demonstrates

- Deploying a static website to a cloud server
- Using EC2 to host applications
- Setting up and configuring NGINX
- SSH key-based authentication
- Working with Linux CLI
- Managing security groups on AWS

## 🔧 Tools & Technologies

- AWS EC2
- NGINX
- SSH
- Ubuntu Linux
- HTML5 / CSS3
- Git & GitHub

## 🛠 How to Deploy

1. Launch an EC2 instance (Ubuntu, t2.micro)
2. SSH into your server
3. Install NGINX: `sudo apt update && sudo apt install nginx -y`
4. Upload `index.html`
5. Replace default NGINX index: `sudo mv index.html /var/www/html/index.html`
6. Restart NGINX: `sudo systemctl restart nginx`

## 🌐 Live Preview

Site is hosted at: `http://51.20.254.14/

---
