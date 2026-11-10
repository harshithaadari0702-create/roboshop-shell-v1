#!/bin/bash

ami_id="ami-0055977a6e828a4f4"
instance_type="t3.micro"
domain_name="harshi.shop"
hosted_zone_id="Z01187903A648O4CSBUC"

for instance in $@
do
    echo "creating instance: $instance"
    instance_id=$(aws ec2 run-instances \
            --image-id $ami_id \
            --instance-type $instance_type \
            --security-groups "roboshop-common" "roboshop-$instance" \
            --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=roboshop-$instance}]" \
            --query 'Instances[0].InstanceId' \
            --output text)

echo "$instance id is : $instance_id"

done

