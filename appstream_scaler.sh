#!/bin/bash

###########################################################################
## AppStream Scaling Script
## We wrote this because timed scaling didn't want to work in the web GUI
## Script will run in a cron with passed in parameters
## 
## Nick Plank
## St. Norbert College
## 03/11/2021
###########################################################################

# $1 = fleet name
# $2 = min value
# $3 = max value

/usr/local/bin/aws application-autoscaling register-scalable-target --service-namespace appstream --resource-id fleet/$1 --scalable-dimension appstream:fleet:DesiredCapacity --min-capacity $2 --max-capacity $3


