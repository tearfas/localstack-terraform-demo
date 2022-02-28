#!/bin/bash

# Install Java

sudo yum install java-1.8.0-openjdk-devel -y

#Download and Install Jenkins

curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo

sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

sudo yum install jenkins -y --nogpgcheck

#Start and enable Jenkins

sudo systemctl start jenkins
sudo systemctl enable jenkins

#Install git

sudo yum -y install git

wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm 
yum -y localinstall amazon-ssm-agent.rpm

systemctl enable amazon-ssm-agent --now