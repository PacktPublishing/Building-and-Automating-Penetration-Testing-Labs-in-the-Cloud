#!/bin/bash

sudo -u ec2-user -i <<EOF
  cd /home/ec2-user/SageMaker

  wget https://raw.githubusercontent.com/PacktPublishing/Building-Penetration-Testing-Labs-in-the-Cloud/main/ch07/Lab%2000.ipynb

  mkdir -p scripts && cd scripts
  wget https://github.com/PacktPublishing/Building-Penetration-Testing-Labs-in-the-Cloud/blob/main/ch07/scripts/inference.py
  wget https://github.com/PacktPublishing/Building-Penetration-Testing-Labs-in-the-Cloud/blob/main/ch07/scripts/requirements.txt
  wget https://github.com/PacktPublishing/Building-Penetration-Testing-Labs-in-the-Cloud/blob/main/ch07/scripts/setup.py
EOF
