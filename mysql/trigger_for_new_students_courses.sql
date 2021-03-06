drop trigger if exists insert_stud_cout_ass;
DELIMITER //

CREATE TRIGGER insert_stud_cout_ass
	AFTER INSERT ON students_courses
    FOR EACH ROW
  
BEGIN 
	DECLARE done INT default False;
    DECLARE ids int;
    
	DECLARE 
		cur1 cursor for
		select assignment_id
		from assignments_courses
		where course_id = new.course_id;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN cur1;
		ins_loop: LOOP
			FETCH cur1 INTO ids;
            IF done THEN
				leave ins_loop;
			end if;
            insert into assignments_students_courses 
            values (new.course_id, new.student_id, ids, NULL, NULL);
		END LOOP;
	
	CLOSE cur1;

	END //

DELIMITER ;
    


	   
