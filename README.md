# ☁️ AWS Static Website - Capstone Project

This is a static website hosted on an AWS EC2 instance using an NGINX web server. It was built as part of the **Techcrush Cloud Computing Bootcamp Capstone Project** by **Abdul Ganiyu Sumaila Ali**.

---

## 💡 Project Overview

This capstone project demonstrates how to:

- Launch and configure an EC2 instance on AWS
- Set up NGINX as a web server for static content
- Deploy updates automatically using GitHub Actions
- Manage SSH keys and secure EC2 access
- Work with the Linux terminal and Bash
- Understand basic DevOps automation with CI/CD

---

## 🧰 Tools & Technologies

- **AWS EC2 (Ubuntu)**
- **NGINX**
- **Git & GitHub**
- **GitHub Actions (CI/CD)**
- **Linux CLI & Bash**
- **SSH (key-based login)**
- **HTML5 / CSS3**

---

## 🚀 Deployment Steps (Manual)

1. **Launch an EC2 Instance**  
   - Ubuntu 22.04 LTS  
   - t2.micro (Free Tier)  
   - Use your key: `"Abdul's key.pem"`

2. **Connect via SSH**
   ```bash
   ssh -i "Abdul's key.pem" ubuntu@ec2-16-171-253-113.eu-north-1.compute.amazonaws.com