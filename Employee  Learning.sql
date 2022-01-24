create table `employee`(
	`emp_id` int primary key,
    `name` varchar(20) not null,
    `birth_date` date,
    `sex` varchar(1),
    `salary` int,
    `branch_id` int,
    `sup_id` int
);

create table `branch`(
	`branch_id` int primary key,
    `branch_name` varchar(20),
    `manager_id` int,
    foreign key(`manager_id`) references`employee`(`emp_id`)on delete set null -- 對應的 emp_id 被 del manager_id 就會是 null
);

alter table `employee`
add foreign key (`branch_id`)
references`branch`(`branch_id`) on delete set null;

alter table `employee`
add foreign key (`sup_id`)
references`employee`(`emp_id`) on delete set null; 

create table `client`(
	`client_id` int primary key,
    `client_name` varchar(20),
    `phone` varchar(20)
);

create table `work_with`(
	`emp_id` int,
    `client_id` int,
    `total_sales` int,
    primary key(`emp_id`, `client_id`),
    foreign key(`emp_id`) references`employee`(`emp_id`)on delete cascade, -- employee 的 emp_id 被 del work_with 的 emp_id 也一起 del
    foreign key(`client_id`) references`client`(`client_id`)on delete cascade
);

insert into `work_with` values(210, 404, '87940');

update `branch` set `manager_id` = 208 where `branch_id` = 3;

-- 取得所有員工資料
select * from `employee`;
-- 取得所有客戶資料
select * from `client`;
-- 按薪水低到高取得員工資料
select * from `employee` order by `salary` ;
-- 取得薪水前3高的員工
select * from `employee` order by `salary` desc limit 3;
-- 取得所有員工的名字
select `name` from `employee`;

-- 取得員工人數
select count(*) from `employee`;
-- 取得所有出生於 1970-01-01 之後的女性員工人數
select count(*) from `employee` where `birth_date` > '1970-01-01' and `sex` = 'F';
-- 取得所有員工的平均薪水
select avg(`salary`) from `employee`;
-- 取得所有員工的薪水總和
select sum(`salary`) from `employee`;
-- 取得薪水最高的員工
select `name`, max(`salary`) from `employee`;
-- 取得薪水最低的員工
select `name`, min(`salary`) from `employee`;

-- wildecar 萬用字元  %代表多個字元  _代表一個字元
-- 取得電話號碼中間數有354的客戶
select * from `client` where `phone` like '%354%';
-- 取得性艾的客戶
select * from `client` where `client_name` like '艾%';
-- 取得生日在12月的員工
select * from `employee` where `birth_date` like '_____12%';

-- union 聯集
-- 員工名字 union 客戶名字
select `name` from `employee` union select `client_name` from `client`;
-- 員工 id + 名字 union 客戶 id + 名字
select `emp_id` as `total_id`, `name`as `total_name` from `employee` union select `client_id`, `client_name` from `client`;
-- 員工薪水 union 銷售金額
select `salary` as `total_money` from `employee` union select `total_sales` from `work_with`;

-- join 連接
insert into `branch` values(4, '偷懶', null);
-- 取得所有部門經理的名字
select `employee`.`emp_id`, `employee`.`name`, `branch`.`branch_name` from `employee` join `branch` on `employee`.`emp_id` = `branch`.`manager_id`;
-- if 有相同屬性名字可以用 .
select `employee`.`name` , `branch`.`name`;
-- left/rigth join 不管調件有沒有成立 左/右邊的資料都會 show 出來
select `employee`.`emp_id`, `employee`.`name`, `branch`.`branch_name` 
from `employee` left join `branch` 
on `employee`.`emp_id` = `branch`.`manager_id`;
select `employee`.`emp_id`, `employee`.`name`, `branch`.`branch_name` 
from `employee` right join `branch` 
on `employee`.`emp_id` = `branch`.`manager_id`;

-- subquery 子查詢
-- 找出研發部門的經理名字
select `name` from `employee` where `emp_id` = (
	select `manager_id` from `branch` where `branch_name` = '研發'
);
-- 找出對單一位害客戶銷售金額超過50000的員工名字 // 多筆資料用 IN 單筆資料用 =
select `name` from `employee` where `emp_id` in (
	select `emp_id` from `work_with` where `total_sales` > 50000
);