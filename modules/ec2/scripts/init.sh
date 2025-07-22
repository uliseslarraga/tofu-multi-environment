#!/bin/bash
echo "Starting Cloudwatch Agent"
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json \
  -s
echo "Initializing Web App"  
sudo chmod -R 750 /home/ec2-user/webapp
sudo chown -R /home/ec2-user/webapp
cd  /home/ec2-user/webapp
source .webapp/bin/activate
pip install -r requirements.txt 
screen -S webapp -d -m waitress-serve --call --host=0.0.0.0 'app:create_app'