DROP PROCEDURE backup_main_tables;
DELIMITER $$
CREATE PROCEDURE backup_main_tables()
BEGIN
  -- setup for today's backup
  SET @today_table_name := concat('bkp_employees_',date_format(curdate(), '%m_%d_%Y'));
  SET @today_stmnt := concat('create table ', @today_table_name, ' select * from employees;');
  -- setup for yesterday's backup removal
  SET @yesterday_table_name := concat('bkp_employees_',date_format(curdate()-1, '%m_%d_%Y'));
  SET @yesterday_stmnt := concat('drop table ', @yesterday_table_name);
  -- execute today's plan
  PREPARE today_stmt FROM @today_stmnt;
  EXECUTE today_stmt;
  -- remove yesterday's backup
  PREPARE yesterday_stmt FROM @yesterday_stmnt;
  EXECUTE yesterday_stmt;
END $$
DELIMITER ;
