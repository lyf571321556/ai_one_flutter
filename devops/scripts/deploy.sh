#! /usr/bin/env bash
set -e

host=$DEV_ONLINE_HOST
ssh_port=$DEV_ONLINE_SSH_PORT
user=$DEV_ONLINE_USER
data_path=$DEV_ONLINE_DATA_PATH

pkg="ones-mobile-web-$BRANCH_NAME-assets.tar.gz"

echo "Deliver assets to $1 env."

if [ $1 == 'production' ]; then
  host=$PRODUCTION_HOST
  ssh_port=$PRODUCTION_SSH_PORT
  user=$PRODUCTION_USER
  data_path=$PRODUCTION_DATA_PATH
fi

# Upload web assets to dev online server
# echo "rsync -vaz --progress '-e ssh -p '$ssh_port $pkg $user@$host:$data_path/"
echo  $ssh_port  $pkg   $user $host $data_path
rsync -vaz --progress '-e ssh -p '$ssh_port $pkg $user@$host:$data_path/

# Check exit status of previous command
if [ $? != 0 ]; then
  exit 1
fi

# Deploy
if [ $1 == 'development_online' ]; then
  echo 'Deploying...'
  ssh -p $ssh_port $user@$host \
    "cd $data_path && rm -rf $BRANCH_NAME && mkdir $BRANCH_NAME && tar -zxf $pkg -C $BRANCH_NAME && rm -rf $pkg"

  # Check exit status of previous command
  if [ $? != 0 ]; then
    exit 1
  fi
fi
