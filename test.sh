#!/bin/bash
# go to root
cd

# ตั้งค่าเขตเวลา, โลคอล ssh รีสตาร์ท บริการ ssh 
ln -fs /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# ลบแพคเก็จไม่จำเป็น,อัพเดท อัพเกรด แพคเก็จในเซอร์เวอร์
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;
apt-get update 
apt-get -y upgrade

# ติดตั้ง/หยุด แพคเก็จที่ที่จำเป็นเกี่ยวเกี่ยวกับ เว็ปเซอร์เวอร์,อัพเดทไฟล์ เอพีที แพคเก็จ
apt-get -y install nginx php5-fpm php5-cli
apt-get -y install nmap nano iptables sysv-rc-conf openvpn vnstat apt-file
apt-get -y install libexpat1-dev libxml-parser-perl
apt-get -y install build-essential
apt-get -y install mysql-server mysql_secure_installation
chown -R mysql:mysql /var/lib/mysql/
chmod -R 755 /var/lib/mysql/
apt-get -y install nginx php5 php5-fpm php5-cli php5-mysql php5-mcrypt
apt-get -y install git
service exim4 stop
sysv-rc-conf exim4 off
apt-file update

# install Vnstat
vnstat -u -i eth0
chown -R vnstat:vnstat /var/lib/vnstat
service vnstat restart

#install Web Server
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old

wget -O /etc/nginx/nginx.conf "https://scripkguza.000webhostapp.com/ocs-panel/nginx.conf"
wget -O /etc/nginx/conf.d/vps.conf "https://scripkguza.000webhostapp.com/ocs-panel/vps.conf"
sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
echo "<pre>Kguza fighter</pre>" > /home/vps/public_html/index.html
useradd -m vps
mkdir -p /home/vps/public_html
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html chmod -R g+rw /home/vps/public_html
service php5-fpm restart
service nginx restart


# install vnstat gui
cd /home/vps/public_html/
wget http://www.sqweek.com/sqweek/files/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
sed -i "s/\$iface_list = array('eth0', 'sixxs');/\$iface_list = array('eth0');/g" config.php
sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
sed -i 's/Internal/Internet/g' config.php
sed -i '/SixXS IPv6/d' config.php
sed -i "s/\$locale = 'en_US.UTF-8';/\$locale = 'en_US.UTF+8';/g" config.php

# install webmin
cd
wget "https://scripkguza.000webhostapp.com/webmin/webmin.html"
bash webmin.html
rm -f webmin.html

# Restart Service
chown -R www-data:www-data /home/vps/public_html
service nginx start

#ocd
mysql -u root -p

#install panel
cd /home/vps/public_html
git init
git remote add origin https://github.com/Wullop/ocs-panel.git
git pull origin master
chmod 777 /home/vps/public_html/application/config/database.php
nano /home/vps/public_html/application/config/database.php
nano /home/vps/public_html/application/config/config.php
apt-get -y install mysql-server
mysql_secure_installation



 #about
 clear
 echo -e "\033[1;32m =============
 Kguza figther
 =============
 login
 xxx.xxx.xxx:81/install
 =============================================
 { Installation }
 { Database Settings }
 Hostname::::localhost
 Username:::::root
 Password:::::12345
 Database Name:::::k6162467_demo

 { Administrator Settings }
 Admin username:::::Admin 
 Admin password:::::Admin 
 Email:::::kguza@windowslive.com
 select:::::Install
 =============================================
 Login:::::xxx.xxx.xxx:81
 =============================================
 credit.  : Dev By kguza
 Facebook : http://kguza.xyz/Facebook
 Line     : http://kguza.xyz/Line
 website :http://kguza.xyz/website
============================================="
echo " VPS AUTO REBOOT 00.00"
echo " ============================================= "
cd
rm -f Ocs-D8.html
rm -f cd /home/debian/Ocs-D8.html
