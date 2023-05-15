source common.sh

mysql_root_password=$!
if [ -z "${mysql_root_password}" ]; then
  echo -e "\e[31m Missing My SQL Root Password argument\e[om"
  exit 1
f1

print_head " Disabling MYSQL 8 version"
dnf module disable mysql -y &>>${log_file}
status_check $?

print_head "copy MYSQL Repo File"
CP ${code_dir}/configs/mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}
status_check $?

print_head "Installing MYSQL Server"
yum install mysql-community-server -y &>>${log_file}
status_check $?

print_head "Enable MYSQL Service"
systemctl enable mysqld &>>${log_file}
status_check $?

print_head "Start MYSQL Service"
systemctl start mysqld &>>${log_file}
status_check $?

print_head "Set Root Password"
mysql_secure_installation --set-root-pass RoboShop@1 &>>${log_file}
status_check $?

