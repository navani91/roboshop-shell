source common.sh

roboshop_app_password=$1
if [ -z "${roboshop_app_password}" ]; then
  echo -e "\e[31m Missing RabbitMQ App User Password argument\e[om"
  exit 1
  fi

component=catalogue
python