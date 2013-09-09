use hdm_db;

#insert data into the location table
INSERT INTO locations (location_name) VALUES
	('CLJ'),('TIM');

#insert data into the roles table:the role having the id 1 is user and 2 is admin
INSERT INTO roles (role) VALUES
	('User'),('Admin'),('SuperAdmin');

#insert data into the status table:1:Availaable,2:Rented,3:Ordered,4:Broken;5.Pending Rent; 6.Pending Release
INSERT INTO status (status_type) VALUES
	('Available'),('Rented'),('Ordered'),('Broken'),('Pending Rent'),('Pending Release');

#insert the admin (which can not be deleted) into the users table
INSERT INTO users (username,password,first_name,last_name,role_id,location_id,count_login,reset_password_date) VALUES
	('hdmadmin@3pillarglobal.com','5f4dcc3b5aa765d61d8327deb882cf99','Admin','Admin',3,1,0,null),

#insert the first category on the first level   
INSERT INTO categories(category_name,parent_node_id,depth_of_category,lineage,max_period) VALUES
		('FirstCategory',null,0,'/1/',30);