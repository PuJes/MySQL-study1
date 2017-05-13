-- 创建一个schema名字是university
CREATE SCHEMA `university1` ;

-- 创建第一个表department
CREATE TABLE `university1`.`department` (
  `depart_name` VARCHAR(45) NOT NULL,	-- 字符型 不能为空
  `building` VARCHAR(45) NULL,	-- 字符型 可以为空
  `budget` INT(10) UNSIGNED NULL,	-- 整型 无符号 可以为空
  PRIMARY KEY (`depart_name`));	-- depart——name作为主键



-- 创建第二个表student
CREATE TABLE `university1`.`student` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,	-- 整型 无符号 不能为空 自增型
  `name` VARCHAR(45) NULL,	-- 字符型 可以为空
  `sex` CHAR(1) NULL,	-- 字符型 可以为空
  `age` INT(10) UNSIGNED NULL,	-- 整型 无符号 可以为空
  `emotion_state` VARCHAR(45) NULL,	-- 字符型 可以为空
  `depart_name` VARCHAR(45) NULL,	-- 字符型 可以为空
  PRIMARY KEY (`ID`),	-- ID作为主键
  INDEX `fk_student_1_idx` (`depart_name` ASC),
  CONSTRAINT `fk_student_1`
    FOREIGN KEY (`depart_name`)
    REFERENCES `university1`.`department` (`depart_name`)	-- student中的depart——name以表department中的depart——name为外键
    ON DELETE SET NULL 	-- 如果department中的depart——name被删除那么student中的depart——name会被置空
    ON UPDATE CASCADE);	-- 如果student中的depart——name的有不存在于department中的depart——name的新的更新那么父表也会跟着更新

-- 创建第三个表
CREATE TABLE `university1`.`exam` (
  `student_ID` INT UNSIGNED NULL,
  `exam_name` VARCHAR(45) NULL,
  `grade` INT(10) UNSIGNED NULL,
  PRIMARY KEY (`student_ID`,`exam_name`),	-- student——ID和exam_name作为组合主键
  CONSTRAINT `fk_exam_1`
    FOREIGN KEY (`student_ID`)
    REFERENCES `university1`.`student` (`ID`)	-- exam中的student——ID以表student中的ID为外键
    ON DELETE CASCADE	-- student中的ID被删除，exam中的student也跟着被删除
    ON UPDATE CASCADE);	-- student中的ID被更新，exam中的student也跟着被更新



