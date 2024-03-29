source common.sh

roboshop_app_password=$1
if [ -z "${roboshop_app_password}" ]; then
  echo -e "\e[31m Missing RabbitMQ App User Password argument\e[om"
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
rabbitmqctl list_users | grep roboshop &>>${log_file}
if [ $? -ne 0 ]; then
 rabbitmqctl add_user roboshop ${roboshop_app_password} &>>${log_file}
fi
status_check $?

print_head "Configure Permissions for App User"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log_file}
status_check $?