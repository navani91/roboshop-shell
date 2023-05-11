source common.sh
print_head "Configure NodeJS REPO"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
status_check $?

print_head "iNSTALL NodeJS"
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
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}
cd /app
status_check $?

print_head "Extracting App Content"
unzip /tmp/catalogue.zip &>>${log_file}
status_check $?

print_head "Installing NodeJS Dependencies"
npm install &>>${log_file}
status_check $?

print_head "Copying SystemD service file"
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}
status_check $?

print_head " reload systemd"
systemctl daemon-reload &>>${log_file}
status_check $?

print_head "Enable Catalogue service"
systemctl enable catalogue &>>${log_file}
status_check $?

print_head "Start catalogue Service"
systemctl start catalogue &>>${log_file}
status_check $?

print_head " Copy mongoDB Repo File"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}
status_check $?

print_head "Install mongo Client"
yum install mongodb-org-shell -y &>>${log_file}
status_check $?

print_head "load schema"
mongo --host mongodb.navanidevops.online </app/schema/catalogue.js &>>${log_file}
status_check $?
