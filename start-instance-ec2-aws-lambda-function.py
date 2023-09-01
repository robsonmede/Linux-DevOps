import boto3
import sys, traceback
from datetime import datetime
from time import sleep

def start_ec2_instances():
    start_time = datetime.now()

    # starting ec2 client
    ec2_client = boto3.client('i-0689a955727b235d4')

    regions = ec2_client.describe_regions()

    for region in regions['sa-east-1']:
        try:
            print("Region: " + str(region['sa-east-1']))
            ec2_client = boto3.client('ec2', region_name=region['sa-east-1'])
            instances = ec2_client.describe_instances()
            instanceIds = list()
            
            for reservation in instances['Reservations']:
                for instance in reservation['Instances']:
                    if instance['State']['Name'] == "stopped" and not instance['Tags'] is None : 
                        for tag in instance['Tags']:
                            try:
                                if tag['Key'] == 'ScheduledStartStop' and tag['Value'] == 'True'    :
                                    instanceIds.append(instance['InstanceId'])
                            except:
                                print "Not expected error: ", traceback.print_exc()
                      
            if len(instanceIds) > 0 : 
                print "Starting instances: " + str(instanceIds)
                ec2_client.start_instances(InstanceIds=instanceIds)                                                   
                                                            
        except:
            print "Not expected error:", traceback.print_exc()
                                                           
    end_time = datetime.now()
    took_time = end_time - start_time
    print "Total time of execution: " + str(took_time)    

def lambda_handler(event, context):
    print('Starting instances... ')
    start_ec2_instances()
