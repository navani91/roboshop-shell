source common.sh

mysql_root_password=$1
if [ "${mysql_root_password}" == "mysql" ]; then
  echo -e "\e[31m Missing My SQL Root Password argument\e[om"
  exit 1
f1

component=shipping
schema_type="mysql"
java



