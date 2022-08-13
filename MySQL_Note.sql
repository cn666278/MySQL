

-- 取得资料

SELECT * FROM `student` ORDER BY `score`, 'student_id'; --正序

SELECT * FROM `student` ORDER BY `score`, 'student_id' DESC; --DESC:倒序

SELECT * FROM `student` LIMIT 3; --仅输出前三笔资料

SELECT * FROM `student` ORDER BY `score`, LIMIT 1; --正序,仅输出前三笔资料(输出成绩最低的资料)

SELECT * FROM `student` WHERE `major` = "english" OR `score` > 20;
SELECT * FROM `student` WHERE `major` = "english" OR `score` <> 20; -- <>:不等号

SELECT * FROM `student` WHERE `major` in('Math','English','Chinese'); -- 取得指定类目


-- 创建公司资料库

/*
* PRIMARY KEY
* FOREIGN KEY
* ATTRIBUTE
*/

DROP TABLE `student`; -- 删除表格

-- 创建表格
-- employee表格
CREATE DATABASE `employee`;

CREATE TABLE `employee`(
  `emp_id` INT PRIMARY KEY,
  `name` VARCHAR(20),
  `birth_day` DATE,
  `gender` VARCHAR(1),
  `salary` INT,
  `branch_id` INT,
  `sup_id` INT      --注意最后一项不要加标点
);

-- branch 表格

CREATE TABLE `branch`(
  `branch_id` INT PRIMARY KEY,
  `branch_name` VARCHAR(20),
  `manager_id` INT,
  FOREIGN KEY (`manager_id`) REFERENCES `employee`(`emp_id`) ON DELETE SET NULL --
);

-- 更改
ALTER TABLE `employee`
ADD FOREIGN KEY(`branch_id`)
REFERENCES `branch`(`branch_id`)
ON DELETE SET NULL;

ALTER TABLE `employee`
ADD FOREIGN KEY(`sup_id`)
REFERENCES `employee`(`emp_id`)
ON DELETE SET NULL;

-- client 表格

CREATE TABLE `client`(
  `client_id` INT PRIMARY KEY,
  `client_name` VARCHAR(20),
  `phone` VARCHAR(20)
);

-- work_with 表格

CREATE TABLE `work_with`(
  `emp_id` INT,
  `client_id` INT,
  `total_sales` INT,
  PRIMARY KEY(`emp_id`, `client_id`),
  FOREIGN KEY (`emp_id`) REFERENCES `employee`(`emp_id`) ON DELETE CASCADE,
  FOREIGN KEY (`client_id`) REFERENCES `client`(`client_id`) ON DELETE CASCADE
);

-- 新增资料

INSERT INTO `branch` VALUES(1, '开发', NULL);
INSERT INTO `branch` VALUES(2, '产品', NULL);
INSERT INTO `branch` VALUES(3, '宣传', NULL);
INSERT INTO `branch` VALUES(4, '公关', NULL);

INSERT INTO `employee` VALUES(206, 'Tom', '1998-08-20', 'F', 5000, 1, NULL);
INSERT INTO `employee` VALUES(207, 'Tony', '1998-08-20', 'M', 52000, 3, 207);
INSERT INTO `employee` VALUES(208, 'Ketty', '1998-08-20', 'F', 15000, 3, 207);
INSERT INTO `employee` VALUES(209, 'Calor', '1998-08-20', 'M', 3000, 2, 206);
INSERT INTO `employee` VALUES(210, 'Monika', '2000-08-20', 'M', 1000, 1, 206);

-- 更新 manager_id
UPDATE `branch` SET `manager_id` = 206 WHERE `branch_id` = 1
UPDATE `branch` SET `manager_id` = 207 WHERE `branch_id` = 2
UPDATE `branch` SET `manager_id` = 208 WHERE `branch_id` = 3

-- 插入客户资料
INSERT INTO `client` VALUES(400, 'Shield','1860888122');
INSERT INTO `client` VALUES(401, 'Frank','10086');
INSERT INTO `client` VALUES(402, 'Henry','209988');
INSERT INTO `client` VALUES(403, 'Foever','80080088');
INSERT INTO `client` VALUES(404, 'Taylor','10010');

-- 插入工资
INSERT INTO `work_with` VALUES(206, 400,'70000');
INSERT INTO `work_with` VALUES(207, 401,'20000');
INSERT INTO `work_with` VALUES(208, 402,'100000');
INSERT INTO `work_with` VALUES(208, 403,'50000');
INSERT INTO `work_with` VALUES(210, 404,'7000');

-------------------------------------------------------
-- Practice
-- 1. 取得所有员工的资料
SELECT * FROM `employee`;

-- 2. 取得所有客户的资料
SELECT * FROM `client`;

-- 3. 按薪水从高到低取得所有员工的资料
SELECT * FROM `employee` ORDER BY `salary` DESC;

-- 4. 取得薪水前三高的员工
SELECT * FROM `employee` ORDER BY `salary` DESC LIMIT 3;

-- 5. 取得所有员工的名字
SELECT `name` FROM `employee`;

-- 6. 取得不重复性别的员工
SELECT DISTINCT `gender` FROM `employee`;


---------------------------------------------
-- aggregate functions 聚合函数

-- 1. 取得员工人数(信息数)
SELECT COUNT(*) FROM `employee`;

-- 1.1. 取得所有含有主管（sup_id)员工人数
SELECT COUNT(`sup_id`) FROM `employee`;

-- 2. 取得所有出生于1970-01-01 之后的女性员工
SELECT COUNT(*)
FROM `employee`
WHERE `birth_day` > '1970-01-01' AND `gender` = 'F';

-- 3. 取得所有员工的平均工资
SELECT AVG(`salary`) FROM `employee`;

-- 4. 取得所有员工薪水的总和
SELECT SUM(`salary`) FROM `employee`;

-- 5. 取的薪水最高的员工
SELECT MAX(`salary`) FROM `employee`;

-- 6. 取的薪水最低的员工
SELECT MIN(`salary`) FROM `employee`;

---------------------------------------------
-- wildcards 万用字节
-- % 代表多个字节
-- _ 代表一个字节

-- 1. 取得电话号码尾数为 086 的客户
SELECT * FROM `client` WHERE `phone` LIKE '%086';

-- 2. 取得电话号码开头为 100 的客户
SELECT * FROM `client` WHERE `phone` LIKE '100%';

-- 3. 取得电话号码含有 00 的客户
SELECT * FROM `client` WHERE `phone` LIKE '%00%';

-- 4. 取得 姓陈 的客户
SELECT * FROM `client` WHERE `client_name` LIKE '陈%';

-- 5. 取得生日在12月的员工 (5个 _ 代表5位 ： 1999-)
SELECT * FROM `employee` WHERE `birth_day` LIKE '_____12%';

-----------------------------------------------------
-- Union 并集
-- 合并的元素数目，属性，类型必须相同

-- 1. 员工名字 union 客户名字
SELECT `name` FROM `employee`
UNION
SELECT `client_name` FROM `client`
UNION
SELECT `branch_name` FROM `branch`;

-- 2. 员工id + 员工名字 union 客户id + 客户名字
SELECT `emp_id`,`name` FROM `employee`
UNION
SELECT `client_id`,`client_name`FROM `client`;

-- 重命名属性
SELECT `emp_id` AS `ID`,`name` AS `NAME` FROM `employee`
UNION
SELECT `client_id`,`client_name`FROM `client`;

-- 3. 员工薪水 union 销售金额
SELECT `salary` FROM `employee`
UNION
SELECT `total_sales` FROM `work_with`;

---------------------------------------------------
-- Join 联结: 用于联结两张关联表格

SELECT *
FROM `employee`
JOIN `branch`
ON `emp_id` = `manager_id`;

SELECT `emp_id`,`name`,`branch_name`
FROM `employee`
JOIN `branch`
ON `emp_id` = `manager_id`;

--等价于：
SELECT `employee`.`emp_id`,`employee`.`name`,`branch`.`branch_name`
FROM `employee`
JOIN `branch`
ON `employee`.`emp_id` = `branch`.`manager_id`;

-- LEFT JOIN
-- 左边的表格不管条件是否成立都回传(emp_id, name)
-- 右边的表格条件成立则返回，不成立则返回 NULL(branch_name)

SELECT `emp_id`,`name`,`branch_name`
FROM `employee` LEFT JOIN `branch`
ON `emp_id` = `manager_id`;

-- RIGHT JOIN
-- 右边的表格不管条件是否成立都回传(branch_name)
-- 左边的表格条件成立则返回，不成立则返回 NULL(emp_id, name)

SELECT `emp_id`,`name`,`branch_name`
FROM `employee` RIGHT JOIN `branch`
ON `emp_id` = `manager_id`;

------------------------------------------------
-- subquery 子查询

-- 1. 找出开发部门的经理名字
SELECT `name`
FROM `employee`
WHERE `emp_id` = (
  SELECT `manager_id`
  FROM `branch`
  WHERE `branch_name` = '开发'
);


-- 2. 找出对单一客户销售金额超过50000的员工名字
-- 单一结果用 = 判断，多种结果用 IN

SELECT `name`
FROM `employee`
WHERE `emp_id` IN(
  SELECT `emp_id`
  FROM `work_with`
  WHERE `total_sales` > 50000
);

------------------------------------------------
-- ON DELETE

-- ON DELETE SET NULL: 如果某一元素被之后删除则设为 NULL
-- P.S. 当属性同时为 PRIMARY KEY & FOREIGN KEY, 则不能设置为 NULL

-- ON DELETE CASCADE(同步): 如果某一元素被之后删除则设该元素一起被删除

DELETE FROM `employee` WHERE `emp_id` = 207;
SELECT * FROM `branch`;
SELECT * FROM `work_with`;
