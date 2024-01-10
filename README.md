# devops-assignment

## folder q1 contains files for the following
1. Take any sample hello world application from the internet or build a simple one of your own.
Write a dockerfile and package it into a docker image. Build the docker image and push it to the docker hub using terraform.

## folder q2 contains files for the following
Build a 3-tier VPC with public and private subnets in each availability zone and deploy an EKS cluster in the above VPC.

## file q2/application.tf contains solution for following
Create a k8s namespace - "exercise", 
Deploy 2 replicas of pods from the above built image in the "exercise" namespace, and 
Expose the deployment using service type LoadBalancer and share the endpoint.

## file scripting_exercise  contains solution for following

Write a python/perl/golang script  which takes a list of SSL secured domain names and port as an input, check if the SSL certificate is getting expired in less than 15 days, send an email or slack alert if the SSL certificate is getting expired in days < 15.

## Solution screenshots are included in the pdf file
