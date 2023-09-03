Script PURGE

#!/bin/bash -x

echo "###############################################"

WEEK=`date +%Y-%m-%d -d "15 days ago"`

DEAD=`aws s3 ls s3://empresa-backups/app/ --profile default |grep $WEEK |awk '{print$4}'`

aws s3 rm s3://empresa-backups/app/$DEAD --profile default
