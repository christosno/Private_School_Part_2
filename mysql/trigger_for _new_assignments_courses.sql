
drop trigger if exists insert_stud_cout_ass1;
DELIMITER //

CREATE TRIGGER insert_stud_cout_ass1
	AFTER INSERT ON assignments_courses
    FOR EACH ROW
  
BEGIN 
	DECLARE done INT default False;
    DECLARE ids int;
    
	DECLARE 
		cur1 cursor for
		select student_id
		from students_courses
		where course_id = new.course_id;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN cur1;
		ins_loop: LOOP
			FETCH cur1 INTO ids;
            IF done THEN
				leave ins_loop;
			end if;
            insert into assignments_students_courses 
            values (new.course_id, ids, new.assignment_id, NULL, NULL);
		END LOOP;
	
	CLOSE cur1;

	END //

DELIMITER ;