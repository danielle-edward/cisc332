create database animalRescue;
use animalRescue;
create table person
	(fname		varchar(25)not null,
	 lname		varchar(35)not null,
	 street		varchar(100)not null,
	 city 		varchar(100)not null,
	 primary key (fname,lname)
	);

create table adopter
	(fname		varchar(25),
	 lname		varchar(35),
	 primary key (fname,lname),
	 foreign key (fname, lname) references person(fname,lname)
);

create table animal
	(id int AUTO_INCREMENT not null primary key,
	 type		varchar(10),
	 name		varchar(20),
	 adoption	bit(1)
	);

create table vet_visit(
	animal_ID	int not null,
	vet_name	varchar(50) not null,
	a_condition	varchar(150),
	weight		decimal(3,2),
	visit_date	date not null,
	primary key (animal_ID, vet_name, visit_date),
	foreign key (animal_ID) references animal(id) on delete cascade
);

create table location(
	business_name 	varchar(50) not null primary key,
	street 		varchar(100),
	city 		varchar(100)
);

create table animal_location(
	animal_id 	int not null,
	business_name 	varchar(50),
	arrival_date 	date not null,
	departure_date 	date,
	primary key (business_name, animal_id, arrival_date),
	foreign key (business_name) references location(business_name),
	foreign key (animal_id) references animal(id)
);

create table rescue(
	business_name 	varchar(25) not null primary key,
	foreign key (business_name) references location(business_name)
);

create table SPCA(
	business_name 	varchar(25) not null primary key,
	foreign key (business_name) references location(business_name)
);

create table shelter(
	business_name 	varchar(25) not null primary key,
	url 		varchar(150) not null,
	capacity 	integer not null,
	foreign key (business_name) references location(business_name)
);

create table employees(
	business_name 	varchar(25) not null,
	fname 		varchar(25) not null,
	lname 		varchar(35) not null,
	primary key(business_name, fname, lname),
	foreign key (fname, lname) references person(fname,lname),
	foreign key (business_name) references location(business_name)
);

create table volunteers(
	fname 		varchar(25) not null,
	lname 		varchar(30) not null,
	business_name 	varchar(50) not null,
	primary key (fname, lname),
	foreign key (fname, lname, business_name) references employees(fname,lname,business_name) on delete cascade
);

create table drivers(
	fname 		varchar(25) not null,
	lname 		varchar(30) not null,
	business_name 	varchar(50) not null,
	license_plate 	varchar(8) not null,
	license_number 	varchar(15) not null primary key,
	foreign key (fname, lname, business_name) references employees(fname,lname,business_name) on delete cascade
);

create table owners(
	fname 		varchar(25) not null,
	lname 		varchar(30) not null,
	business_name 	varchar(50) not null,
	primary key (fname, lname),
	foreign key (fname, lname, business_name) references employees(fname, lname, business_name) on delete cascade
);

create table transactions(
	transaction_id 	int AUTO_INCREMENT not null primary key,
	fname 		varchar(50),
	lname 		varchar(75) not null,
	amount 		decimal(8, 2) not null,
	trans_date 	date not null
);

create table donation(
	transaction_id 	int not null,
	made_to 	varchar(50) not null,
	primary key(transaction_id, made_to),
	foreign key (made_to) references location(business_name),
	foreign key (transaction_id) references transactions(transaction_id) on delete cascade
);

create table animal_payment(
	transaction_id 	int not null,
	fname 		varchar(50) not null,
	lname 		varchar(75) not null,
	animal_id 	int not null,
	primary key (fname, lname, animal_id),
	foreign key (fname, lname) references adopter(fname,lname),
	foreign key (animal_id) references animal(id),
	foreign key (transaction_id) references transactions(transaction_id) on delete cascade
);

create table person_phone(
	fname 		varchar(25) not null,
	lname 		varchar(30) not null,
	phone_number 	char(10) not null,
	primary key (fname, lname, phone_number),
	foreign key (fname, lname) references person(fname,lname)
);

create table business_phone(
	business_name 	varchar(50) not null,
	phone_number 	char(10) not null,
	primary key (business_name, phone_number),
	foreign key (business_name) references location(business_name)
);

create table animal_types(
	business_name 	varchar(25) not null,
	type 		varchar(25) not null,
	primary key (business_name, type),
	foreign key (business_name) references shelter(business_name)
);

create table driven(
	business_name 	varchar(50) not null,
	fname		varchar(25) not null,
	lname		varchar(30) not null,
	driven_date	date not null,
	animal_id	char(5) not null,
	primary key (business_name, fname,lname, driven_date, animal_id)
);

insert into person values("James", "Moffat","Tannery Drive", "Burlington");
insert into person values("Kristine", "Edward", "Quebec Street", "Burlington");
insert into person values("Daniel", "Cook", "Barrington", "Halifax");
insert into person values("Wendy", "Powley","Road Street", "Elmsdale");
insert into person values("Elizabeth", "Carr", "Old Barns", "New Glasgow");
insert into person values("Mira", "MacNeil", "Victoria Street", "Truro");
insert into person values("Isaac", "Cook","Street Road", "Vancouver");
insert into person values("Emma", "Landry", "Montreal Street", "Kingston");
insert into person values("Cameron", "Dhar", "DB Street", "Valley");
insert into person values("Robert", "Jobert", "DB Street", "Valley");

insert into person values ("Josh","Dunfield","Aberdeen", "Kingston");
insert into person values ("Dave","Dove","Smith St","New York");

Insert into person values ("Robin", "Dawes", "First St", "Calgary");

insert into adopter (fname, lname) values("James", "Moffat");
insert into adopter (fname, lname) values("Kristine", "Edward");
insert into adopter (fname, lname) values("Daniel", "Cook");


insert into animal (type, name, adoption) values ('Dog', 'Nala', 1);
insert into animal (type, name, adoption) values ('Cat', 'Lily', 1);
insert into animal (type, name, adoption) values ('Dog', 'Aspen', 1);
insert into animal (type, name, adoption) values ('Cat', 'Hunter', 0);
insert into animal (type, name, adoption) values ('Cat', 'Shmumf', 0);
insert into animal (type, name, adoption) values ('Cat', 'Kaylee', 0);
insert into animal (type, name, adoption) values ('Dog', 'Rex', 0);
insert into animal (type, name, adoption) values ('Cat', 'Tiger', 0);
insert into animal (type, name, adoption) values ('Dog', 'Chance', 0);
insert into animal (type, name, adoption) values ('Dog', 'Snoozin', 0);
insert into animal (type, name, adoption) values ('Dog', 'Hobbes', 0);
insert into animal (type, name, adoption) values ('Rabbit', 'Trucia', 0);
insert into animal (type, name, adoption) values ('Rabbit', 'Hops', 0);
insert into animal (type, name, adoption) values ('Rabbit', 'Peter', 0);
insert into animal (type, name, adoption) values ('Rabbit', 'Elsie', 0);
insert into animal (type, name, adoption) values ('Rodent', 'Pinky', 0);
insert into animal (type, name, adoption) values ('Rodent', 'The Brain', 0);
insert into animal (type, name, adoption) values ('Rodent', 'Ratatouille', 0);
insert into animal (type, name, adoption) values ('Dog', 'Tyson', 0);
insert into animal (type, name, adoption) values ('Dog', 'Petunia', 0);
insert into animal (type, name, adoption) values ('Sugar Glider', 'King Julian', 0);
insert into animal (type, name, adoption) values ('Cat', 'Kiwi', 0);
insert into animal (type, name, adoption) values ('Cat', 'Coco', 0);
insert into animal (type, name, adoption) values ('Cat', 'Smoothie', 0);
insert into animal (type, name, adoption) values ('Cat', 'Joe Exotic', 0);

/* SPCA */
insert into location values("Colchester Branch", "Victoria St", "Truro");
insert into location values("Antigonish Branch", "Tannery Dr", "Antigonish");
insert into location values("Hants County Branch", "Nine Mile River", "Elmsdale");
insert into location values("Lunenberg Branch", "Boardwalk", "Lunenberg");
insert into location values("Cape Breton Branch", "Owens Rd", "St Peters");

/* Shelters */
insert into location values("Red Rover", "Fairview Rd", "Burlington");
insert into location values("WAAG Animal Shelter", "Frontenac St", "Montreal");
insert into location values("Kingston Humane Society", "Albert St", "Kingston");

/* Rescues */
insert into location values("Ruby's Rescue", "Queen's St", "Toronto");
insert into location values("Lost Paws", "Barrington St", "Halifax");
insert into location values("No Paws Left Behind", "Milford Rd", "Lantz");

/* SPCA Branches */
insert into SPCA values ("Colchester Branch");
insert into SPCA values ("Antigonish Branch");
insert into SPCA values ("Hants County Branch");
insert into SPCA values ("Lunenberg Branch");
insert into SPCA values ("Cape Breton Branch");

/* Shelters */
insert into shelter values ("Red Rover","https://redrover.org/", 50);
insert into shelter values ("WAAG Animal Shelter","https://waag.org/", 75);
insert into shelter values ("Kingston Humane Society","https://khs.org/", 20);

/* Rescue */
insert into rescue values ("Ruby's Rescue");
insert into rescue values ("Lost Paws");
insert into rescue values ("No Paws Left Behind");

/* Animal Types */
insert into animal_types values ("Red Rover", "Dog");
insert into animal_types values ("Red Rover", "Cat");
insert into animal_types values ("WAAG Animal Shelter", "Dog");
insert into animal_types values ("WAAG Animal Shelter", "Cat");
insert into animal_types values ("WAAG Animal Shelter", "Sugar Glider");
insert into animal_types values ("Kingston Humane Society", "Dog");
insert into animal_types values ("Kingston Humane Society", "Cat");
insert into animal_types values ("Kingston Humane Society", "Rabbit");
insert into animal_types values ("Kingston Humane Society", "Rodent");

/* Employees */
insert into employees values ("Lost Paws", "Josh", "Dunfield");
insert into employees values ("Colchester Branch", "Dave", "Dove");
insert into employees values ("Ruby's Rescue", "Robin", "Dawes");

insert into employees values ("Lost Paws", "Isaac", "Cook");
insert into employees values ("Lost Paws", "Mira", "MacNeil");
insert into employees values ("No Paws Left Behind", "Cameron", "Dhar");
insert into employees values ("No Paws Left Behind", "Wendy", "Powley");
insert into employees values ("Lost Paws", "Robert", "Jobert");
insert into employees values ("Ruby's Rescue", "Elizabeth", "Carr");
insert into employees values ("Ruby's Rescue", "Kristine", "Edward");

/* Volunteers */
insert into volunteers values ("Josh", "Dunfield", "Lost Paws");

insert into drivers values ("Robin","Dawes","Ruby's Rescue", "ASMB419","123456789");
insert into drivers values ("Kristine", "Edward","Ruby's Rescue", "AFH123","123123132");
insert into drivers values ("Elizabeth", "Carr","Ruby's Rescue", "AHD1234","123456432");
insert into drivers values ("Wendy", "Powley","No Paws Left Behind", "BDH124","098234576");
insert into drivers values ("Cameron", "Dhar","No Paws Left Behind", "KAJ324","123756435");
insert into drivers values ("Isaac", "Cook","Lost Paws", "KJND123","123678345");
insert into drivers values ("Mira", "MacNeil","Lost Paws", "KFG345","789123765");
Insert into drivers values ("Robert", "Jobert", "Lost Paws", "SHJW546", "696969696");


insert into owners values ("Dave","Dove", "Colchester Branch");

/* Transaction + Donations */
insert into transactions (fname,lname,amount,trans_date) values ("James", "Moffat", 40000,date "2018-06-03");
Insert into donation values(1, "Ruby's Rescue");

insert into transactions (fname,lname,amount,trans_date) values ("Daniel","Cook",420.00,date "2018-09-09");
Insert into donation values(2,"Lost Paws");

insert into transactions (fname,lname,amount,trans_date) values ("Daniel","Cook",420.00,date "2018-01-01");
insert into donation values(3,"No Paws Left Behind");

insert into transactions (fname,lname,amount,trans_date) values ("Daniel","Cook",420.00,date "2018-02-02");
Insert into donation values(4, "Kingston Humane Society");

insert into transactions (fname,lname,amount,trans_date) values ("Daniel","Cook",420.00,date "2018-07-08");
Insert into donation values(5, "WAAG Animal Shelter");

insert into transactions (fname,lname,amount,trans_date) values ("Daniel","Cook",420.00,date "2018-10-05");
Insert into donation values(6, "Red Rover");

insert into transactions (fname,lname,amount,trans_date) values ("Daniel","Cook",420.00,date "2018-04-12");
insert into donation values(7, "Colchester Branch");

insert into transactions (fname,lname,amount,trans_date) values ("Josh","Dunfield",300.00,date "2018-12-01");
Insert into donation values(8, "Antigonish Branch");

/* Transactions + Animal Payments */
insert into transactions (fname,lname,amount,trans_date) values ("James","Moffat",1.00,date "2018-10-20");
Insert into animal_payment values(9, "James",  "Moffat", 1);

insert into transactions (fname,lname,amount,trans_date) values ("Josh","Dunfield",2.00,date "2018-04-06");
Insert into animal_payment values(10, "Kristine","Edward", 2);

insert into transactions (fname,lname,amount,trans_date) values ("Josh","Dunfield",300.00,date "2018-02-03");
insert into animal_payment values(11, "Daniel","Cook",3);


/* Animal Location */

insert into animal_location values (4, "Colchester Branch", date "2018-12-15",  date "2018-12-17");
insert into animal_location values (5, "Colchester Branch", date "2018-12-15",  date "2018-12-17");
insert into animal_location values (7, "Colchester Branch", date "2018-12-15",  date "2018-12-17");
insert into animal_location values (1,"Hants County Branch", date "2018-12-15",  date "2018-12-17");
insert into animal_location values (6,"Lunenberg Branch", date "2015-12-15",  null);
insert into animal_location values (24, "Cape Breton Branch", date "2019-10-04", date "2019-10-05");
insert into animal_location values (25, "Lunenberg Branch", date "2019-10-03", date "2019-10-11");
insert into animal_location values (2,"Antigonish Branch", date "2018-05-10", date "2018-12-05");
insert into animal_location values (3,"Hants County Branch", date "2015-10-05", date "2019-10-05");
insert into animal_location values (8, "Red Rover", date "2018-12-15",  date "2018-12-17");
insert into animal_location values (9, "Red Rover", date "2018-12-15",  date "2018-12-17");
insert into animal_location values (10, "Red Rover", date "2015-10-05", date "2019-10-05");
insert into animal_location values (11, "Red Rover", date "2015-10-05", date "2019-10-05");
insert into animal_location values (12, "Kingston Humane Society", date "2015-10-05", date "2019-10-05");
insert into animal_location values (13, "Kingston Humane Society", date "2015-10-05", date "2019-10-05");
insert into animal_location values (14, "Kingston Humane Society", date "2018-10-05", date "2019-10-05");
insert into animal_location values (15, "Kingston Humane Society", date "2018-10-05", date "2019-10-05");
insert into animal_location values (16, "Kingston Humane Society", date "2018-10-05", date "2019-10-05");
insert into animal_location values (17, "Kingston Humane Society", date "2018-10-05", date "2019-10-05");
insert into animal_location values (18, "Kingston Humane Society", date "2015-10-05", date "2019-10-05");
insert into animal_location values (19, "WAAG Animal Shelter", date "2015-10-05", date "2019-10-05");
insert into animal_location values (20, "WAAG Animal Shelter", date "2018-10-05", date "2019-10-05");
insert into animal_location values (21, "WAAG Animal Shelter", date "2017-10-05", date "2019-10-05");
insert into animal_location values (22, "WAAG Animal Shelter", date "2019-10-05", date "2019-10-05");
insert into animal_location values (23, "WAAG Animal Shelter", date "2014-10-05", date "2019-10-05");

insert into person_phone values ("James","Moffat","9053998400");
insert into person_phone values ("Wendy", "Powley","9024993989");
insert into person_phone values ("Elizabeth", "Carr","1234567890");
insert into person_phone values ("Cameron", "Dhar","0987654321");
insert into person_phone values ("Josh","Dunfield","5678901234");

insert into business_phone values ("Red Rover","9021234567");
insert into business_phone values ("Kingston Humane Society","7891325678");

insert into driven values ("Lost Paws", "Robert", "Jobert", date "2018-05-10", 3);
insert into driven values ("Lost Paws", "Robert", "Jobert", date "2015-10-05", 2);
insert into driven values ("Lost Paws", "Mira", "MacNeil", date "2018-12-15", 8);
insert into driven values ("Lost Paws", "Mira", "MacNeil", date "2018-12-15", 9);
insert into driven values ("Lost Paws", "Robert", "Jobert", date "2015-10-05", 10);
insert into driven values ("Lost Paws", "Isaac", "Cook", date "2015-10-05", 11);
insert into driven values ("Ruby's Rescue", "Robin", "Dawes", date "2015-10-05", 12);
insert into driven values ("Ruby's Rescue", "Kristine", "Edward", date "2015-10-05", 13);
insert into driven values ("Ruby's Rescue", "Elizabeth", "Carr", date "2018-10-05", 14);
insert into driven values ("No Paws Left Behind", "Wendy", "Powley", date "2018-10-05", 15);
insert into driven values ("No Paws Left Behind", "Cameron", "Dhar", date "2018-10-05", 16);
insert into driven values ("Lost Paws", "Isaac", "Cook", date "2018-10-05", 17);
insert into driven values ("Ruby's Rescue", "Robin", "Dawes", date "2015-10-05", 18);
insert into driven values ("Ruby's Rescue", "Kristine", "Edward", date "2015-10-05", 19);
insert into driven values ("Ruby's Rescue", "Elizabeth", "Carr", date "2018-10-05", 20);
insert into driven values ("No Paws Left Behind", "Wendy", "Powley", date "2018-10-05", 21);
insert into driven values ("No Paws Left Behind", "Cameron", "Dhar", date "2018-10-05", 22);
insert into driven values ("Lost Paws", "Isaac", "Cook", date "2018-10-05", 23);
