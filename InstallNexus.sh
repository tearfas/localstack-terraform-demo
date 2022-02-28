#! /bin/bash

# Install Java
yum install java-1.8.0-openjdk.x86_64 -y

# Update the packages
yum update –y
yum -y install wget
# Download Nexus
cd /opt/
wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
# Unzip/Untar the compressed file
tar xf latest-unix.tar.gz
# Rename folder for ease of use
mv nexus-3.* nexus3
# Enable permission for ec2-user to work on nexus3 and sonatype-work folders
chown -R centos:centos nexus3/ sonatype-work/
# Create a file called nexus.rc and add run as ec2-user
cd /opt/nexus3/bin/
touch nexus.rc
echo 'run_as_user="centos"' | sudo tee -a /opt/nexus3/bin/nexus.rc
# Add nexus as a service at boot time
ln -s /opt/nexus3/bin/nexus /etc/init.d/nexus
cd /etc/init.d
#chkconfig --add nexus
#chkconfig --levels 345 nexus on
# Start Nexus
systemctl start nexus
systemctl enable nexus

firewall-cmd --add-port=8081/tcp --permanent
firewall-cmd --reload

wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm 
yum -y localinstall amazon-ssm-agent.rpm

systemctl enable amazon-ssm-agent --now