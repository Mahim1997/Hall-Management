-- TABLE_STUDENT (1 trigger)

-- > student’s “hall_history”’s end date will be set to the current date.
-- > student’s “room_history”’s end date will be set to the current date.
-- > references in “guestList” , “Guest_log”, “application” table are to be deleted.
-- 


BEGIN
      EXECUTE IMMEDIATE 'DROP trigger trig_student_type_grad';
  EXCEPTION
      WHEN OTHERS THEN NULL;
END;
/


CREATE OR REPLACE TRIGGER trig_student_type_grad 
AFTER UPDATE OF type ON TABLE_STUDENT 
FOR EACH ROW
DECLARE
	guest_nos_is_allowed INT;
BEGIN

		IF lower(:new.type)='grad' and lower(:old.type)!='grad' THEN
		
			-- UPDATE hall history 			
			UPDATE TABLE_STUDENT_HALL_HISTORY
			SET TABLE_STUDENT_HALL_HISTORY.END_DATE = CURRENT_DATE
			WHERE TABLE_STUDENT_HALL_HISTORY.STUDENT_ID=:new.ID and TABLE_STUDENT_HALL_HISTORY.END_DATE is null;
			
			-- UPDATE room history 			
			UPDATE TABLE_ROOM_HISTORY
			SET TABLE_ROOM_HISTORY.END_DATE = CURRENT_DATE
			WHERE TABLE_ROOM_HISTORY.STUDENT_ID=:new.ID and TABLE_ROOM_HISTORY.END_DATE is null;
			
			
		
			-- DELETE allowed guest
			DELETE FROM TABLE_ALLOWED_GUEST
			WHERE TABLE_ALLOWED_GUEST.STUDENT_ID = :new.ID;
			
			-- DELETE guest log
			DELETE FROM TABLE_GUEST_LOG
			WHERE TABLE_GUEST_LOG.STUDENT_ID = :new.ID;
			
			
-- 			-- DELETE room history
-- 			DELETE FROM TABLE_ROOM_HISTORY
-- 			WHERE TABLE_ROOM_HISTORY.STUDENT_ID = :new.ID;
			
			-- DELETE Applications
			DELETE FROM TABLE_APPLICATION
			WHERE TABLE_APPLICATION.STUDENT_ID = :new.ID;
			
			
		END IF;
-- 		SELECT COUNT(*) into guest_nos_is_allowed
-- 		FROM TABLE_ALLOWED_GUEST 
-- 		WHERE TABLE_ALLOWED_GUEST.STUDENT_ID != :new.ID; -- TABLE_ALLOWED_GUEST.NID = :new.NID and 
-- 		DBMS_OUTPUT.PUT_LINE(guest_nos_is_allowed);
-- 

END;
/
-- alter TRIGGER trig_student_type_grad DISABLE;

-- alter TRIGGER trig_student_type_grad GRANT UPDATE table ;



















-- TABLE_ROOM_HISTORY (2 triggers)

/*
Optimized one is not taken
*/


-- -	when a student is added
-- > decrease “room”’s old room_std_nos -= 1
-- > increase “room”’s new room_std_nos += 1
-- 
-- 
-- -	when a room’s end date is added
-- 	 -	> “room”’s std_nos -= 1
-- -	when an entry is added
-- 	 -	> if end_date is null “room”’s std_nos += 1
-- 


BEGIN
      EXECUTE IMMEDIATE 'DROP trigger trig_room_history_insert';
  EXCEPTION
      WHEN OTHERS THEN NULL;
END;
/


create or replace TRIGGER trig_room_history_insert 
AFTER INSERT ON TABLE_ROOM_HISTORY 
FOR EACH ROW
DECLARE
	std_type VARCHAR2(50);
BEGIN

	SELECT TABLE_STUDENT.TYPE into std_type
	FROM TABLE_STUDENT
	WHERE TABLE_STUDENT.ID=:new.STUDENT_ID;

	IF :new.END_DATE is null and lower(std_type) != 'grad' THEN -- and lower(std_type) != 'attached' THEN
		-- take inserted student into count
		UPDATE TABLE_ROOM
		SET TABLE_ROOM."current no of residents" = TABLE_ROOM."current no of residents" + 1
		WHERE TABLE_ROOM.HALL_ID = :new.HALL_ID and TABLE_ROOM.ROOM_NO = :new.ROOM_NO;
	END IF;

END;
/







-- -	when a student is added
-- > decrease “room”’s old room_std_nos -= 1
-- > increase “room”’s new room_std_nos += 1
-- 
-- 
-- -	when a room’s end date is added
-- 	 -	> “room”’s std_nos -= 1
-- -	when an entry is added
-- 	 -	> if end_date is null “room”’s std_nos += 1
-- 


BEGIN
      EXECUTE IMMEDIATE 'DROP trigger trig_room_history_end_date';
  EXCEPTION
      WHEN OTHERS THEN NULL;
END;
/


create or replace TRIGGER trig_room_history_end_date 
BEFORE UPDATE OF END_DATE ON TABLE_ROOM_HISTORY 
FOR EACH ROW
DECLARE

BEGIN
	IF :old.END_DATE is null and :new.END_DATE is not null THEN
	
		-- decrement total std nos
		UPDATE TABLE_ROOM
		SET TABLE_ROOM."current no of residents"=TABLE_ROOM."current no of residents"-1
		WHERE TABLE_ROOM.HALL_ID = :old.HALL_ID and TABLE_ROOM.ROOM_NO=:old.ROOM_NO;

		
	END IF;

END;
/












-- TABLE_APPLICATION (1 trigger)

create or replace TRIGGER trig_application_accepted 
BEFORE UPDATE OF STATUS ON TABLE_APPLICATION 
FOR EACH ROW

BEGIN
	IF :new.STATUS = 'ACCEPTED' THEN
		IF :old.CURRENT_ROOMID is not null  THEN 
			-- removing from old room
			UPDATE TABLE_ROOM_HISTORY
			SET TABLE_ROOM_HISTORY.END_DATE=CURRENT_DATE
			WHERE TABLE_ROOM_HISTORY.HALL_ID=:new.HALL_ID and TABLE_ROOM_HISTORY.ROOM_NO=:old.CURRENT_ROOMID and
			TABLE_ROOM_HISTORY.STUDENT_ID=:old.STUDENT_ID and TABLE_ROOM_HISTORY.END_DATE is null;
		ELSE
			-- setting type to resident
			UPDATE TABLE_STUDENT SET TABLE_STUDENT.TYPE = 'resident' WHERE TABLE_STUDENT.ID = :new.STUDENT_ID;
		END IF;

		-- alloting new room
		INSERT INTO TABLE_ROOM_HISTORY (HALL_ID,ROOM_NO,STUDENT_ID,START_DATE) 
		VALUES(:new.HALL_ID,:new.ALLOTTED_ROOM_NO,:new.STUDENT_ID,CURRENT_DATE);
	END IF;
END;
/
