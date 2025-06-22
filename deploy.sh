#!/bin/bash

# --------------------------------------------
# Static Website Deployment Script (AWS EC2)
# Author: Abdul Ganiyu Sumaila Ali
# --------------------------------------------

# === Configuration ===
KEY_PATH="/absolute/path/to/ec2_deploy_key.pem"  # Full path recommended
EC2_USER="ubuntu"
EC2_HOST="ec2-16-171-253-113.eu-north-1.compute.amazonaws.com"
LOCAL_DIR="website"                              # Your full site folder
REMOTE_TMP_DIR="/home/ubuntu/site-temp"
NGINX_DIR="/var/www/html"
WEBSITE_URL="http://$EC2_HOST/" 

# === Check key and folder existence ===
function check_file_exists() {
  if [ ! -f "$1" ]; then
    echo "❌ Error: File '$1' not found."
    exit 1
  fi
}

function check_folder_exists() {
  if [ ! -d "$1" ]; then
    echo "❌ Error: Folder '$1' not found."
    exit 1
  fi
}

echo "🔍 Validating key and folder..."
check_file_exists "$KEY_PATH"
check_folder_exists "$LOCAL_DIR"

# === Upload entire site directory to EC2 temp location ===
echo "📤 Uploading '$LOCAL_DIR' to EC2..."
scp -i "$KEY_PATH" -r "$LOCAL_DIR" "$EC2_USER@$EC2_HOST:$REMOTE_TMP_DIR"
if [ $? -ne 0 ]; then
  echo "❌ SCP failed. Check your key and connection."
  exit 1
fi

# === Deploy to NGINX directory ===
echo "🔧 Deploying site content..."
ssh -i "$KEY_PATH" "$EC2_USER@$EC2_HOST" << EOF
  sudo rm -rf "$NGINX_DIR"/*
  sudo cp -r "$REMOTE_TMP_DIR"/* "$NGINX_DIR/"
  sudo chown -R www-data:www-data "$NGINX_DIR"
  sudo systemctl restart nginx
EOF

# === Done ===
echo "✅ Deployment successful!"
echo "🌐 Live at: $WEBSITE_URL"

