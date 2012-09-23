PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE tags (
	id INTEGER NOT NULL, 
	name VARCHAR, 
	"entryNum" INTEGER, 
	PRIMARY KEY (id)
);
CREATE TABLE categories (
	id INTEGER NOT NULL, 
	name VARCHAR, 
	slug VARCHAR, 
	"entryNum" INTEGER, 
	"createdTime" DATETIME, 
	"modifiedTime" DATETIME, 
	PRIMARY KEY (id)
);
CREATE TABLE admins (
	id INTEGER NOT NULL, 
	username VARCHAR, 
	passwd VARCHAR, 
	PRIMARY KEY (id)
);
CREATE TABLE links (
	id INTEGER NOT NULL, 
	name VARCHAR, 
	url VARCHAR, 
	description VARCHAR, 
	"createdTime" DATETIME, 
	PRIMARY KEY (id)
);
CREATE TABLE user (
	id INTEGER NOT NULL, 
	username VARCHAR(100), 
	passwd VARCHAR(50), 
	PRIMARY KEY (id)
);
CREATE TABLE entries (
	id INTEGER NOT NULL, 
	title VARCHAR, 
	slug VARCHAR, 
	content TEXT, 
	"viewNum" INTEGER, 
	"commentNum" INTEGER, 
	"createdTime" DATETIME, 
	"modifiedTime" DATETIME, 
	"categoryId" INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY("categoryId") REFERENCES categories (id)
);
CREATE TABLE entry_tag (
	entry_id INTEGER, 
	tag_id INTEGER, 
	FOREIGN KEY(entry_id) REFERENCES entries (id), 
	FOREIGN KEY(tag_id) REFERENCES tags (id)
);
CREATE TABLE comments (
	id INTEGER NOT NULL, 
	email VARCHAR, 
	username VARCHAR, 
	url VARCHAR, 
	comment TEXT, 
	"createdTime" DATETIME, 
	"entryId" INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY("entryId") REFERENCES entries (id)
);
COMMIT;
