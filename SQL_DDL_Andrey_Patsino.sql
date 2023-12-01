
create table climber(
    climber_id serial not null,
    first_name text not null,
    last_name text not null,
	gender text not null,
	constraint check_gender check (gender in('male', 'female')),
    full_name text generated always as (first_name  || ' ' ||  last_name) stored not null,
	constraint climber_pk primary key (climber_id)
);

create table country(
    country_id serial not null,
    country_name text not null,
	constraint country_pk primary key (country_id),
	constraint unique_country_name unique (country_name)
);

create table area(
	area_id serial not null,
	country_id serial not null,
    climat text not null,
	constraint area_pk primary key (area_id),
	constraint area_fk foreign key (country_id) references country(country_id)
);

create table mountain(
	mountain_id serial not null,
	area_id serial not null,
	height int not null,
	mountain_name text not null,
	constraint mountain_pk primary key (mountain_id),
	constraint mountain_fk foreign key (area_id) references area(area_id),
	constraint non_negative_height check (height >= 0)
);

create table route(
	route_id serial not null,
	mountain_id serial not null,
	lenght int not null,
	constraint route_pk primary key (route_id),
	constraint route_fk foreign key (mountain_id) references mountain(mountain_id)
);

create table guide(
	climber_id serial not null,
	lenght int default 0,
	constraint guide_fk foreign key (climber_id) references climber(climber_id)
);

create table climb(
	climb_id serial not null,
	route_id serial not null,
	guide_id serial not null,
	start_date date not null,
    end_date date not null,
	constraint climb_pk primary key (climb_id),
	constraint climb_route_fk foreign key (route_id) references route(route_id),
	constraint climb_guide_fk foreign key (guide_id) references climber(climber_id),
	constraint valid_date_range check (start_date >= '2000-01-01' and end_date >= '2000-01-01' and start_date <= end_date)
);

create table climbers_group(
	climber_id serial not null,
	climb_id serial not null,
	constraint climbers_group_climb_fk foreign key (climb_id) references climb(climb_id),
	constraint climbers_group_climber_fk foreign key (climber_id) references climber(climber_id)
);

insert into climber (first_name, last_name, gender) values
('Ivan', 'Ivanov', 'male'),
('Ekaterina', 'Petrova', 'female');

select * from climber

insert into country (country_name) values
('Belarus'), ('Gondor');

select * from country;

insert into area (country_id, climat) values
(1, 'Taiga'), (2, 'City');

select * from area;

insert into mountain (area_id, height, mountain_name) values
(1, 5642, 'Elbrus'), (2, 4522, 'Hoverla');

select * from mountain;


insert into route (mountain_id, lenght) values
(1, 10), (2, 8);

select * from route;

insert into guide (climber_id) values (1), (2);


insert into climb (route_id, guide_id, start_date, end_date) values
(3, 1, '2023-06-01', '2023-06-10'), (4, 2, '2023-07-01', '2023-07-10');

select * from climb;



insert into climbers_group (climber_id, climb_id) values
(1, 3), (2, 4);

alter table climber
add column record_ts date default current_date;
update climber
set record_ts = current_date where record_ts is null;

alter table country
add column record_ts date default current_date;
update country
set record_ts = current_date where record_ts is null;

alter table area
add column record_ts date default current_date;
update area
set record_ts = current_date where record_ts is null;

alter table mountain
add column record_ts date default current_date;
update mountain
set record_ts = current_date where record_ts is null;

alter table route
add column record_ts date default current_date;
update route
set record_ts = current_date where record_ts is null;

alter table guide
add column record_ts date default current_date;
update guide
set record_ts = current_date where record_ts is null;

alter table climb
add column record_ts date default current_date;
update climb
set record_ts = current_date where record_ts is null;

alter table climbers_group
add column record_ts date default current_date;
update climbers_group
set record_ts = current_date where record_ts is null;
	