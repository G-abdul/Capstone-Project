#!/bin/bash

# --------------------------------------------
# Static Website Deployment Script (AWS EC2)
# Author: Abdul Ganiyu Sumaila Ali
# --------------------------------------------

# === Configuration ===
KEY_PATH="./aws"                             # Your private key file (aws.pem)
EC2_USER="ubuntu"
EC2_IP="51.20.254.14"
REMOTE="$EC2_USER@$EC2_IP"
LOCAL_FILE="index.html"
REMOTE_DIR="/home/ubuntu"
NGINX_DIR="/var/www/html"
WEBSITE_URL="http://$EC2_IP/"

# === Helper Functions ===
function check_file_exists() {
  if [ ! -f "$1" ]; then
    echo "❌ Error: File '$1' not found."
    exit 1
  fi
}

# === Step 1: Check required files ===
echo "🔍 Checking for required files..."
check_file_exists "$KEY_PATH"
check_file_exists "$LOCAL_FILE"

# === Step 2: Upload website file to EC2 ===
echo "📤 Uploading '$LOCAL_FILE' to EC2..."
scp -i "$KEY_PATH" "$LOCAL_FILE" "$REMOTE:$REMOTE_DIR/"
if [ $? -ne 0 ]; then
  echo "❌ File upload failed. Aborting."
  exit 1
fi

# === Step 3: SSH into EC2 and deploy to NGINX ===
echo "🔧 Configuring web server..."
ssh -i "$KEY_PATH" "$REMOTE" << EOF
  sudo mv "$REMOTE_DIR/index.html" "$NGINX_DIR/index.html"
  sudo chown www-data:www-data "$NGINX_DIR/index.html"
  sudo systemctl restart nginx
EOF

# === Done ===
echo "✅ Deployment complete!"
echo "🌐 Visit your site at: $WEBSITE_URL"
