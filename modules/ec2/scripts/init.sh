#!/bin/bash
sudo chmod -R 750 /home/ec2-user/webapp
sudo chown -R /home/ec2-user/webapp
cd  /home/ec2-user/webapp
source .webapp/bin/activate
pip install -r requirements.txt 
screen -S webapp -d -m waitress-serve --call --host=0.0.0.0 'app:create_app'