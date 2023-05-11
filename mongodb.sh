source common.sh

print_head "Setup mongoDb Ripository"
cp configs/mongodb.repo /etc/yum.repos.d/mongo.repo

print_head "Install mongoDB"
yum install mongodb-org -y

print_head "Enable mongoDB"
systemctl enable mongod

print_head "Start mongoDB Service"
systemctl start mongod

# update /etc/mongod.conf file from 127.0.0.1 with 0.0.0.0
