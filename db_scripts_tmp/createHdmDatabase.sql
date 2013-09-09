create database hdm_db1;

#drop user 'hdmuser'@'172.16.65.219';
#flush privileges;
CREATE USER 'hdmuser1'@'172.16.65.219' IDENTIFIED BY 'hdmuserpw';
FLUSH PRIVILEGES;

grant all privileges on hdm_db1.* to hdmuser1@172.16.65.219 identified by 'hdmuserpw';
flush privileges;

commit;