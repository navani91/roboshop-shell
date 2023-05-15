code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}

print_head() {
  echo -e"\e[35m$1\e[0m"
}

status_check() {
  if [ $1 -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
    echo "Read the log file ${log_file}" for more information about error
    exit 1
  fi
}

schema_setup() {
  if [ "${schema_type}" == "mongo" ]; then
  prinet_head "copy mongoDB Repo File"
  cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}
  status_check $?

  prinet_head "Install Mongo Client"
  yum install mongodb-org-shell -y &>>${log_file}
  status_check $?

  print_head "Load Schema"
  mongo --host mongodb.navanidevop.online &>>${log_file}
  status_check $?
 f1

nodejs() {
print_head "Configure NodeJS REPO"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
status_check $?

print_head "Install NodeJS"
yum install nodejs -y &>>${log_file}
status_check $?

print_head "Create Roboshop User"
id roboshop &>>${log_file}
if [ $? -ne 0 ]; then
useradd roboshop &>>${log_file}
fi
status_check $?

print_head "Create Application Directory"
if [ ! -d/app ]; then
   mkdir /app &>>${log_file}
fi
status_check $?

print_head "Delete Old Content"
rm -rf /app/* &>>${log_file}
status_check $?

print_head "Downloading App Content"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
status_check $?
cd /app

print_head "Extracting App Content"
unzip /tmp/${component}.zip &>>${log_file}
status_check $?

print_head "Installing NodeJS Dependencies"
npm install &>>${log_file}
status_check $?

print_head "Copying SystemD service file"
cp ${code_dir}/configs/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
status_check $?

print_head " reload systemd"
systemctl daemon-reload &>>${log_file}
status_check $?

print_head "Enable ${component} service"
systemctl enable ${component} &>>${log_file}
status_check $?

print_head "Start ${component} Service"
systemctl start ${component} &>>${log_file}
status_check $?

schema_setup
}