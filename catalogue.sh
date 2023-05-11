source common.sh
print_head "Configure NodeJS REPO"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

print_head "iNSTALL NodeJS"
yum install nodejs -y &>>${log_file}

print_head "Create Roboshop User"
useradd roboshop &>>${log_file}

print_head "Create Application Directory"
mkdir /app &>>${log_file}

print_head "Delete Old Content"
rm -rf /app/* &>>${log_file}

print_head "Downloading App Content"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}
cd /app

print_head "Extracting App Content"
unzip /tmp/catalogue.zip &>>${log_file}

print_head "Installing NodeJS Dependencies"
npm install &>>${log_file}

print_head "Copying SystemD service file"
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}

print_head " reload systemd"
systemctl daemon-reload &>>${log_file}

print_head "Enable Catalogue service"
systemctl enable catalogue &>>${log_file}

print_head "Start catalogue Service"
systemctl start catalogue &>>${log_file}

print_head " Copy mongoDB Repo File"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

print_head "Install mongo Client"
yum install mongodb-org-shell -y &>>${log_file}

print_head "load schema"
mongo --host mongodb.navanidevops.online </app/schema/catalogue.js &>>${log_file}
