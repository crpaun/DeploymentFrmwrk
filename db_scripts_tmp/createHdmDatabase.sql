create database hdm_db;

#drop user 'hdmuser'@'172.16.65.219';
#flush privileges;
CREATE USER 'hdmuser'@'172.16.65.219' IDENTIFIED BY 'hdmuserpw';
FLUSH PRIVILEGES;

grant all privileges on hdm_db.* to hdmuser1@172.16.65.219 identified by 'hdmuserpw';
flush privileges;

commit;