#!/bin/bash

# -------------------------------
# Update System
# -------------------------------
echo "🔄 Updating package list..."
sudo apt update -y

# -------------------------------
# Install Java (required by Jenkins)
# -------------------------------
echo "☕ Installing Java (OpenJDK 17)..."
sudo apt install openjdk-17-jre openjdk-17-jdk -y
java --version

# -------------------------------
# Install Jenkins
# -------------------------------
echo "⚙️ Installing Jenkins..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update -y
sudo apt install jenkins -y

# -------------------------------
# Install Docker
# -------------------------------
echo "🐳 Installing Docker..."
sudo apt install docker.io -y
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
sudo systemctl restart docker
sudo chmod 777 /var/run/docker.sock

# -------------------------------
# Option: Run Jenkins in Docker
# -------------------------------
# docker run -d -p 8080:8080 -p 50000:50000 --name jenkins-container jenkins/jenkins:lts

# -------------------------------
# Run SonarQube via Docker
# -------------------------------
echo "📦 Running SonarQube container..."
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

# -------------------------------
# Install AWS CLI
# -------------------------------
echo "☁️ Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install

# -------------------------------
# Install kubectl
# -------------------------------
echo "🚀 Installing kubectl..."
sudo apt install curl -y
curl -LO "https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client

# -------------------------------
# Install Terraform
# -------------------------------
echo "🌍 Installing Terraform..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform -y

# -------------------------------
# Install Trivy
# -------------------------------
echo "🔍 Installing Trivy..."
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt update
sudo apt install trivy -y