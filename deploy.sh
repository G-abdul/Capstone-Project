#!/bin/bash

# --------------------------------------------
# Static Website Deployment Script (AWS EC2)
# Author: Abdul Ganiyu Sumaila Ali
# --------------------------------------------

# === Configuration ===
KEY_PATH="./Abdul's key.pem"                 # Your PEM file path
EC2_USER="ubuntu"
EC2_HOST="ec2-16-171-253-113.eu-north-1.compute.amazonaws.com"
LOCAL_FILE="index.html"
REMOTE_DIR="/home/ubuntu"
NGINX_DIR="/var/www/html"
WEBSITE_URL="http://$EC2_HOST/"

# === Helper: Check if a file exists ===
function check_file_exists() {
  if [ ! -f "$1" ]; then
    echo "❌ Error: File '$1' not found. Make sure it's in the correct directory."
    exit 1
  fi
}

# === Step 1: Validate required files ===
echo "🔍 Validating files..."
check_file_exists "$KEY_PATH"
check_file_exists "$LOCAL_FILE"

# === Step 2: Upload index.html to EC2 ===
echo "📤 Uploading '$LOCAL_FILE' to $EC2_HOST..."
scp -i "$KEY_PATH" "$LOCAL_FILE" "$EC2_USER@$EC2_HOST:$REMOTE_DIR/"
if [ $? -ne 0 ]; then
  echo "❌ SCP failed. Please check your internet, IP, or key."
  exit 1
fi

# === Step 3: SSH into EC2 and deploy ===
echo "🔧 Moving file into NGINX directory and restarting service..."
ssh -i "$KEY_PATH" "$EC2_USER@$EC2_HOST" << EOF
  sudo mv "$REMOTE_DIR/index.html" "$NGINX_DIR/index.html"
  sudo chown www-data:www-data "$NGINX_DIR/index.html"
  sudo systemctl restart nginx
EOF

# === Final Message ===
echo "✅ Deployment successful!"
echo "🌐 Website is live at: $WEBSITE_URL"
