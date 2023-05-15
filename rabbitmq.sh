source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
  echo -e "\e[31m Missing My SQL Root Password argument\e[om"
  exit 1
  fi

print_head "Setup RabbitMQ Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${log_file}
status_check $?

print_head "Install earlang & RabbitMQ"
yum install rabbitmq-server erlang - &>>${log_file}
status_check $?

print_head "Enable RabbitMQ Server"
systemctl enable rabbitmq-server &>>${log_file}
status_check $?

print_head "Start RabbitMQ Server"
systemctl start rabbitmq-server &>>${log_file}
status_check $?

print_head "Add Appilication User"
rabbitmqctl add_user roboshop roboshop123 &>>${log_file}
status_check $?

print_head "Configure Permissions for App User"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log_file}
status_check $?