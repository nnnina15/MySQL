create database `sql_tutorial`;
show databases;
drop database `sql_tuutorial`;
use `sql_tutorial`;

table 資料數據使用(
int				-- 整數
decimal(m,n)	-- 有小數點的數
varchar(n)		-- 字串
blob			-- (Binary Large Object) 圖片, 影片, 檔案..
date			-- 'YYY-MM-DD' 日期
timestamp		-- 'YYY-MM-DD HH:MM:SS' 日期, 時間
)

create table `student`(
	`student_id` int auto_increment, -- 自動 +1 id
    `name` varchar(20)  unique, -- 不可以重覆
    `major` varchar(20) default'English', -- 沒自訂資料 就會用基本資料'English'
    `score` int not null, -- 不可以有null
     primary key(`student_id`)
);

set sql_safe_updates = 0;

describe `student`;  -- 表格屬性檢視
drop table `student`; -- 刪除表格

alter table `student` add gpa decimal(3,2); -- 新增表格屬性
alter table `student` drop column gpa; -- 刪除表格屬性

insert into `student` values(1, 'jack' ,'Chinese'); -- 新增表格資料
insert into `student`(`name`, `major`, `score`) values('peter', 'Eng', '50'); -- 自訂新增表格資料

-- 修改 major 所有名 English to Eng
update `student` set `major` = 'Eng' where `name` = 'English';
-- 修改叫 peter 的 student_id to 6
update `student` set `student_id` = '6' where `name` = 'peter';
-- 修改 student_id = 6 的 name 改為 nina , major 改為 Bio
update `student` set `name` = 'nina', `major` = 'Bio' where `student_id` = '6';
-- 修改所有 major 改為 Eng
update `student` set `major` = 'Eng';

-- 刪除有 name = candy and major = Eng 的資料
delete from `student` where `name` = 'candy' and `major` = 'Eng';
-- 刪除分數小於 60 的資料 
大小於符號(
> 大於
< 小於
>= 大於等於 
<= 小於等於
= 等於
<> 不等於 )
delete from `student` where `score` < 60;
-- 刪除 student 表格所有資料 
delete from `student`;

-- 檢視 student 所有資料
select * from `student` ;
-- 檢視 name and major 的資料
select `name`, `major` from `student`;
-- 檢視 3 筆排列好 score 和 student_id 的資料 //dese 是由大至小 沒用dese 就會由小至大排列
select * from `student` order by `score` desc, `student_id` limit 3;
-- 檢視 major 是 Eng 而且 student id 是 5 的 3 筆資料
select * from `student` where `major` = 'Eng' and `student_id` = 5;
-- 檢視 major 是 Eng 或分數不等於 70 的資料
select * from `student` where `major` = 'Eng' or `score` <> 70 limit 3;
-- where `major` = 'Eng' or `major` = 'IT' or `major` = 'Bio' 的簡寫
select * from `student` where `major` in('Eng','IT','Bio');

