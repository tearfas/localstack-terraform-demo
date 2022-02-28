#!/bin/bash
yum -y install wget
wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm 
yum -y localinstall amazon-ssm-agent.rpm

systemctl enable amazon-ssm-agent --now