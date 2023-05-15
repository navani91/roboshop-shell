source common.sh

mysql_root_password=$!
if [ -z "${mysql_root_password}" ]; then
  echo -e "\e[31m Missing My SQL Root Password argument\e[om"
  exit 1
f1

print_head " Disabling MYSQL 8 version"
dnf module disable mysql -y
status_check $?

print_head "Installing MYSQL Server"
yum install mysql-community-server -y
status_check $?

print_head "Enable MYSQL Service"
systemctl enable mysqld
status_check $?

print_head "Start MYSQL Service"
systemctl start mysqld
status_check $?

print_head "Set Root Password"
mysql_secure_installation --set-root-pass RoboShop@1
status_check $?



