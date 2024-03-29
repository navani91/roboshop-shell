source common.sh

print_head "Installing Redis Repo Files"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${log_file}
status_check $?

print_head "ENABLE 6.2 Redis Repo"
dnf module enable redis:remi-6.2 -y &>>${log_file}
status_check $?

print_head "Install Redis"
yum install redis -y &>>${log_file}
status_check $?

print_head"update Reids Listen Address"
sed -i -e's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>${log_file}
status_check $?

print_head "Enable Redis"
systemctl enable redis &>>${log_file}
status_check $?

print_head "Start Redis"
systemctl start redis &>>${log_file}
status_check $?
