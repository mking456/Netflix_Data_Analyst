create database netflix;
use netflix;

create table netflix
(
	show_id	varchar(15),
	type	varchar(15),
	title	varchar(150),
	director varchar(208),
	casts	varchar(771),
	country	varchar(123),
    date_added	varchar(50),
	release_year	int,
	rating	varchar(10),
	duration	varchar(15),
	listed_in	varchar(150),
	description varchar(250)
);
select count(*) as total_contents from netflix;
SELECT distinct(TYPE) FROM netflix;


