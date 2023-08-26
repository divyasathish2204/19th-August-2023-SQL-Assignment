use ineuron
## query1
create table city(
id int not null,
country_Name varchar(17),
country_code varchar(3),
district varchar(20),
population bigint
);
insert into city values(1,"Alabama","AL","montgomery",5024279),
(2,"Alaska","AK","juneau",733391),
(3,"california","CA","sacramento",39538223),
(4,"ohio","OH","columbus",11799448),
(5,"new_jersey","NJ","trenton",9288994),
(6,"vermont","VT","montpelier",643077),
(7,"America","USA","washington",340265839);
insert into city values(8,"manchestor","IA","Delaware country",5087);
insert into city values(9,"manly","IA","worth_country",1325);
## query 1
select * from city where country_code="USA" and population>100000;
## query 2
select country_name from city where population > 120000;
## query 3
select * from city;
## query 4
## in the question they have given 1661 but i created id as 1,2,3,....
select * from city where id = 3;
## query5
create table japanese_city(
id int not null,
country_name varchar(20),
country_code varchar(3),
district varchar(20),
population bigint);
insert into japanese_city values(1,"neyagawa","JPN","osaka",228802),(2,"hiroshima","JPN","hiroshima prefecture",120000000),
(3,"yokohoma","JPN","kanagawa",3307000);
## query 5
select * from japanese_city;
## query 6
select country_name from japanese_city where country_code = "JPN";
## query 7
drop table station
create table station(
id int not null,
city varchar(20),
state varchar(20),
LAT_N bigint,
LONG_W bigint
);
insert into station values(1,"chennai","Tamil_nadu",34.710,-87.663),(2,"hyderabad","Telangana",29.687,-67.897),
(3,"kolkatta","west_bengal",91.897,-78.123),(4,"cochin","kerela",12.345,-34.876),
(5,"banglore","karnataka",56.789,-23.765),(6,"mumbai","maharastra",98.123,-15.679),(4,"cochin","kerela",12.345,-34.876),
(1,"chennai","Tamil_nadu",34.567,-75.453),(9,"Assam","orissa",89.900,-17.908),(10,"andhra","vijayawada",89.789,-17.90);
select * from station;
select city,state from station;
## query 8
select id, city from station where id%2 = 0;
## query 9
select count(city)-count(distinct city) as city_difference FROM station;
## query 10
select * from station;
select city, char_length(city) from station
 where city = (select min(city) from station
     where char_length(city) = (select min(char_length(city)) from station)) 
 or city = (select max(city) from station
     where char_length(city) = (select max(char_length(city)) from station));

## query 11
SELECT city
FROM station
WHERE LEFT(city , 1) IN ('a','e','i','o','u');

## query 12
select city 
from station 
where right(city,1) IN ('a','e','i','o','u');

## QUERY 13
select city 
from station 
where left(city,1) NOT IN('a','e','i','o','u');

## QUERY 14
select city 
from station 
where RIGHT(city,1) NOT IN('a','e','i','o','u');

## QUERY 15 
select city 
from station 
where left(city,1) NOT IN('a','e','i','o','u')
AND 
RIGHT(city,1) NOT IN('a','e','i','o','u');

## query 16
select city 
from station 
where left(city,1) NOT IN('a','e','i','o','u')
OR 
RIGHT(city,1) NOT IN('a','e','i','o','u');

## query 17
use ineuron;
create table product(
product_id int not null,
product_name varchar(20),
unit_price int,
primary key(product_id)
);
insert into product values(1,"S7",10000),(2,"OPP0F5",12000),(3,"iphone",34000);
drop table sales;
use ineuron;
create table sales(
seller_id int,
buyer_id int,
product_id int not null,
sale_date date,
quantity int,
price int,
CONSTRAINT sales_id_fk
FOREIGN KEY(product_id)
REFERENCES product(product_id)
);
insert into sales(seller_id,buyer_id,product_id,sale_date,quantity,price) 
values(1,1,1,'2019-01-21',2,2000),
(1,2,2,'2019-02-17',1,800),
(2,3,2,'2019-06-02',1,800),
(3,4,3,'2019-05-13',2,2800);
select * from sales;
with cte as(
select s.product_id,p.product_name,s.sale_date
from sales s inner join product p 
on s.product_id=p.product_id
where s.sale_date between '2019-01-21' and '2019-02-17')
select product_id,product_name from cte c
where sale_date =(select max(sale_date) from sales group by product_id having product_id=c.product_id);

## query 18
create table views(
article_id int,
author_id int,
viewer_id int,
view_date date
);
insert into views values(1,3,5,'2019-08-01'),
(1,3,6,'2019-08-02'),
(2,7,7,'2019-08-01'),
(2,7,6,'2019-08-02'),
(4,7,1,'2019-07-22'),
(3,4,4,'2019-07-21'),
(3,4,4,'2019-07-21');
select * from views;
select distinct a.author_id as id from views a inner join views v 
on a.author_id=v.viewer_id and v.author_id=a.viewer_id and a.article_id=v.article_id
order by id;
## query 19
create table Delivery_table(
delivery_id int,
customer_id int,
order_date date,
customer_pref_delivery_date date,
primary key(delivery_id)
);
insert into Delivery_table values(1,1,'2019-08-01','2019-08-02'),
(2,5,'2019-08-02','2019-08-02'),
(3,1,'2019-08-11','2019-08-11'),
(4,3,'2019-08-24','2019-08-26'),
(5,4,'2019-08-21','2019-08-22'),
(6,2,'2019-08-11','2019-08-13');
select * from Delivery_table;
select round(100.0*count(case when order_date=customer_pref_delivery_date then 1 else null end)/count(*),2) 
as immediate_percentage
from Delivery_table;
## query 20
drop table ads;
create table ads(
ad_id int,
user_id int,
action enum ('Clicked', 'Viewed', 'Ignored'),
primary key(ad_id,user_id)
);
select * from ads;
insert into ads values(1,1,"Clicked"),
(2,2,"Clicked"),
(3,3,"Viewed"),
(5,5,"Ignored"),
(1,7,"Ignored"),
(2,7,"Viewed"),
(3,5,"Clicked"),
(1,4,"Viewed"),
(2,11,"Viewed"),
(1,2,"Clicked");
select * from ads;
with cte as(
select ad_id,action,
case when action ='Clicked' then 1 
when action='Viewed' then 0 else null end as results
from ads 
)
select ad_id, ifnull(round(100*sum(results)/count(results),2),0) as ctr
from cte group by ad_id
order by ctr desc ,ad_id asc;
select * from ads;

## query 21
create table Employee1(
employee_id int,
team_id int,
primary key(employee_id)
);
insert into Employee1 values(1,8),(2,8),(3,8),(4,7),(5,9),(6,9);
select * from Employee1;
select e1.employee_id,count(e1.employee_id) as team_size
from Employee1 e1 inner join Employee1 e2
on e1.team_id=e2.team_id
group by e1.employee_id
order by employee_id;

## query 22
use ineuron;
create table Countries(
country_id int,
country_name varchar(30),
primary key(country_id)
);
create table Weather(
country_id int,
weather_state int,
day date,
primary key(country_id,day)
);
select * from countries;
select * from weather;
insert into Countries values(2,"USA"),
(3, "Australia"),
(7,"Peru"),
(5,"China"),
(8,"Morocco"),
(9,"Spain");
insert into Weather values(2,15,"2019-11-01"),
(2,12,"2019-10-28"),
(2,12,"2019-10-27"),
(3,-2,"2019-11-10"),
(3,0,"2019-11-11"),
(3,3,"2019-11-12"),
(5,16,"2019-11-07"),
(5,18,"2019-11-09"),
(5,21,"2019-11-23"),
(7,25,"2019-11-28"),
(7,22,'2019-12-01'),
(7,20,'2019-12-02'),
(8,25,'2019-11-05'),
(8,27,'2019-11-15'),
(8,31,'2019-11-25'),
(9,7,'2019-10-23'),
(9,3,'2019-12-23');
select * from weather;
with cte as(
select c.country_name,round(avg(weather_state)) as avg_weather
from Countries c inner join weather w
on c.country_id = w.country_id
where year(day)=2019 and month(day) = 11
group by country_name)
select country_name,case when avg_weather <= 15 then 'cold' when avg_weather >=25 then 'hot'
else 'warm' end as weather_type from cte;

## query 23
create table prices(
product_id int,
start_date date,
end_date date,
price int,
primary key(product_id, start_date, end_date)
);
create table unitssold(
product_id int,
purchase_date date,
unit int
);
insert into prices values(1,'2019-02-17','2019-02-28',5),
(1,'2019-03-01','2019-03-22',20),
(2,'2019-02-01','2019-02-20',15),
(2,'2019-02-21','2019-03-31',30);
insert into unitssold values(1,'2019-02-25',100),
(1,'2019-03-01',15),
(2,'2019-02-10',200),
(2,'2019-03-22',30);
select * from prices;
select * from unitssold;
select p.product_id,round(sum(unit*price)/sum(unit),2) as average_price from
prices p inner join unitssold u
on p.product_id=u.product_id 
and u.purchase_date 
between p.start_date and p.end_date
group by product_id;

## query 24

create table activity(
player_id int,
device_id int,
event_date date,
games_played int,
primary key (player_id, event_date)
);
insert into activity values(1,2,'2016-03-01',5),
(1,2,'2016-05-02',6),
(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),
(3,4,'2018-07-03',5);
select * from activity;
select player_id ,min(event_date) as first_login_date
from activity group by player_id;

## query 25
select player_id,device_id from activity a
where event_date=(select min(event_date) from activity group by player_id having player_id=a.player_id);

## query 26
create table products(
product_id int,
product_name varchar(30),
product_category varchar(30),
primary key(product_id)
);
create table orders_info(
product_id int,
order_date date,
unit int,
foreign key (product_id) references products(product_id)
);
insert into products values(1,"Leetcode
Solutions","Book"),(2,"Jewels of Stringology","Book"),
(3,"HP","Laptop"),
(4,"Lenovo","Laptop"),
(5,"Leetcode Kit","T-shirt");

insert into orders_info values(1,'2020-02-05',60),
(1,'2020-02-10',70),
(2,'2020-01-18',30),
(2,'2020-02-11',80),
(3,'2020-02-17',2),
(3,'2020-02-24',3),
(4,'2020-03-01',20),
(4,'2020-03-04',30),
(4,'2020-03-04',60),
(5,'2020-02-25',50),
(5,'2020-02-27',50),
(5,'2020-03-01',50);
select * from orders_info;
select * from products;

select p.product_name,sum(unit) as unit
from products p inner join orders o
on p.product_id=o.product_id
where year(order_date)=2020 and month(order_date)=2
group by product_name having sum(unit)>=100;

## query 27

create table users(
user_id int ,
name varchar(30),
mail varchar(30),
primary key(user_id)
);
insert into users values(1,"Winston","winston@leetcode.com"),
(2,"Jonathan","jonathanisgreat"),
(3,"Annabelle","bella-@leetcode.com"),
(4,"Sally","sally.come@leetcode.com"),
(5,"Marwan","quarz#2020@leetcode.com"),
(6,"David","david69@gmail.com"),
(7,"Shapiro",".shapo@leetcode.com");
select * from users;
select * from Users
where mail regexp '^[a-zA-Z]+[a-zA-Z0-9_\\./\\-]{0,}@leetcode.com$'
order by user_id;

## query 28
create table customers1(
customer_id int,
name varchar(30),
country varchar(30),
primary key(customer_id)
);

create table orders1(
order_id int,
customer_id int,
product_id int,
order_date date,
quantity int,
primary key(order_id)
);

create table product1(
product_id int,
descripion varchar(30),
price int,
primary key(product_id)
);
insert into customers1 values(1,"Winston","USA"),
(2,"Jonathan","Peru"),
(3,"Moustafa","Egypt");
insert into product1 values(10,"LCPhone",300),
(20,"LCT-Shirt",10),
(30,"LCBook",45),
(40,"LCKeychain",2);
insert into orders1 values(1,1,10,'2020-06-10',1),
(2,1,20,'2020-07-01',1),
(3,1,30,'2020-07-08',2),
(4,2,10,'2020-06-15',2),
(5,2,40,'2020-07-01',10),
(6,3,20,'2020-06-24',2),
(7,3,30,'2020-06-25',2),
(9,3,30,'2020-05-08',3);
select * from product1;
select * from orders1;
select * from customers1;
with cte as(
select o.customer_id,c.name,sum(price*quantity) as month_spend,month(order_date) as month
from orders1 o inner join product1 p on o.product_id=p.product_id inner join customers1 c on o.customer_id=c.customer_id
where year(o.order_date)=2020 and month(o.order_date) in(6,7)
group by customer_id,month(order_date)
)
select customer_id,name from cte
where month_spend>=100
group by customer_id
having count(*)=2;

## query 29
create table tvprogram(
program_date datetime,
content_id int,
channel varchar(30),
primary key(program_date, content_id)
);
create table content(
content_id varchar(30),
title varchar(30),
kids_content enum('Y','N'),
content_type varchar(30),
primary key(content_id)
);

insert into tvprogram values("2020-06-10 08:00",1,"LC-Channel"),
("2020-05-11 12:00",2,"LC-Channel"),
("2020-05-12 12:00",3,"LC-Channel"),
("2020-05-13 14:00",4,"Disney Ch"),
("2020-06-18 14:00",4,"Disney Ch"),
("2020-07-15 16:00",5,"Disney Ch");
insert into content values(1,"Leetcode Movie",'N',"Movies"),
(2,"Alg. for Kids",'Y',"Series"),
(3,"Database Sols",'N',"Series"),
(4,"Aladdin",'Y',"Movies"),
(5,"Cinderella",'Y',"Movies");
select * from tvprogram;
select * from content;
select c.title as kids_program from tvprogram t inner join content c 
on t.content_id = c.content_id
where kids_content = 'Y' and content_type = "Movies" and year(program_date) = 2020 and month(program_date) =6 ;

## query 30 and 31
create table npv(
id int,
year int,
npv int,
primary key(id,year)
);
create table queries(
id int,
year int,
primary key(id,year)
);
insert into NPV values(1,2018,100),
(7,2020,30),
(13,2019,40),
(1,2019,113),
(2,2008,121),
(3,2009,12),
(11,2020,99),
(7,2019,0);
insert into queries values(1,2019),
(2,2008),
(3,2009),
(7,2018),
(7,2019),
(7,2020),
(13,2019);
select * from npv;
select * from queries;
select q.id, q.year,ifnull(n.npv,0) as npv
from queries q left join npv n on q.id=n.id and q.year=n.year;

## query 32
create table employees_info(
id int,
name varchar(30),
primary key(id)
);
create table employeeuni(
id int,
unique_id int,
primary key(id,unique_id)
);
insert into employees_info values(1,"Alice"),
(7,"Bob"),
(11,"Meir"),
(90,"Winston"),
(3,"Jonathan");

insert into employeeuni values(3,1),
(11,2),
(90,3);
select * from employees_info;
select * from employeeuni;
select emp_un.unique_id,e.name
from employees_info e left join employeeuni emp_un on e.id= emp_un.id
order by name;

## query 33
use ineuron;
create table users1(
id int,
name varchar(30),
primary key(id)
);
create table rides(
id int,
user_id int,
distance int,
primary key(id)
);
insert into users1 values(1,"Alice"),
(2,"Bob"),
(3,"Alex"),
(4,"Donald"),
(7,"Lee"),
(13,"Jonathan"),
(19,"Elvis");
insert into rides values(1,1,120),
(2,2,317),
(3,3,222),
(4,7,100),
(5,13,312),
(6,19,50),
(7,7,120),
(8,19,400),
(9,7,230);
select * from users1;
select * from rides;
select u.name,ifnull(sum(r.distance),0) as travelled_distance
from users1 u left join rides r on u.id=r.user_id
group by u.id
order by travelled_distance desc,name;

## query 34 repeated
## query 35

create table movies(
movie_id int,
title varchar(30),
primary key(movie_id)
);
create table users2(
user_id int,
name varchar(30),
primary key(user_id)
);
 create table movierating(
 movie_id int,
 user_id int,
 rating int,
 created_at date,
 primary key(movie_id, user_id)
 );
insert into movies values(1,"Avengers"),
(2,"Frozen 2"),
(3,"Joker");
insert into users2 values(1,"Daniel"),
(2,"Monica"),
(3,"Maria"),
(4,"James");
insert into movierating values(1,1,3,'2020-01-12'),
(1,2,4,'2020-02-11'),
(1,3,2,'2020-02-12'),
(1,4,1,'2020-01-01'),
(2,1,5,'2020-02-17'),
(2,2,2,'2020-02-01'),
(2,3,2,'2020-03-01'),
(3,1,3,'2020-02-22'),
(3,2,4,'2020-02-25');
 select * from movies;
 select * from users2;
 select * from movierating;
select u.name 
from users2 u left join movierating mr
on u.user_id = mr.user_id
group by name
order by count(mr.rating) desc,name limit 1;
select m.title
from movies m left join movierating mr
on m.movie_id = mr.movie_id
group by title
order by avg(mr.rating) desc,title limit 1;

## query 36 repeated
## query 37 also repeated
## query 38
drop table departments;
create table departments(
id int,
name varchar(30),
primary key(id)
);
drop table students;
create table students(
id int,
name varchar(30),
department_id int,
primary key(id)
);
insert into departments values(1,"Electrical Engineering"),
(7,"Computer Engineering"),
(13,"Business Administration");
insert into students values(23,"Alice",1),
(1,"Bob",7),
(5,"Jennifer",13),
(2,"John",14),
(4,"Jasmine",77),
(3,"Steve",74),
(6,"Luis",1),
(8,"Jonathan",7),
(7,"Daiana",33),
(11,"Madelynn",1);
select * from departments;
select * from students;
select s.id,s.name from departments d right join students s 
on d.id = s.department_id
where d.name is null;

## query 39
create table calls(
from_id int,
to_id int,
duration int
);
insert into calls values(1,2,59),
(2,1,11),
(1,3,20),
(3,4,100),
(3,4,200),
(3,4,200),
(4,3,499);
select * from calls;
select from_id as person1 ,to_id as person2,count(*) as call_count,sum(duration) as call_duration from(
select * from calls
union all
select to_id,from_id,duration from calls)s
where from_id<to_id
group by person1 ,person2;

## query 40 repeated refer query 23
## query
create table warehouse(
name varchar(30),
product_id int,
units int,
primary key(name, product_id)
);
create table products1(
product_id int,
product_name varchar(30),
width int,
length int,
height int,
primary key(product_id)
);
insert into warehouse values("LCHouse1",1,1),
("LCHouse1",2,10),
("LCHouse1",3,5),
("LCHouse2",1,2),
("LCHouse2",2,2),
("LCHouse3",4,1);
insert into products1 values(1,"LC-TV",5,50,40),
(2,"LC-KeyChain",5,5,5),
(3,"LC-Phone",2,10,10),
(4,"LC-T-Shirt",4,10,20);
select * from warehouse;
select * from products1;
select w.name as warehouse_name,sum(w.units*p.width*p.length*p.height) as volume
from warehouse w left join products1 p
on w.product_id=p.product_id
group by w.name;

## query 42

create table sales1(
sale_date date,
fruit varchar(30),
sold_num int,
primary key(sale_date, fruit)
);
insert into sales1 values('2020-05-01',"apples",10),
('2020-05-01',"oranges",8),
('2020-05-02',"apples",15),
('2020-05-02',"oranges",15),
('2020-05-03',"apples",20),
('2020-05-03',"oranges",0),
('2020-05-04',"apples",15),
('2020-05-04',"oranges",16);
select * from sales1;
with cte as(
select *,case when fruit='oranges' then -1*sold_num else sold_num end as oa_sold_num
from sales1)
select sale_date,sum(oa_sold_num) as diff from cte 
group by sale_date
order by sale_date;

## query 43
create table activity1(
player_id int,
device_id int,
event_date date,
games_played int,
primary key(player_id, event_date)
);
insert into activity1 values(1,2,'2016-03-01',5),
(1,2,'2016-03-02',6),
(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),
(3,4,'2018-07-03',5);
select * from activity1;
with cte as(
select player_id,event_date as curr_date,
lead(event_date) over(partition by player_Id order by event_date) as next_date
from activity1)
select 
round(100.0*count(distinct case when datediff(next_date,curr_date)=1 then 1 else null end)/count(distinct player_id),2) as fraction
from cte;

## query 44
drop table employee_info;
create table employee_info(
id int,
name varchar(30),
department varchar(30),
manager_id int null,
primary key(id)
);
insert into employee_info values(101,"John","A",null),
(102,"Dan","A",101),
(103,"James","A",101),
(104,"Amy","A",101),
(105,"Anne","A",101),
(106,"Ron","B",101);
select * from employee_info;
with cte as(
select e.id,e.name ,m.id as manager_id,m.name as manager_name from employee_info e 
left join employee_info m
on m.id=e.manager_id where e.manager_id is not null)
select manager_name as name from cte
group by manager_name having count(*)>=5;

## query 45

create table student1(
student_id int,
student_name varchar(30),
gender varchar(30),
dept_id int,
primary key(student_id)
);
create table department1(
dept_id int,
dept_name varchar(30),
primary key(dept_id)
);
insert into student1 values(1,"Jack","M",1),
(2,"Jane","F",1),
(3,"Mark","M",2);
insert into department1 values(1,"Engineering"),
(2,"Science"),
(3,"Law");
select  * from student1;
select * from department1;
select d.dept_name,count(student_name) as student_numbers
from department1 d left join student1 s
on d.dept_id=s.dept_id
group by d.dept_name
order by student_numbers desc,dept_name;

## query 46
create table customers1_info(
customer_id int,
product_key int,
foreign key (product_key) references products_info(product_key)
);
create table products_info(
product_key int,
primary key(product_key)
);
insert into customers1_info values(1,5),
(2,6),
(3,5),
(3,6),
(1,6);
insert into products_info values(5),(6);
select * from customers1_info;
select * from products_info;
with cte as(
select c.customer_id,p.product_key,count(p.product_key) as product_count
from products_info p left join customers1_info c 
on p.product_key=c.product_key
group by c.customer_id)
select customer_id from cte where product_count=(select count(*) from products_info);

## query 47

create table project(
project_id int,
employee_id int,
primary key(project_id,employee_id),
foreign key(employee_id) references employee2(employee_id)
);
create table employee2(
employee_id int,
name varchar(30),
experience_years int,
primary key(employee_id)
);
insert into project values(1,1),
(1,2),
(1,3),
(2,1),
(2,4);
insert into employee2 values(1,"Khaled",3),
(2,"Ali",2),
(3,"John",3),
(4,"Doe",2);
select * from project;
select * from employee2;
with cte as(
select p.project_id,p.employee_id,e.experience_years
from project p left join employee2 e
on p.employee_id=e.employee_id)
select project_id,employee_id from cte c
where experience_years=(select max(experience_years) from cte where project_id=c.project_id group by project_id)
order by project_Id;

## query 48

create table books(
book_id int,
name varchar(30),
available_from date,
primary key(book_id)
);
create table orders1_info(
order_id int,
book_id int,
quantity int,
dispatch_date date,
primary key(order_id),
foreign key(book_id) references books(book_id)
);
insert into books values(1,"Kalila And Demna",'2010-01-01'),
(2,"28 Letters",'2012-05-12'),
(3,"The Hobbit",'2019-06-10'),
(4,"13 ReasonsWhy",'2019-06-01'),
(5,"The HungerGames",'2008-09-21');
## insufficient data-orders table data not given

## query 49

create table enrollments(
student_id int,
course_id int,
grade int,
primary key(student_id,course_id)
);
insert into enrollments values(2,2,95),
(2,3,95),
(1,1,90),
(1,2,99),
(3,1,80),
(3,2,75),
(3,3,82);
select * from enrollments;
select student_id,course_id,grade from
(select *,rank() over(partition by student_id order by grade desc,course_id) rank_num
from enrollments) e
where rank_num=1
order by student_id;

## query 50
create table players(
player_id int,
group_id int,
primary key(player_id));

create table matches(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int,
primary key(match_id));
insert into players values(15,1),
(25,1),
(30,1),
(45,1),
(10,2),
(35,2),
(50,2),
(20,3),
(40,3);
insert into matches values(1,15,45,3,0),(2,30,25,1,2),(3,30,15,2,0),(4,40,20,5,2),(5,35,50,1,1);
select * from players;
select * from matches;
with cte as(
select m.first_player as player,m.first_score as score,p.group_id
from matches m inner join players p on m.first_player=p.player_id
union all
select m.second_player as player,m.second_score as score,p.group_id
from matches m inner join players p on m.second_player=p.player_id),
cte2 as(
select group_id,player,sum(score)as total_score
from cte group by group_id,player)
select group_id,player as player_id from
(select group_id,player,rank() over(partition by group_Id order by total_score desc ,player)as rank_num
from cte2)a
where rank_num=1;








