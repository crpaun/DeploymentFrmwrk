use hdm_db;

CREATE TABLE brands(
id_brand INTEGER NOT NULL AUTO_INCREMENT,
brand_name CHAR(50) NOT NULL,
PRIMARY KEY (id_brand)
);

CREATE TABLE models(
id_model INTEGER NOT NULL AUTO_INCREMENT,
model_name CHAR(50) NOT NULL,
brand_id INTEGER,
PRIMARY KEY(id_model),
FOREIGN KEY(brand_id) REFERENCES brands(id_brand)
	 ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE roles(
id_role INTEGER NOT NULL AUTO_INCREMENT,
role CHAR(50) NOT NULL,
PRIMARY KEY(id_role)
);

CREATE TABLE locations(
id_location INTEGER NOT NULL AUTO_INCREMENT,
location_name CHAR(50) NOT NULL,
PRIMARY KEY(id_location)
);
CREATE TABLE users(
id_user INTEGER NOT NULL AUTO_INCREMENT,
username CHAR(50) NOT NULL UNIQUE,
password CHAR(50) NOT NULL,
first_name CHAR(50) NOT NULL,
last_name CHAR(50) NOT NULL,
role_id INTEGER,
location_id INTEGER,
count_login INTEGER,
reset_password_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY(id_user),
FOREIGN KEY(role_id) REFERENCES roles(id_role)
	 ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(location_id) REFERENCES locations(id_location)
	 ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE operating_systems(
id_operating_system INTEGER NOT NULL AUTO_INCREMENT,
operating_system_name CHAR(50) NOT NULL,
PRIMARY KEY(id_operating_system)
);

CREATE TABLE operating_system_versions(
id_operating_system_version INTEGER NOT NULL AUTO_INCREMENT,
operating_system_version_name CHAR(50) NOT NULL,
operating_system_id INTEGER,
PRIMARY KEY(id_operating_system_version),
FOREIGN KEY(operating_system_id) REFERENCES operating_systems(id_operating_system)
	 ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE status(
id_status INTEGER NOT NULL AUTO_INCREMENT,
status_type CHAR(50) NOT NULL,
PRIMARY KEY(id_status)
);

CREATE TABLE categories(
id_category INTEGER NOT NULL AUTO_INCREMENT,
category_name CHAR(50) NOT NULL,
parent_node_id INTEGER,
depth_of_category INTEGER,
max_period INTEGER NOT NULL,
lineage CHAR(50),
PRIMARY KEY(id_category),
FOREIGN KEY (parent_node_id) REFERENCES categories(id_category)
	 ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE products(
id_product INTEGER NOT NULL AUTO_INCREMENT,
description TINYTEXT DEFAULT NULL,
model_id INTEGER,
category_id INTEGER,
operating_system_version_id INTEGER,
status_id INTEGER,
location_id INTEGER,
serial_number CHAR(50),
qa_code CHAR(50) UNIQUE,
PRIMARY KEY(id_product),
FOREIGN KEY(model_id) REFERENCES models(id_model)
	 ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(category_id) REFERENCES categories(id_category)
	 ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(operating_system_version_id) REFERENCES operating_system_versions(id_operating_system_version)
	 ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(status_id) REFERENCES status(id_status)
	 ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(location_id) REFERENCES locations(id_location)
	 ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE rentals(
id_rental INTEGER NOT NULL AUTO_INCREMENT,
product_id INTEGER,
user_id INTEGER,
request_date timestamp,
approve_date timestamp,
end_date timestamp,
is_active boolean not null default false,
PRIMARY KEY (id_rental),
FOREIGN KEY(user_id) REFERENCES users(id_user)
	 ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(product_id) REFERENCES products(id_product)
	 ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE product_filters(
id_filter INTEGER NOT NULL AUTO_INCREMENT,
fil_name CHAR(50) UNIQUE,
fil_description TINYTEXT DEFAULT NULL,
user_id INTEGER,

fil_model CHAR(50),
fil_brand CHAR(50),
fil_operating_system CHAR(50),
fil_operating_system_version CHAR(50),
fil_serial_number CHAR(50),
fil_status CHAR(50),
fil_rental_owner CHAR(50),


fil_category_id INTEGER,

fil_item CHAR(50),
fil_mode CHAR(50),
fil_items_per_page INTEGER,

PRIMARY KEY (id_filter),
FOREIGN KEY(user_id) REFERENCES users(id_user)
	 ON DELETE CASCADE ON UPDATE CASCADE
);