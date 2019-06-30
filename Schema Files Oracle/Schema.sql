BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Student_Hall_History';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Room_History';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Guest_log';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_GuestLog';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Hall_Head_History';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Staff_worksAt_Hall';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Student_forms_Team';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Winner_List';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Team_Event_History';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Inter_Hall_Team';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Application_room_list';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Application';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/







BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Allowed_Guest';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/









begin
   execute immediate 'drop table table_Student';
exception
   when others then null;
end;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Room';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_event';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/





BEGIN
   execute immediate 'drop table table_teacher';
exception
   when others then null;
end;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_team';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_staff';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Guest';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_hall';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/










-- TABLE --


-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- Layer 1
-- (


-- Hall
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_hall';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE table_Hall (
	hall_id NUMBER(10) not nuLL,
	hall_name VARCHAR2(30) UNIQUE not nuLL,
	hall_location VARCHAR2(50) not nuLL,
	hall_gender VARCHAR2(1) not null CHECK (hall_gender='F' or hall_gender='M'), 
	
	PRIMARY KEY(hall_id)
);

-- ///////////////////////////////////

-- Guest(NID, first_name, last_name, contact_no, address)
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Guest';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE table_guest(

	NID VARCHAR2(20) NOT NULL,
	first_name VARCHAR2(20) not nuLL,
	last_name VARCHAR2(20) not nuLL, 
	contact_no VARCHAR2(15) default nuLL,
	address VARCHAR2(50) not null,
	
	PRIMARY KEY (NID)
) ;

-- ///////////////////////////////////

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_guest_pass';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE table_guest_pass(

	NID VARCHAR2(20) NOT NULL,
    "password" VARCHAR2(20) NOT NULL ,
	
	PRIMARY KEY (NID),
    FOREIGN KEY (NID) REFERENCES table_guest( NID ) ON DELETE CASCADE
) ;
-- ///////////////////////////////////

-- Teacher
-- Teacher( id(PK) , name, dept_name, designation, contact_no, teacher_password) 
begin
   execute immediate 'drop table table_teacher';
exception
   when others then null;
end;
/
CREATE TABLE table_Teacher(
	id NUMBER(10) not null,
	first_name VARCHAR2(20) not nuLL,
	last_name VARCHAR2(20) not nuLL, 
	department_id VARCHAR2(20) not nuLL, 
	designation VARCHAR2(20) not nuLL,
	contact_no VARCHAR2(15) default nuLL,
	password VARCHAR2(10) not null,
	gender VARCHAR2(1) not null CHECK (gender='F' or gender='M'), 
	
	PRIMARY KEY (id) 
);

-- Lecturer|Assistant Professor|Associate Professor|Professor
-- CSE|EEE|CE|CHE|URP|IPO|MME|ME

-- ///////////////////////////////////


-- Team

-- Team( team_name(PK), year(PK), sport)
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_team';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE TABLE_TEAM (
	
	team_id VARCHAR2(20) NOT NULL , -- PK
	team_name VARCHAR2(30) NOT NULL,
	team_year VARCHAR2(20) NOT NULL, 
	team_sport VARCHAR2(30) NOT NULL,
	team_type VARCHAR2(20) NOT NULL, -- GLOBAL/LOCAL 
	hall_id VARCHAR2(10) NOT NULL,
	captain_student_ID VARCHAR2(20) DEFAULT NULL ,

	
	PRIMARY KEY(team_id),
	
	FOREIGN KEY(captain_student_ID)	REFERENCES table_student(id) ON DELETE CASCADE
) ;
-- ///////////////////////////////////


-- Staff
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_staff';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE table_Staff (
	id NUMBER(10) not nuLL,
	staff_name VARCHAR2(30) not nuLL,
	job_type VARCHAR2(30) not nuLL,
	contact_no VARCHAR2(15) default null ,
	staff_password VARCHAR2(20) not nuLL,

	PRIMARY KEY(id)
);

-- ///////////////////////////////////


-- )
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\









-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- Layer 2
-- (

-- Student

-- Student( id(PK) , name, contact_no, dept_name, address, bank_account_no, type, hall_id(FK), birth_date,father_name, mother_name, blood_grp, gender, religion, student_password) 
begin
   execute immediate 'drop table table_Student';
exception
   when others then null;
end;
/
CREATE TABLE table_Student(

	id VARCHAR2(15) not null, -- string coz can start with 0
	first_name VARCHAR2(20) not nuLL,
	last_name VARCHAR2(20) not nuLL, 

	department_id VARCHAR2(20) not nuLL, 
	address VARCHAR2(50) not nuLL,
	blood_group VARCHAR2(5) DEFAULT null, 	
	birth_date DATE not null, 	-- problem date type missing
	type VARCHAR2(8) not null,
	hall_id NUMBER(10) ,
	religion VARCHAR2(15) not null, 	-- len(max) = len('Christanity') = 11
	gender VARCHAR2(1) not null CHECK (gender='F' or gender='M'), 
	password VARCHAR2(20) not null,
	
	father_name VARCHAR2(30) not nuLL,
	mother_name VARCHAR2(30) not nuLL,
	contact_no VARCHAR2(15) default nuLL,
	
	PRIMARY KEY (id) ,
	
	FOREIGN KEY (hall_id) REFERENCES table_hall(hall_id) ON DELETE SET NULL 
			
);

-- ///////////////////////////////////


-- Room

-- Room( hall_id(FK) , room_id(PK) , room_capacity, current_no_of residents)

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Room';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE table_Room (
	
	hall_id NUMBER(10),
	room_no NUMBER(10) not nuLL,
	room_capacity NUMBER(10) not nuLL ,
	"current no of residents" NUMBER(10) DEFAULT 0 not nuLL, 
	
	PRIMARY KEY(hall_id,room_no),
	
	FOREIGN KEY(hall_id) REFERENCES table_hall(hall_id) ON DELETE CASCADE
);
-- ///////////////////////////////////


-- Event

-- Event( event_name(PK), year(PK),teacher_id(FK), sport)
-- TABLE_EVENT

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE TABLE_EVENT';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE TABLE_EVENT (
	
	event_id VARCHAR2(20) NOT NULL , -- PK
	
	event_name VARCHAR2(30) NOT NULL,
	event_year VARCHAR2(20) NOT NULL, 
	event_sport VARCHAR2(30) NOT NULL,
	
	event_type VARCHAR2(20) NOT NULL, -- GLOBAL/LOCAL 
	event_status VARCHAR2(20) NOT NULL , -- UPCOMING/ OVER
	hall_id VARCHAR2(10) DEFAULT NULL , -- FOR GLOBAL EVENT IT MAY BE NULL 
	
	event_supervisor_ID NUMBER(10) DEFAULT NULL ,
	
	winner_team_ID VARCHAR2(20) DEFAULT NULL,
	runnerUP_team_ID VARCHAR2(20) DEFAULT NULL,
	
	PRIMARY KEY(event_id),
	
	FOREIGN KEY(winner_team_ID) REFERENCES TABLE_TEAM(team_id) ON DELETE CASCADE,
	FOREIGN KEY(runnerUP_team_ID) REFERENCES TABLE_TEAM(team_id) ON DELETE CASCADE,
	FOREIGN KEY(event_supervisor_ID)	REFERENCES TABLE_TEACHER(id) ON DELETE CASCADE
) ;

-- Cricket|Football|Chess|TableTennis|BasketBall|Debate

-- ///////////////////////////////////












-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- Layer 3
-- (

-- Allowed_Guest

-- Allowed_Guest( student_id(FK), NID(FK),relation)
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Allowed_Guest';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE table_Allowed_Guest (

	NID VARCHAR2(20) NOT NULL,
	student_id VARCHAR2(15) not NULL,
	relation VARCHAR2(20) default null, 

	PRIMARY KEY (student_id, NID),
	
	FOREIGN KEY(student_id) REFERENCES table_STUDENT(id) ON DELETE CASCADE, 
	FOREIGN KEY(NID) REFERENCES table_GUEST(NID) ON DELETE CASCADE
);
-- ///////////////////////////////////

-- )
--  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\








-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- Layer 4
-- (

-- Hall_history

-- Student_Hall_History( hall_id(FK), student_id(FK), start_date, end_date)

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Student_Hall_History';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE table_Student_Hall_History (
	hall_id NUMBER(10) not nuLL,
	student_id VARCHAR2(15),
	start_date DATE,
	end_date DATE,
	
	PRIMARY KEY(hall_id,student_id),
	
	FOREIGN KEY (student_id) REFERENCES table_student(id) ON DELETE CASCADE,	
	FOREIGN KEY (hall_id) REFERENCES table_hall(hall_id) ON DELETE CASCADE
);
-- ///////////////////////////////////


-- Room_history

-- Room_history( hall_id(FK), room_id(FK), student_id(FK), start_date, end_date)
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Room_History';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE table_Room_History (
	hall_id NUMBER(10) not nuLL,
	room_no NUMBER(10) not nuLL,
	student_id VARCHAR2(15),
	start_date DATE,
	end_date DATE,
	
	PRIMARY KEY(hall_id,room_no,student_id,start_date),
	
	FOREIGN KEY (hall_id,room_no) REFERENCES table_room( hall_id , room_no) ON DELETE CASCADE,	
	FOREIGN KEY (student_id) REFERENCES table_student(id) ON DELETE CASCADE
);

-- ///////////////////////////////////

-- Teacher_Hall

-- Hall_Head_History( teacher_id(FK), hall_id(FK), start_date, end_date)

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Hall_Head_History';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE table_Hall_Head_History (

	teacher_id NUMBER(10) not nuLL,
	hall_id NUMBER(10),
	start_date DATE,
	end_date DATE,
	
	PRIMARY KEY(teacher_id, hall_id, start_date),
	
	FOREIGN KEY (teacher_id) REFERENCES table_teacher( id ) ON DELETE CASCADE  ,  
	FOREIGN KEY (hall_id) REFERENCES table_hall(hall_id)  ON DELETE CASCADE 
);
-- ///////////////////////////////////


-- Guest_log

-- Guest_Log( student_id(FK), name(FK),visiting_date, start_time, end_time)
-- TIMESTAMP IS LIKE THIS '2007-05-23 09:15:28'
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Guest_log';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE table_Guest_log (

	NID VARCHAR2(20) NOT NULL,
	student_id VARCHAR2(15) not NULL,
	start_time DATE,
	end_time DATE,
	
	PRIMARY KEY (student_id, NID,start_time),
	
	FOREIGN KEY(student_id) REFERENCES table_STUDENT(id) ON DELETE CASCADE, 
	FOREIGN KEY(NID) REFERENCES table_GUEST(NID) ON DELETE CASCADE								
);
-- ///////////////////////////////////


-- Staff_Hall

-- Staff_worksAt_Hall( staff_id(FK), hall_id(FK))

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Staff_worksAt_Hall';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE table_Staff_worksAt_Hall (
	
	hall_id NUMBER(10) not null,
	staff_id NUMBER(10), 
	
	PRIMARY KEY(hall_id,staff_id),
	
	FOREIGN KEY(hall_id) REFERENCES table_hall(hall_id) ON DELETE CASCADE,
	FOREIGN KEY(staff_id) REFERENCES table_staff(id) ON DELETE CASCADE
) ;
-- ///////////////////////////////////


-- Student_Team

-- Student_forms_Team( student_id(FK), team_name(FK), year(FK) , designation) 

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Student_forms_Team';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE TABLE_STUDENT_FORMS_TEAM (
	student_id VARCHAR2(15) NOT NULL,
	team_id VARCHAR2(30) NOT NULL,
	designation VARCHAR2(30) DEFAULT NULL ,
	
	PRIMARY KEY(student_id, team_id) ,
	
	FOREIGN KEY(student_id) REFERENCES TABLE_STUDENT(ID) ON DELETE CASCADE,
	FOREIGN KEY(team_id) REFERENCES TABLE_TEAM(team_id) ON DELETE CASCADE
) ;

-- ///////////////////////////////////


-- Winner

-- Winner_List( team_name(FK), event_name(FK), year(FK), position )

-- BEGIN
--    EXECUTE IMMEDIATE 'DROP TABLE table_Winner_List';
-- EXCEPTION
--    WHEN OTHERS THEN NULL;
-- END;
-- /
-- CREATE TABLE table_Winner_List (
-- 	team_name VARCHAR2(30) not null,
-- 	event_name VARCHAR2 ( 30 ) NOT NULL,	
-- 	"year" number(10) not null, 
-- 	position number(10) DEFAULT null,
	
-- 	PRIMARY KEY(team_name,event_name,"year"),
	
-- 	FOREIGN KEY(event_name,"year") REFERENCES table_event("NAME","YEAR") ON DELETE CASCADE,
-- 	FOREIGN KEY(team_name,"year")  REFERENCES  table_team("NAME","YEAR") ON DELETE CASCADE
-- ) ;
-- ///////////////////////////////////


-- Event_History

-- Team_Event_History( team_name(FK),year(FK), event_name(FK))

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Team_Event_History';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE TABLE_TEAM_EVENT_HISTORY (
	event_id VARCHAR2(20) NOT NULL,
	team_id VARCHAR2(20) NOT NULL,
	status VARCHAR2(20) DEFAULT NULL, -- EITHER 'UPCOMING' or 'OVER' OR simply null
	
	PRIMARY KEY(event_id, team_id) ,
	
	FOREIGN KEY(event_id) REFERENCES TABLE_EVENT(event_id) ON DELETE CASCADE,
	FOREIGN KEY(team_id) REFERENCES TABLE_TEAM(team_id) ON DELETE CASCADE
) ;

-- ///////////////////////////////////


-- Inter_Hall_Team

-- Inter_Hall_Team( team_name(FK), year(FK), hall_id(FK) ) 

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Inter_Hall_Team';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE table_Inter_Hall_Team (

	hall_id NUMBER(10) not nuLL,
	name VARCHAR2(15), 
	year NUMBER(10),
	SPORT VARCHAR2(30),
	PRIMARY KEY(hall_id, name, year),
	
	FOREIGN KEY (hall_id) REFERENCES table_hall( hall_id ) ON DELETE CASCADE 
-- 	,FOREIGN KEY (name, year) REFERENCES table_team( name, year ) ON DELETE CASCADE  	
	
);
-- ///////////////////////////////////


-- Application
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Application';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE table_Application (

	application_id NUMBER(10) not null ,
	student_id VARCHAR2(15) not null,
	hall_id NUMBER(10) not null,

	application_date DATE ,
	verdict_date DATE,
	
	
	current_roomID NUMBER(10) DEFAULT nuLL,
	
	has_room VARCHAR2(1) NOT NULL, -- Y or N so that application_room_list can be provided for this application or not
	status VARCHAR2(20) DEFAULT 'pending' NOT NULL,
	allotted_room_no NUMBER(10) default null,
	
	PRIMARY KEY(application_id),
	
	FOREIGN KEY(hall_id)  REFERENCES table_hall(hall_id) ON DELETE CASCADE,
	FOREIGN KEY(student_id)	REFERENCES table_student(id) ON DELETE CASCADE
	
);

-- ///////////////////////////////////

-- Application_List

-- Application_room_list(application_id, room_no)
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE table_Application_room_list';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE table_Application_room_list (

	application_id NUMBER(10) ,
	hall_id NUMBER(10) not null,
	room_no NUMBER(10) not null,
	
	PRIMARY KEY(application_id, room_no),
	
	FOREIGN KEY(application_id)  REFERENCES table_Application(application_id) ON DELETE CASCADE,	
 	FOREIGN KEY(hall_id,room_no) REFERENCES table_Room(hall_id,room_no) ON DELETE CASCADE
	
);

-- ///////////////////////////////////
-- )
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\


























































-- DATA --



-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- Layer 1
-- (


-- Hall
	INSERT INTO table_hall (hall_id,hall_name,hall_location,hall_gender)  SELECT 1, 'Ahsanullah', 'North_West', 'M' FROM dual UNION ALL   SELECT 2, 'Suhrawardy', 'East_West', 'M' FROM dual UNION ALL   SELECT 3, 'ChatriSouth', 'East_South', 'F' FROM dual UNION ALL   SELECT 4, 'ChatriNorth', 'North_East', 'F' FROM dual;

-- ///////////////////////////////////


-- Teacher
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password, gender)  SELECT 100,'Sade','Hermione','URP','Lecturer','0-336-266-9138','4971', 'F' FROM dual UNION ALL  SELECT 101,'Jasmine','Sonia','EEE','Assistant Professor','0-888-285-0254','3968', 'F' FROM dual UNION ALL  SELECT 102,'Hedy','Aurora','CE','Assistant Professor','0-402-381-4530','7578', 'F' FROM dual UNION ALL  SELECT 103,'Sophia','Winifred','ME','Professor','0-842-588-7941','9217', 'F' FROM dual UNION ALL  SELECT 104,'Zena','Maxine','MME','Assistant Professor','0-860-757-3713','5252', 'F' FROM dual UNION ALL  SELECT 105,'Kylynn','Whilemina','EEE','Professor','0-341-571-5549','3442', 'F' FROM dual UNION ALL  SELECT 106,'Sigourney','Bo','EEE','Assistant Professor','0-172-631-1842','7337', 'F' FROM dual UNION ALL  SELECT 107,'Yoshi','Brittany','ME','Assistant Professor','0-903-888-9024','6604', 'F' FROM dual UNION ALL  SELECT 108,'Morgan','Irma','CHE','Lecturer','0-287-848-2411','1868', 'F' FROM dual UNION ALL  SELECT 109,'Lynn','Lillian','MME','Professor','0-201-846-7651','8068', 'F' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password, gender)  SELECT 110,'Renee','Hilda','IPO','Associate Professor','0-833-805-8708','4625', 'F' FROM dual UNION ALL  SELECT 111,'Leigh','Rhiannon','CE','Lecturer','0-644-416-3578','2278', 'F' FROM dual UNION ALL  SELECT 112,'Tamekah','Rhonda','CE','Associate Professor','0-304-437-3494','6517', 'F' FROM dual UNION ALL  SELECT 113,'Iona','Desiree','EEE','Lecturer','0-779-145-2477','8413', 'F' FROM dual UNION ALL  SELECT 114,'Teagan','Quyn','EEE','Lecturer','0-523-366-5445','3929', 'F' FROM dual UNION ALL  SELECT 115,'Bethany','Gay','IPO','Associate Professor','0-367-607-4464','8253', 'F' FROM dual UNION ALL  SELECT 116,'Larissa','Lunea','CE','Associate Professor','0-278-864-8609','4213', 'F' FROM dual UNION ALL  SELECT 117,'Lavinia','Lillith','EEE','Lecturer','0-445-125-3167','9397', 'F' FROM dual UNION ALL  SELECT 118,'Alfreda','Amelia','URP','Lecturer','0-160-853-0264','8566', 'F' FROM dual UNION ALL  SELECT 119,'Nayda','Sybill','CE','Professor','0-336-705-2910','7951', 'F' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password, gender)  SELECT 120,'Flavia','Patricia','CSE','Assistant Professor','0-506-906-7775','7934', 'F' FROM dual UNION ALL  SELECT 121,'Madison','Eleanor','CSE','Assistant Professor','0-734-485-4029','2215', 'F' FROM dual UNION ALL  SELECT 122,'Illana','Breanna','MME','Lecturer','0-521-540-1315','6759', 'F' FROM dual UNION ALL  SELECT 123,'Marcia','Uta','EEE','Assistant Professor','0-687-315-0609','1637', 'F' FROM dual UNION ALL  SELECT 124,'Mari','Kiona','URP','Assistant Professor','0-866-517-7392','1579', 'F' FROM dual UNION ALL  SELECT 125,'Stacy','Rinah','EEE','Lecturer','0-950-411-7198','2494', 'F' FROM dual UNION ALL  SELECT 126,'Remedios','Beatrice','CE','Professor','0-158-926-8252','3725', 'F' FROM dual UNION ALL  SELECT 127,'Candace','Genevieve','CE','Assistant Professor','0-697-155-3431','3839', 'F' FROM dual UNION ALL  SELECT 128,'Urielle','Hedy','CE','Associate Professor','0-360-594-1662','9096', 'F' FROM dual UNION ALL  SELECT 129,'Candice','Hedda','IPO','Lecturer','0-255-368-0482','9583', 'F' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password, gender)  SELECT 130,'Jaden','Autumn','MME','Associate Professor','0-281-371-3749','3629', 'F' FROM dual UNION ALL  SELECT 131,'Beverly','Glenna','EEE','Professor','0-977-416-8375','9665', 'F' FROM dual UNION ALL  SELECT 132,'Patience','Sonia','CSE','Lecturer','0-429-932-7740','7749', 'F' FROM dual UNION ALL  SELECT 133,'Unity','Azalia','CHE','Professor','0-801-856-9654','6596', 'F' FROM dual UNION ALL  SELECT 134,'Dara','Tatyana','CE','Professor','0-971-465-4004','1797', 'F' FROM dual UNION ALL  SELECT 135,'Deirdre','Sasha','MME','Assistant Professor','0-427-392-6334','4345', 'F' FROM dual UNION ALL  SELECT 136,'Jocelyn','Violet','CE','Associate Professor','0-637-710-4003','3052', 'F' FROM dual UNION ALL  SELECT 137,'Justine','Haley','MME','Professor','0-247-670-6153','3957', 'F' FROM dual UNION ALL  SELECT 138,'Veda','Zoe','MME','Associate Professor','0-328-752-4216','2981', 'F' FROM dual UNION ALL  SELECT 139,'Carol','Sydney','IPO','Associate Professor','0-183-484-8700','4797', 'F' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password, gender)  SELECT 140,'Simone','Regan','MME','Lecturer','0-419-913-3049','8650', 'F' FROM dual UNION ALL  SELECT 141,'Shaine','Aiko','ME','Lecturer','0-369-849-2657','3589', 'F' FROM dual UNION ALL  SELECT 142,'Angelica','Macy','URP','Professor','0-751-865-5276','7917', 'F' FROM dual UNION ALL  SELECT 143,'Ori','Yolanda','CE','Associate Professor','0-524-566-2051','5510', 'F' FROM dual UNION ALL  SELECT 144,'Lael','Nina','CE','Assistant Professor','0-700-100-1768','7621', 'F' FROM dual UNION ALL  SELECT 145,'Rhoda','Ginger','CSE','Lecturer','0-113-532-3089','1349', 'F' FROM dual UNION ALL  SELECT 146,'Deborah','Gwendolyn','MME','Professor','0-816-374-9616','1643', 'F' FROM dual UNION ALL  SELECT 147,'Candice','Darryl','IPO','Professor','0-521-998-6429','1543', 'F' FROM dual UNION ALL  SELECT 148,'Nicole','Jordan','CE','Assistant Professor','0-470-533-1631','1610', 'F' FROM dual UNION ALL  SELECT 149,'Keely','Carla','ME','Associate Professor','0-515-583-0216','1803', 'F' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password, gender)  SELECT 150,'Kelsie','Laurel','CE','Professor','0-498-458-8758','2346', 'F' FROM dual UNION ALL  SELECT 151,'Whilemina','Alexa','EEE','Associate Professor','0-336-438-1235','7305', 'F' FROM dual UNION ALL  SELECT 152,'Cassandra','Myra','CHE','Professor','0-876-267-0943','5889', 'F' FROM dual UNION ALL  SELECT 153,'Janna','Heather','URP','Lecturer','0-210-223-7284','4953', 'F' FROM dual UNION ALL  SELECT 154,'Aretha','Mallory','URP','Professor','0-353-542-5351','8360', 'F' FROM dual UNION ALL  SELECT 155,'Velma','Christine','CSE','Assistant Professor','0-821-491-4032','1614', 'F' FROM dual UNION ALL  SELECT 156,'Octavia','Catherine','EEE','Professor','0-655-671-3329','3012', 'F' FROM dual UNION ALL  SELECT 157,'Fallon','Harriet','URP','Professor','0-845-819-8215','2830', 'F' FROM dual UNION ALL  SELECT 158,'Dacey','Lareina','CHE','Professor','0-943-885-3827','4841', 'F' FROM dual UNION ALL  SELECT 159,'Ulla','Dahlia','IPO','Lecturer','0-979-462-0620','4271', 'F' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password, gender)  SELECT 160,'Rae','Rosalyn','CHE','Lecturer','0-552-404-9793','9839', 'F' FROM dual UNION ALL  SELECT 161,'Chloe','Sierra','ME','Assistant Professor','0-290-782-7637','4251', 'F' FROM dual UNION ALL  SELECT 162,'Zelda','Charity','ME','Assistant Professor','0-515-118-6634','5978', 'F' FROM dual UNION ALL  SELECT 163,'Charissa','Eve','CSE','Associate Professor','0-885-799-1683','9796', 'F' FROM dual UNION ALL  SELECT 164,'Athena','Rhona','ME','Lecturer','0-616-428-3781','2060', 'F' FROM dual UNION ALL  SELECT 165,'Hadassah','Helen','IPO','Assistant Professor','0-365-278-7416','7313', 'F' FROM dual UNION ALL  SELECT 166,'Tashya','Joan','IPO','Professor','0-877-831-4576','2026', 'F' FROM dual UNION ALL  SELECT 167,'Melinda','Idona','IPO','Assistant Professor','0-385-666-8549','6910', 'F' FROM dual UNION ALL  SELECT 168,'Hedwig','Janna','IPO','Professor','0-821-305-2098','6816', 'F' FROM dual UNION ALL  SELECT 169,'Francesca','Halla','URP','Lecturer','0-825-688-5369','3938', 'F' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password, gender)  SELECT 170,'Yetta','Xyla','CE','Associate Professor','0-641-538-5835','9231', 'F' FROM dual UNION ALL  SELECT 171,'Aurora','Brynn','CHE','Assistant Professor','0-342-159-2766','4084', 'F' FROM dual UNION ALL  SELECT 172,'Tatiana','Halee','MME','Associate Professor','0-516-210-3380','3430', 'F' FROM dual UNION ALL  SELECT 173,'Ashely','Octavia','CSE','Lecturer','0-749-434-5819','5595', 'F' FROM dual UNION ALL  SELECT 174,'Raven','Uta','EEE','Lecturer','0-635-703-8689','1944', 'F' FROM dual UNION ALL  SELECT 175,'Priscilla','Kevyn','CHE','Associate Professor','0-105-746-0292','7597', 'F' FROM dual UNION ALL  SELECT 176,'Lois','Hermione','IPO','Associate Professor','0-821-584-2774','3352', 'F' FROM dual UNION ALL  SELECT 177,'Orli','Ariel','MME','Associate Professor','0-468-463-3361','7491', 'F' FROM dual UNION ALL  SELECT 178,'Maisie','Phoebe','CE','Associate Professor','0-908-104-3909','7369', 'F' FROM dual UNION ALL  SELECT 179,'Jenette','Roanna','CHE','Lecturer','0-748-377-8879','9794', 'F' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password, gender)  SELECT 180,'Jacqueline','Alice','CE','Assistant Professor','0-559-693-9194','5183', 'F' FROM dual UNION ALL  SELECT 181,'Heidi','Danielle','MME','Professor','0-325-328-8824','7557', 'F' FROM dual UNION ALL  SELECT 182,'Quail','Justina','CHE','Lecturer','0-975-907-8643','1335', 'F' FROM dual UNION ALL  SELECT 183,'Mallory','Amy','CE','Associate Professor','0-260-466-2346','7868', 'F' FROM dual UNION ALL  SELECT 184,'Rose','Pandora','EEE','Lecturer','0-187-500-5875','8015', 'F' FROM dual UNION ALL  SELECT 185,'Sacha','Ella','CSE','Professor','0-700-165-6180','1375', 'F' FROM dual UNION ALL  SELECT 186,'Jacqueline','Patricia','CSE','Associate Professor','0-310-195-8478','2553', 'F' FROM dual UNION ALL  SELECT 187,'Shoshana','Felicia','IPO','Lecturer','0-151-418-7578','2001', 'F' FROM dual UNION ALL  SELECT 188,'Hilary','Ann','IPO','Professor','0-495-906-9639','3409', 'F' FROM dual UNION ALL  SELECT 189,'Hyacinth','Noelle','IPO','Assistant Professor','0-870-261-1356','6179', 'F' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password, gender)  SELECT 190,'Quincy','Miranda','URP','Professor','0-816-399-4927','8047', 'F' FROM dual UNION ALL  SELECT 191,'Beatrice','Raven','CE','Lecturer','0-857-442-4341','3661', 'F' FROM dual UNION ALL  SELECT 192,'Shannon','Mara','URP','Lecturer','0-832-760-9978','9414', 'F' FROM dual UNION ALL  SELECT 193,'Idola','Darrel','CE','Associate Professor','0-255-673-2531','5542', 'F' FROM dual UNION ALL  SELECT 194,'Yoko','Sydnee','CSE','Professor','0-867-716-6017','9011', 'F' FROM dual UNION ALL  SELECT 195,'Nerea','Nadine','MME','Professor','0-590-846-0351','3519', 'F' FROM dual UNION ALL  SELECT 196,'Maite','Quon','CSE','Associate Professor','0-288-519-0860','4157', 'F' FROM dual UNION ALL  SELECT 197,'Carla','Cheyenne','CSE','Associate Professor','0-745-404-4791','2539', 'F' FROM dual UNION ALL  SELECT 198,'Kiona','Taylor','CHE','Associate Professor','0-237-668-2895','1563', 'F' FROM dual UNION ALL  SELECT 199,'Quynn','Isabelle','IPO','Assistant Professor','0-780-288-4712','2018', 'F' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password,gender)  SELECT 200,'Perry','Giacomo','CSE','Professor','01-83-463-9148','6103','M' FROM dual UNION ALL  SELECT 201,'Zahir','Lamar','CHE','Assistant Professor','01-29-277-2797','8334','M' FROM dual UNION ALL  SELECT 202,'Elmo','Cameron','CHE','Assistant Professor','01-51-556-3834','3573','M' FROM dual UNION ALL  SELECT 203,'Howard','Lester','CSE','Associate Professor','01-68-534-1883','5160','M' FROM dual UNION ALL  SELECT 204,'Yuli','Elliott','IPO','Associate Professor','01-63-661-4212','2847','M' FROM dual UNION ALL  SELECT 205,'Jacob','Malcolm','EEE','Assistant Professor','01-04-108-8599','1498','M' FROM dual UNION ALL  SELECT 206,'Vaughan','Josiah','CHE','Associate Professor','01-37-223-8021','2530','M' FROM dual UNION ALL  SELECT 207,'Oliver','Tiger','MME','Professor','01-40-136-8645','1229','M' FROM dual UNION ALL  SELECT 208,'Clark','Patrick','CE','Assistant Professor','01-92-445-2498','5407','M' FROM dual UNION ALL  SELECT 209,'Colby','Brent','URP','Professor','01-68-171-6047','6509','M' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password,gender)  SELECT 210,'Ulric','Xenos','EEE','Lecturer','01-39-229-4244','3102','M' FROM dual UNION ALL  SELECT 211,'Nathan','Hasad','IPO','Lecturer','01-84-998-7430','2519','M' FROM dual UNION ALL  SELECT 212,'Owen','Steven','ME','Lecturer','01-70-308-2594','4161','M' FROM dual UNION ALL  SELECT 213,'Gabriel','Caleb','CSE','Assistant Professor','01-65-676-3968','4598','M' FROM dual UNION ALL  SELECT 214,'Gavin','Ralph','MME','Professor','01-28-527-8847','8695','M' FROM dual UNION ALL  SELECT 215,'Yardley','Porter','CSE','Professor','01-94-265-5093','9915','M' FROM dual UNION ALL  SELECT 216,'Leo','Barry','CHE','Associate Professor','01-24-961-4456','6767','M' FROM dual UNION ALL  SELECT 217,'Coby','Nehru','IPO','Professor','01-36-892-4882','7356','M' FROM dual UNION ALL  SELECT 218,'Leonard','Allistair','IPO','Assistant Professor','01-03-397-6023','3970','M' FROM dual UNION ALL  SELECT 219,'Samson','Zachary','CE','Assistant Professor','01-10-674-9325','2161','M' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password,gender)  SELECT 220,'Aaron','Dustin','IPO','Lecturer','01-05-637-6168','5580','M' FROM dual UNION ALL  SELECT 221,'Mason','Gareth','CE','Associate Professor','01-32-398-4950','2212','M' FROM dual UNION ALL  SELECT 222,'Marshall','Michael','CSE','Lecturer','01-66-795-2760','6875','M' FROM dual UNION ALL  SELECT 223,'Caesar','Brian','ME','Associate Professor','01-26-743-2938','8337','M' FROM dual UNION ALL  SELECT 224,'Victor','Nero','IPO','Professor','01-39-345-7025','4474','M' FROM dual UNION ALL  SELECT 225,'Harrison','Melvin','MME','Associate Professor','01-43-795-1450','3072','M' FROM dual UNION ALL  SELECT 226,'Aaron','Nicholas','CSE','Associate Professor','01-27-993-5801','1369','M' FROM dual UNION ALL  SELECT 227,'Brenden','Drew','CE','Lecturer','01-32-823-6698','8313','M' FROM dual UNION ALL  SELECT 228,'Wayne','Cadman','ME','Lecturer','01-21-876-7144','9808','M' FROM dual UNION ALL  SELECT 229,'Yasir','Zeph','IPO','Lecturer','01-23-378-3729','7345','M' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password,gender)  SELECT 230,'Ryan','Kasper','ME','Associate Professor','01-86-505-2722','2751','M' FROM dual UNION ALL  SELECT 231,'Myles','Rogan','CHE','Assistant Professor','01-75-637-8826','4063','M' FROM dual UNION ALL  SELECT 232,'Rashad','Martin','ME','Assistant Professor','01-15-714-1355','6729','M' FROM dual UNION ALL  SELECT 233,'Otto','Nasim','CHE','Lecturer','01-88-507-3546','9000','M' FROM dual UNION ALL  SELECT 234,'Christopher','Lawrence','EEE','Assistant Professor','01-56-197-1675','8366','M' FROM dual UNION ALL  SELECT 235,'Chase','Austin','CSE','Lecturer','01-81-479-8321','3645','M' FROM dual UNION ALL  SELECT 236,'Xavier','Grady','ME','Assistant Professor','01-67-238-5267','7921','M' FROM dual UNION ALL  SELECT 237,'Holmes','Emery','MME','Professor','01-98-623-9802','2354','M' FROM dual UNION ALL  SELECT 238,'Rajah','Dennis','ME','Lecturer','01-28-192-3683','1139','M' FROM dual UNION ALL  SELECT 239,'Fulton','Caldwell','EEE','Assistant Professor','01-92-822-1153','3324','M' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password,gender)  SELECT 240,'Ian','Jelani','CHE','Lecturer','01-79-655-7603','4432','M' FROM dual UNION ALL  SELECT 241,'Silas','Beau','CE','Assistant Professor','01-08-582-4624','4095','M' FROM dual UNION ALL  SELECT 242,'Micah','Emmanuel','CSE','Lecturer','01-21-796-8570','6387','M' FROM dual UNION ALL  SELECT 243,'Caleb','Sebastian','ME','Associate Professor','01-31-520-0661','8030','M' FROM dual UNION ALL  SELECT 244,'Holmes','Stone','MME','Assistant Professor','01-98-764-2267','6461','M' FROM dual UNION ALL  SELECT 245,'Joseph','Ryder','CSE','Lecturer','01-78-918-5546','3232','M' FROM dual UNION ALL  SELECT 246,'Flynn','Xenos','CE','Assistant Professor','01-52-965-2845','2265','M' FROM dual UNION ALL  SELECT 247,'Griffith','Dalton','EEE','Lecturer','01-14-719-9180','7934','M' FROM dual UNION ALL  SELECT 248,'Alden','Aquila','EEE','Lecturer','01-48-371-6478','2651','M' FROM dual UNION ALL  SELECT 249,'Elvis','Hakeem','IPO','Professor','01-53-714-3292','7126','M' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password,gender)  SELECT 250,'Cody','Jordan','EEE','Associate Professor','01-17-709-4639','8184','M' FROM dual UNION ALL  SELECT 251,'Rahim','Melvin','CHE','Assistant Professor','01-40-559-1326','7072','M' FROM dual UNION ALL  SELECT 252,'Ray','Ezekiel','EEE','Lecturer','01-52-698-6979','8269','M' FROM dual UNION ALL  SELECT 253,'Daniel','Ross','IPO','Associate Professor','01-47-297-3665','1770','M' FROM dual UNION ALL  SELECT 254,'Thaddeus','Coby','EEE','Lecturer','01-91-302-8305','2734','M' FROM dual UNION ALL  SELECT 255,'Kaseem','Jerome','ME','Associate Professor','01-57-988-5291','7027','M' FROM dual UNION ALL  SELECT 256,'Keaton','Mark','CHE','Associate Professor','01-10-233-3290','5181','M' FROM dual UNION ALL  SELECT 257,'Lucian','Wylie','EEE','Assistant Professor','01-63-283-0292','8742','M' FROM dual UNION ALL  SELECT 258,'Aladdin','Scott','CSE','Professor','01-47-295-3020','2151','M' FROM dual UNION ALL  SELECT 259,'Nathaniel','Linus','CE','Professor','01-66-640-9137','3953','M' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password,gender)  SELECT 260,'Reece','Logan','CSE','Professor','01-38-464-6898','8745','M' FROM dual UNION ALL  SELECT 261,'Kaseem','Grady','MME','Associate Professor','01-08-690-1936','8856','M' FROM dual UNION ALL  SELECT 262,'Magee','Macaulay','URP','Assistant Professor','01-97-535-5624','6670','M' FROM dual UNION ALL  SELECT 263,'Emmanuel','Amery','CHE','Lecturer','01-02-346-6772','1473','M' FROM dual UNION ALL  SELECT 264,'Macon','Devin','ME','Associate Professor','01-86-261-8462','7937','M' FROM dual UNION ALL  SELECT 265,'Hu','Hall','IPO','Assistant Professor','01-43-491-9897','6856','M' FROM dual UNION ALL  SELECT 266,'Julian','Orson','URP','Professor','01-63-376-2969','5470','M' FROM dual UNION ALL  SELECT 267,'Aladdin','Rooney','CHE','Assistant Professor','01-26-901-6112','7147','M' FROM dual UNION ALL  SELECT 268,'Lewis','Len','MME','Assistant Professor','01-25-280-1118','8523','M' FROM dual UNION ALL  SELECT 269,'Nash','Akeem','CE','Assistant Professor','01-67-358-3547','8533','M' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password,gender)  SELECT 270,'Ishmael','Wade','URP','Assistant Professor','01-79-384-1319','7140','M' FROM dual UNION ALL  SELECT 271,'Wang','Eric','URP','Lecturer','01-36-523-2457','6103','M' FROM dual UNION ALL  SELECT 272,'Oleg','Fitzgerald','CHE','Lecturer','01-55-863-7840','5518','M' FROM dual UNION ALL  SELECT 273,'Andrew','Basil','URP','Associate Professor','01-07-783-8469','7678','M' FROM dual UNION ALL  SELECT 274,'Upton','Ulysses','MME','Professor','01-82-940-6769','6077','M' FROM dual UNION ALL  SELECT 275,'Russell','Jared','URP','Professor','01-38-414-6237','2440','M' FROM dual UNION ALL  SELECT 276,'Damon','Chaim','MME','Associate Professor','01-32-518-1030','6856','M' FROM dual UNION ALL  SELECT 277,'Owen','Christopher','URP','Lecturer','01-43-313-1477','6562','M' FROM dual UNION ALL  SELECT 278,'Wylie','Lewis','EEE','Professor','01-66-843-6517','1431','M' FROM dual UNION ALL  SELECT 279,'Brendan','Martin','EEE','Assistant Professor','01-18-561-2183','6770','M' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password,gender)  SELECT 280,'Macaulay','Edan','CSE','Professor','01-95-242-6811','1690','M' FROM dual UNION ALL  SELECT 281,'Cruz','Lev','CHE','Assistant Professor','01-30-660-9651','1712','M' FROM dual UNION ALL  SELECT 282,'Alvin','Tiger','CSE','Associate Professor','01-30-269-3345','3363','M' FROM dual UNION ALL  SELECT 283,'Logan','Arden','IPO','Associate Professor','01-63-853-8073','7088','M' FROM dual UNION ALL  SELECT 284,'Melvin','Hiram','IPO','Professor','01-58-169-0892','1288','M' FROM dual UNION ALL  SELECT 285,'Branden','Lester','CHE','Assistant Professor','01-86-342-9669','8430','M' FROM dual UNION ALL  SELECT 286,'Grady','Neville','CHE','Professor','01-43-215-4407','4141','M' FROM dual UNION ALL  SELECT 287,'Boris','Deacon','MME','Associate Professor','01-35-586-7433','7536','M' FROM dual UNION ALL  SELECT 288,'Magee','Jonah','CE','Associate Professor','01-73-740-3672','9020','M' FROM dual UNION ALL  SELECT 289,'Carlos','Austin','CHE','Associate Professor','01-08-434-3106','9337','M' FROM dual;
	INSERT INTO table_teacher (id,first_name,last_name,department_id,designation,contact_no,password,gender)  SELECT 290,'Tarik','George','URP','Professor','01-61-843-0515','8626','M' FROM dual UNION ALL  SELECT 291,'Kennan','Burton','ME','Associate Professor','01-59-698-8191','8527','M' FROM dual UNION ALL  SELECT 292,'Timothy','Christian','CE','Lecturer','01-93-567-8839','4220','M' FROM dual UNION ALL  SELECT 293,'Merrill','Ivan','MME','Assistant Professor','01-58-938-6873','3691','M' FROM dual UNION ALL  SELECT 294,'Adam','Lee','CSE','Assistant Professor','01-18-713-4756','9514','M' FROM dual UNION ALL  SELECT 295,'Stone','Kareem','CHE','Assistant Professor','01-77-722-2667','1322','M' FROM dual UNION ALL  SELECT 296,'Derek','Brett','CHE','Assistant Professor','01-99-779-0223','8238','M' FROM dual UNION ALL  SELECT 297,'Kaseem','Ali','URP','Lecturer','01-75-803-9992','2377','M' FROM dual UNION ALL  SELECT 298,'Zeus','Omar','CHE','Associate Professor','01-88-405-0192','6530','M' FROM dual UNION ALL  SELECT 299,'Keith','Kasper','CE','Assistant Professor','01-39-655-2104','6104','M' FROM dual;



-- ///////////////////////////////////


-- Team
INSERT INTO TABLE_TEAM VALUES('DAXAMITES', '2015' , 'FOOTBALL');
INSERT INTO TABLE_TEAM VALUES('DAXAMITES', '2016' , 'FOOTBALL');
INSERT INTO TABLE_TEAM VALUES('DAXAMITES', '2017' , 'FOOTBALL');

INSERT INTO TABLE_TEAM VALUES('KRYPTONITES', '2016' , 'CRICKET');
INSERT INTO TABLE_TEAM VALUES('MARTIANS_GREEN', '2016' , 'CRICKET');
INSERT INTO TABLE_TEAM VALUES('MARTIANS_RED', '2015' , 'CRICKET');

INSERT INTO TABLE_TEAM VALUES('EARTHLINGS', '2016' , 'FOOTBALL');
INSERT INTO TABLE_TEAM VALUES('SENTIANS', '2016' , 'FOOTBALL');
INSERT INTO TABLE_TEAM VALUES('RED_DEVILS', '2016' , 'FOOTBALL');
INSERT INTO TABLE_TEAM VALUES('RED_DEVILS', '2017' , 'FOOTBALL');

INSERT INTO TABLE_TEAM VALUES('BERNABUANS', '2015' , 'FOOTBALL');
INSERT INTO TABLE_TEAM VALUES('BERNABUANS', '2016' , 'FOOTBALL');
INSERT INTO TABLE_TEAM VALUES('BERNABUANS', '2017' , 'FOOTBALL');

INSERT INTO TABLE_TEAM VALUES('SINGLE_KATE', '2015' , 'CHESS');
INSERT INTO TABLE_TEAM VALUES('SINGLE_KAI', '2015' , 'CHESS');
INSERT INTO TABLE_TEAM VALUES('SINGLE_SARA', '2015' , 'CHESS');

INSERT INTO TABLE_TEAM VALUES('SINGLE_KATE', '2016' , 'CHESS');
INSERT INTO TABLE_TEAM VALUES('SINGLE_KAI', '2016' , 'CHESS');
INSERT INTO TABLE_TEAM VALUES('SINGLE_SARA', '2016' , 'CHESS');

INSERT INTO TABLE_TEAM VALUES('SINGLE_KATE', '2017' , 'CHESS');
INSERT INTO TABLE_TEAM VALUES('SINGLE_KAI', '2017' , 'CHESS');
INSERT INTO TABLE_TEAM VALUES('SINGLE_SARA', '2017' , 'CHESS');



-- ///////////////////////////////////


-- Staff
	INSERT INTO table_staff (id,staff_name,job_type,contact_no,staff_password)  SELECT 100,'Blaze Wolfe','Sweeper','1-608-132-1612','7403' FROM dual UNION ALL  SELECT 101,'Ria Finch','Chef','1-592-867-4957','3510' FROM dual UNION ALL  SELECT 102,'Shoshana Gamble','Sweeper','215-4650','6176' FROM dual UNION ALL  SELECT 103,'Hyatt Underwood','Cleaner','1-128-463-2218','3604' FROM dual UNION ALL  SELECT 104,'Nora Mcfadden','Chef','927-3906','2541' FROM dual UNION ALL  SELECT 105,'Gil Norton','Sweeper','971-0349','8493' FROM dual UNION ALL  SELECT 106,'Emma Hayes','Sweeper','979-4563','4567' FROM dual UNION ALL  SELECT 107,'Athena Fields','Sweeper','1-752-171-9880','8461' FROM dual UNION ALL  SELECT 108,'Kyla Erickson','Security Guard','1-208-334-1150','1554' FROM dual UNION ALL  SELECT 109,'Hayes Weeks','Security Guard','514-9754','4117' FROM dual;
	INSERT INTO table_staff (id,staff_name,job_type,contact_no,staff_password)  SELECT 110,'Hop Hahn','Cleaner','761-7697','3503' FROM dual UNION ALL  SELECT 111,'Anastasia Lott','Sweeper','677-0334','5700' FROM dual UNION ALL  SELECT 112,'Mufutau Kline','Security Guard','724-3929','7858' FROM dual UNION ALL  SELECT 113,'Howard Parsons','Sweeper','1-868-607-3889','2532' FROM dual UNION ALL  SELECT 114,'Marny Brewer','Security Guard','386-7360','2067' FROM dual UNION ALL  SELECT 115,'Heidi House','Security Guard','175-6956','6843' FROM dual UNION ALL  SELECT 116,'Felix Bird','Security Guard','923-3493','5273' FROM dual UNION ALL  SELECT 117,'Leonard Vargas','Chef','1-443-988-0972','9826' FROM dual UNION ALL  SELECT 118,'Emily Pickett','Cleaner','1-588-975-7483','5772' FROM dual UNION ALL  SELECT 119,'Adele Cote','Cleaner','1-802-213-4691','8599' FROM dual;
	INSERT INTO table_staff (id,staff_name,job_type,contact_no,staff_password)  SELECT 120,'Marvin Simmons','Cleaner','449-8359','4328' FROM dual UNION ALL  SELECT 121,'Burke Dale','Chef','816-7461','9517' FROM dual UNION ALL  SELECT 122,'Thane Riddle','Chef','839-4386','7693' FROM dual UNION ALL  SELECT 123,'Xavier Savage','Sweeper','252-4043','5235' FROM dual UNION ALL  SELECT 124,'Zephr Christensen','Cleaner','1-595-918-5196','5130' FROM dual UNION ALL  SELECT 125,'Carol Malone','Sweeper','1-639-259-4539','8969' FROM dual UNION ALL  SELECT 126,'Len Trujillo','Cleaner','111-7438','7250' FROM dual UNION ALL  SELECT 127,'Travis Cooke','Security Guard','627-5677','3500' FROM dual UNION ALL  SELECT 128,'Regan Patrick','Chef','1-503-508-0953','8904' FROM dual UNION ALL  SELECT 129,'Ella Mclean','Security Guard','952-3644','5953' FROM dual;
	INSERT INTO table_staff (id,staff_name,job_type,contact_no,staff_password)  SELECT 130,'Fredericka Contreras','Sweeper','1-769-522-4573','2179' FROM dual UNION ALL  SELECT 131,'Carly Scott','Sweeper','969-6606','9189' FROM dual UNION ALL  SELECT 132,'Austin Leach','Sweeper','1-387-195-6821','2802' FROM dual UNION ALL  SELECT 133,'Phelan Coleman','Cleaner','1-880-691-1100','8292' FROM dual UNION ALL  SELECT 134,'Shannon Schmidt','Security Guard','248-5083','9558' FROM dual UNION ALL  SELECT 135,'Jin Guerra','Sweeper','1-801-231-0368','7959' FROM dual UNION ALL  SELECT 136,'Phoebe Richardson','Chef','1-380-602-0697','3994' FROM dual UNION ALL  SELECT 137,'Ezekiel West','Chef','724-5993','6622' FROM dual UNION ALL  SELECT 138,'Dara Albert','Cleaner','1-763-984-3937','8172' FROM dual UNION ALL  SELECT 139,'Rafael Yang','Cleaner','1-682-702-9676','6020' FROM dual;
	INSERT INTO table_staff (id,staff_name,job_type,contact_no,staff_password)  SELECT 140,'Colt Mcclain','Cleaner','1-617-811-1041','4038' FROM dual UNION ALL  SELECT 141,'Tate Burton','Cleaner','114-9540','1169' FROM dual UNION ALL  SELECT 142,'Moana Puckett','Chef','1-193-678-5974','9079' FROM dual UNION ALL  SELECT 143,'Aimee Burton','Chef','1-208-396-7554','2355' FROM dual UNION ALL  SELECT 144,'Baker Price','Sweeper','574-6280','4028' FROM dual UNION ALL  SELECT 145,'Chava Pierce','Security Guard','1-978-568-3741','3979' FROM dual UNION ALL  SELECT 146,'Perry Price','Security Guard','1-811-984-7296','9505' FROM dual UNION ALL  SELECT 147,'Vladimir Perry','Security Guard','1-216-736-7207','2667' FROM dual UNION ALL  SELECT 148,'August Clark','Sweeper','980-0799','1539' FROM dual UNION ALL  SELECT 149,'Jane Phillips','Cleaner','1-532-281-2953','9354' FROM dual;
	INSERT INTO table_staff (id,staff_name,job_type,contact_no,staff_password)  SELECT 150,'Ralph Cantu','Cleaner','891-8581','7272' FROM dual UNION ALL  SELECT 151,'Nomlanga Abbott','Chef','1-873-495-3487','9410' FROM dual UNION ALL  SELECT 152,'Allegra Richmond','Cleaner','376-7071','3855' FROM dual UNION ALL  SELECT 153,'Brock Key','Chef','1-442-883-8816','7273' FROM dual UNION ALL  SELECT 154,'Drew Nieves','Sweeper','494-1426','2916' FROM dual UNION ALL  SELECT 155,'Natalie Conner','Sweeper','193-0490','6546' FROM dual UNION ALL  SELECT 156,'Tanisha Weeks','Sweeper','167-5508','3230' FROM dual UNION ALL  SELECT 157,'Damian Duran','Cleaner','1-125-360-0380','2455' FROM dual UNION ALL  SELECT 158,'Jolie Floyd','Security Guard','684-9948','4085' FROM dual UNION ALL  SELECT 159,'Teagan Whitehead','Cleaner','1-100-213-6649','7794' FROM dual;
	INSERT INTO table_staff (id,staff_name,job_type,contact_no,staff_password)  SELECT 160,'George Stout','Cleaner','1-509-762-5817','8751' FROM dual UNION ALL  SELECT 161,'Ayanna Tucker','Sweeper','351-4418','2719' FROM dual UNION ALL  SELECT 162,'Paul Sharp','Chef','1-773-530-6666','3086' FROM dual UNION ALL  SELECT 163,'Clio Nielsen','Sweeper','583-4707','5318' FROM dual UNION ALL  SELECT 164,'Ethan Bauer','Chef','1-328-484-9337','7748' FROM dual UNION ALL  SELECT 165,'Brenda Davis','Security Guard','1-224-542-8050','8340' FROM dual UNION ALL  SELECT 166,'Colby Chandler','Cleaner','1-559-681-4881','1411' FROM dual UNION ALL  SELECT 167,'Gage Velazquez','Cleaner','767-8088','3576' FROM dual UNION ALL  SELECT 168,'Yasir Fitzgerald','Security Guard','918-8095','6536' FROM dual UNION ALL  SELECT 169,'Hanae Welch','Chef','809-7495','7372' FROM dual;
	INSERT INTO table_staff (id,staff_name,job_type,contact_no,staff_password)  SELECT 170,'Shellie Sharpe','Security Guard','1-676-673-3591','3203' FROM dual UNION ALL  SELECT 171,'Olga Figueroa','Security Guard','892-7087','6307' FROM dual UNION ALL  SELECT 172,'Omar Park','Security Guard','536-3738','7060' FROM dual UNION ALL  SELECT 173,'Brent Gilmore','Security Guard','1-581-725-6665','2695' FROM dual UNION ALL  SELECT 174,'Lucy Zamora','Sweeper','1-820-910-2709','2188' FROM dual UNION ALL  SELECT 175,'Oliver Reid','Security Guard','1-437-443-6407','1977' FROM dual UNION ALL  SELECT 176,'Bree Gillespie','Security Guard','1-321-743-8192','4133' FROM dual UNION ALL  SELECT 177,'Amery Rodgers','Security Guard','664-3504','7560' FROM dual UNION ALL  SELECT 178,'Virginia Cummings','Cleaner','703-4231','6286' FROM dual UNION ALL  SELECT 179,'Germane Acosta','Security Guard','155-8925','2865' FROM dual;
	INSERT INTO table_staff (id,staff_name,job_type,contact_no,staff_password)  SELECT 180,'Magee Wilson','Sweeper','752-4509','4778' FROM dual UNION ALL  SELECT 181,'Cullen Blanchard','Security Guard','1-883-128-0984','8994' FROM dual UNION ALL  SELECT 182,'Tucker Bowen','Chef','1-466-132-5768','8888' FROM dual UNION ALL  SELECT 183,'Leslie Bradshaw','Chef','145-8129','9381' FROM dual UNION ALL  SELECT 184,'Burton Kane','Chef','1-738-362-1600','9505' FROM dual UNION ALL  SELECT 185,'Quinn Weber','Sweeper','164-6279','9568' FROM dual UNION ALL  SELECT 186,'Tarik Page','Cleaner','733-3140','8459' FROM dual UNION ALL  SELECT 187,'Tallulah Erickson','Cleaner','463-9488','3018' FROM dual UNION ALL  SELECT 188,'Hope Russell','Sweeper','465-8862','8969' FROM dual UNION ALL  SELECT 189,'Elvis Hendricks','Sweeper','209-9517','9118' FROM dual;
	INSERT INTO table_staff (id,staff_name,job_type,contact_no,staff_password)  SELECT 190,'Hadassah Sims','Chef','816-0563','3793' FROM dual UNION ALL  SELECT 191,'Ruby Blair','Sweeper','1-518-517-9346','6313' FROM dual UNION ALL  SELECT 192,'Illiana Hensley','Security Guard','204-9336','3842' FROM dual UNION ALL  SELECT 193,'Alika Strong','Cleaner','1-600-746-6946','2814' FROM dual UNION ALL  SELECT 194,'Oren Frederick','Cleaner','479-4201','6315' FROM dual UNION ALL  SELECT 195,'Gregory Sutton','Cleaner','720-6211','1615' FROM dual UNION ALL  SELECT 196,'Harding Garza','Sweeper','1-540-729-5535','3299' FROM dual UNION ALL  SELECT 197,'Shelby Sharp','Security Guard','1-975-161-1540','9513' FROM dual UNION ALL  SELECT 198,'Thaddeus Juarez','Sweeper','1-180-641-4349','2287' FROM dual UNION ALL  SELECT 199,'MacKenzie Buckley','Cleaner','1-523-119-7715','3856' FROM dual;

-- ///////////////////////////////////

-- Guest

	INSERT INTO table_GUEST VALUES (5820,'Larissa','Leigh','01-756-955-859','3810 Nec Road');
	INSERT INTO table_GUEST VALUES (5363,'Neve','Knox','01-368-611-230','P.O. Box 587, 6727 Pellentesque St.');
	INSERT INTO table_GUEST VALUES (7253,'Ivana','Denise','01-921-629-335','825-9263 Pellentesque Rd.');
	INSERT INTO table_GUEST VALUES (5715,'Jessica','Phillip','01-672-360-011','356-483 Cum St.');
	INSERT INTO table_GUEST VALUES (6905,'Luke','Castor','01-464-522-831','5678 Ut Avenue');
	INSERT INTO table_GUEST VALUES (5367,'Kameko','Cameran','01-848-222-973','591-8745 Imperdiet Rd.');
	INSERT INTO table_GUEST VALUES (6104,'Rashad','Karleigh','01-413-834-490','P.O. Box 827, 2771 Nonummy St.');
	INSERT INTO table_GUEST VALUES (6775,'Avye','Mufutau','01-362-720-213','241-137 Aenean Avenue');
	INSERT INTO table_GUEST VALUES (5459,'Maile','Alma','01-471-956-598','991-7952 Sem Street');
	INSERT INTO table_GUEST VALUES (5884,'Lucas','Amber','01-947-363-326','6619 Diam Av.');
	INSERT INTO table_GUEST VALUES (7704,'Hakeem','Wesley','01-278-693-124','Ap #948-1425 Fusce Av.');
	INSERT INTO table_GUEST VALUES (7883,'Cullen','Kenneth','01-146-267-017','P.O. Box 383, 8694 Commodo Rd.');
	INSERT INTO table_GUEST VALUES (5788,'Gregory','Shelly','01-232-986-771','Ap #308-3227 Mauris Street');
	INSERT INTO table_GUEST VALUES (7763,'Dean','Declan','01-885-462-933','860-9156 Lacus. Rd.');
	INSERT INTO table_GUEST VALUES (5471,'Barry','Madonna','01-688-116-259','5085 Ipsum Rd.');
	INSERT INTO table_GUEST VALUES (7307,'Jennifer','Reuben','01-714-446-376','P.O. Box 647, 5130 Ut St.');
	INSERT INTO table_GUEST VALUES (6626,'Victoria','Delilah','01-747-504-726','450-2340 Sem Ave');
	INSERT INTO table_GUEST VALUES (5701,'Merritt','Claire','01-199-442-660','130-9221 Nec Rd.');
	INSERT INTO table_GUEST VALUES (7657,'Haley','Kato','01-361-434-260','P.O. Box 745, 2363 Vitae Avenue');
	INSERT INTO table_GUEST VALUES (6518,'Marvin','Brynn','01-188-467-242','Ap #919-1828 Donec Street');
	INSERT INTO table_GUEST VALUES (6243,'Isabelle','Jordan','01-125-316-727','P.O. Box 715, 2474 Eu, Ave');
	INSERT INTO table_GUEST VALUES (6848,'Ashton','Herrod','01-953-179-148','3572 Eget, Road');
	INSERT INTO table_GUEST VALUES (5368,'Ila','Quincy','01-402-780-102','P.O. Box 122, 9530 Suspendisse Ave');
	INSERT INTO table_GUEST VALUES (6975,'Kelsey','Ronan','01-390-698-574','9097 Nec, Ave');
	INSERT INTO table_GUEST VALUES (6768,'Ora','Peter','01-860-448-464','387-7845 Tempus Rd.');
	INSERT INTO table_GUEST VALUES (5480,'Kyle','Meredith','01-722-642-239','2134 Iaculis, Rd.');
	INSERT INTO table_GUEST VALUES (6862,'Otto','George','01-357-318-803','Ap #700-2570 Nullam Avenue');
	INSERT INTO table_GUEST VALUES (7917,'Wilma','Hiram','01-547-205-736','816-9817 Mauris Rd.');

-- ///////////////////////////////////

	INSERT INTO TABLE_GUEST_PASS SELECT '5820','1111' FROM DUAL;
	INSERT INTO TABLE_GUEST_PASS SELECT '5363','1111' FROM DUAL;
	INSERT INTO TABLE_GUEST_PASS SELECT '7253','1111' FROM DUAL;

-- ///////////////////////////////////
-- )
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\









-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- Layer 2
-- (

-- Student
		-- CSE|EEE|CE|CHE|URP|IPO|MME|ME
		-- O+|O-|A-|A+|B-|AB-|AB+
		-- attached|resident
		-- 1|2|3|4
		-- Islam|Hinduism|Christianity|Buddhism|Sikhism|Judaism
		
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7000,'Jemima','Erickson','EEE','5888 Mauris Ave','A-',TO_DATE('06/01/1994', 'DD-MM-YYYY'),'attached','2','Christianity','F','1432','Dane Hickman','Lillith Frederick','01-22-325-9610' FROM dual UNION ALL  SELECT 7001,'Katelyn','Odom','EEE','4874 At St.','O+',TO_DATE('30/09/1998', 'DD-MM-YYYY'),'resident','4','Hinduism','F','9288','Abel Moody','Madison Harrington','01-81-715-2011' FROM dual UNION ALL 	 SELECT 7002,'Kai','Burke','URP','853-1444 Duis Avenue','A-',TO_DATE('15/08/1989', 'DD-MM-YYYY'),'resident','3','Islam','F','6803','Davis Haney','Debra Johnston','01-16-266-8369' FROM dual UNION ALL 	 SELECT 7003,'Emerald','Delgado','CSE','P.O. Box 522, 493 Imperdiet Street','O+',TO_DATE('30/12/1995', 'DD-MM-YYYY'),'attached','1','Buddhism','F','4680','Chancellor Harrison','Lael Mitchell','01-11-259-9464' FROM dual UNION ALL 	 SELECT 7004,'Nevada','Battle','IPO','Ap #557-7452 Morbi Avenue','AB-',TO_DATE('08/05/1991', 'DD-MM-YYYY'),'attached','2','Hinduism','F','7420','Tad Riggs','Hedy Charles','01-81-740-8278' FROM dual UNION ALL 	 SELECT 7005,'Sarah','Pitts','IPO','P.O. Box 133, 7386 Ipsum Rd.','AB+',TO_DATE('30/04/1989', 'DD-MM-YYYY'),'resident','4','Hinduism','F','5439','Quinn Mann','Leandra Combs','01-89-269-5699' FROM dual UNION ALL 	 SELECT 7006,'Nelle','Valentine','CSE','5094 Nulla St.','B-',TO_DATE('08/07/1998', 'DD-MM-YYYY'),'attached','3','Hinduism','F','5121','Emery Lucas','Cally Rios','01-16-850-6141' FROM dual UNION ALL 	 SELECT 7007,'Liberty','Sherman','MME','6630 Sem St.','AB+',TO_DATE('28/11/1994', 'DD-MM-YYYY'),'attached','4','Islam','F','5124','Fuller Ortega','Lacey Fulton','01-01-361-9140' FROM dual UNION ALL 	 SELECT 7008,'Madison','Stone','CSE','970-728 Id Rd.','A-',TO_DATE('29/06/1988', 'DD-MM-YYYY'),'attached','3','Buddhism','F','7027','Mufutau Nunez','Xaviera Jarvis','01-68-221-3210' FROM dual UNION ALL 	 SELECT 7009,'Jocelyn','Rowe','MME','P.O. Box 122, 6397 Litora Avenue','O-',TO_DATE('12/08/1992', 'DD-MM-YYYY'),'resident','4','Hinduism','F','8464','Gabriel Atkins','Roanna Morrison','01-50-731-5207' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7010,'Desiree','Gay','CE','P.O. Box 592, 4002 Pede Avenue','AB-',TO_DATE('19/01/1988', 'DD-MM-YYYY'),'resident','2','Hinduism','F','3214','Gareth Maldonado','Gillian Santana','01-26-621-9871' FROM dual UNION ALL  SELECT 7011,'Vielka','Kane','ME','757-5588 Tempor St.','A+',TO_DATE('16/11/1990', 'DD-MM-YYYY'),'attached','2','Buddhism','F','2184','Silas Strong','Sloane Drake','01-38-906-3041' FROM dual UNION ALL  SELECT 7012,'Phoebe','Duke','IPO','Ap #821-5455 In, Av.','AB+',TO_DATE('25/08/1992', 'DD-MM-YYYY'),'resident','3','Buddhism','F','8486','Eagan Mcbride','Marny Weeks','01-09-369-9730' FROM dual UNION ALL  SELECT 7013,'Whoopi','Stevenson','EEE','2500 Euismod Av.','O-',TO_DATE('13/01/1989', 'DD-MM-YYYY'),'resident','4','Sikhism','F','1986','Carter Puckett','Natalie Rice','01-31-560-6030' FROM dual UNION ALL  SELECT 7014,'Raya','Owens','CE','362-4014 Nec Avenue','AB+',TO_DATE('26/06/1992', 'DD-MM-YYYY'),'attached','1','Islam','F','4971','Hector Perez','Nita Wolf','01-34-276-2602' FROM dual UNION ALL  SELECT 7015,'Roary','Brock','URP','P.O. Box 445, 2889 Neque Avenue','A-',TO_DATE('28/05/1995', 'DD-MM-YYYY'),'resident','4','Sikhism','F','6621','Zahir Mullen','Mariam Bright','01-33-283-0808' FROM dual UNION ALL  SELECT 7016,'Vivian','Lewis','EEE','P.O. Box 848, 8576 Erat. Av.','AB+',TO_DATE('13/10/1988', 'DD-MM-YYYY'),'attached','3','Islam','F','5256','Cyrus Barr','Kiona Morrow','01-63-473-7528' FROM dual UNION ALL  SELECT 7017,'Barbara','Lindsay','MME','P.O. Box 474, 379 Lorem Road','A+',TO_DATE('20/10/1994', 'DD-MM-YYYY'),'attached','3','Christianity','F','9757','Victor Olson','Anastasia English','01-29-221-7318' FROM dual UNION ALL  SELECT 7018,'Alexis','Mcdowell','CHE','P.O. Box 480, 4857 Nulla St.','B-',TO_DATE('01/04/1995', 'DD-MM-YYYY'),'attached','3','Christianity','F','7702','Stephen Hancock','Vielka Bird','01-10-152-0671' FROM dual UNION ALL  SELECT 7019,'Genevieve','Fuentes','URP','5616 Mi Rd.','B-',TO_DATE('10/01/1996', 'DD-MM-YYYY'),'resident','4','Islam','F','3082','Brian Wagner','Neve Ashley','01-10-990-4809' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7020,'Roary','Owen','IPO','619-4241 Feugiat Ave','A+',TO_DATE('21/02/1988', 'DD-MM-YYYY'),'resident','4','Hinduism','F','6412','Aristotle Knight','Remedios Cortez','01-69-112-8707' FROM dual UNION ALL  SELECT 7021,'India','Vazquez','CSE','7823 Semper St.','A+',TO_DATE('17/05/1994', 'DD-MM-YYYY'),'resident','4','Sikhism','F','6121','Wallace Mcfadden','Ruth Mack','01-13-993-4648' FROM dual UNION ALL  SELECT 7022,'Kirestin','Russell','MME','Ap #389-5337 Mollis St.','B-',TO_DATE('19/03/1993', 'DD-MM-YYYY'),'resident','4','Christianity','F','7981','Noah Carter','Lacy Stafford','01-60-959-1722' FROM dual UNION ALL  SELECT 7023,'Sophia','Copeland','URP','2341 Nullam St.','AB+',TO_DATE('17/09/1989', 'DD-MM-YYYY'),'attached','2','Judaism','F','3674','Vincent Marshall','Brenna Anthony','01-14-286-4000' FROM dual UNION ALL  SELECT 7024,'Leila','Hughes','IPO','5248 Luctus Rd.','AB-',TO_DATE('10/08/1995', 'DD-MM-YYYY'),'attached','3','Judaism','F','3360','Kuame Arnold','Miriam Cooke','01-39-119-9022' FROM dual UNION ALL  SELECT 7025,'Ina','Stevenson','URP','P.O. Box 993, 6137 Consectetuer, St.','A-',TO_DATE('12/08/1995', 'DD-MM-YYYY'),'resident','2','Christianity','F','5127','Camden Alvarado','Kyla Henry','01-48-111-6024' FROM dual UNION ALL  SELECT 7026,'Evangeline','Moody','URP','P.O. Box 778, 4894 Interdum Av.','O+',TO_DATE('13/01/1997', 'DD-MM-YYYY'),'resident','1','Sikhism','F','6137','Baker Richardson','Melyssa Pace','01-77-817-9937' FROM dual UNION ALL  SELECT 7027,'Jayme','Watson','CSE','Ap #395-5100 Vestibulum Road','AB-',TO_DATE('07/09/1988', 'DD-MM-YYYY'),'attached','2','Judaism','F','9615','Paki Bernard','Paula Ramos','01-57-694-7106' FROM dual UNION ALL  SELECT 7028,'Ila','Mullen','IPO','528 Cursus Road','B-',TO_DATE('13/05/1988', 'DD-MM-YYYY'),'resident','2','Christianity','F','9935','Flynn Montoya','Leilani Briggs','01-56-865-2010' FROM dual UNION ALL  SELECT 7029,'Aspen','Frazier','CE','391 Sed Av.','AB+',TO_DATE('18/11/1993', 'DD-MM-YYYY'),'resident','4','Buddhism','F','4161','Edward Moreno','Fiona Kinney','01-94-218-2411' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7030,'Blythe','Valencia','IPO','969-3154 Eu Ave','O-',TO_DATE('16/07/1992', 'DD-MM-YYYY'),'resident','1','Hinduism','F','6714','Ivor Benjamin','Jessamine Hammond','01-04-261-8636' FROM dual UNION ALL  SELECT 7031,'Lavinia','Guthrie','IPO','P.O. Box 163, 9116 Ut Street','AB-',TO_DATE('07/10/1996', 'DD-MM-YYYY'),'attached','2','Christianity','F','1936','Lane Ware','Azalia Tyson','01-25-183-0666' FROM dual UNION ALL  SELECT 7032,'Winter','French','EEE','9008 Hendrerit. St.','A+',TO_DATE('23/07/1995', 'DD-MM-YYYY'),'resident','2','Buddhism','F','5485','Conan Gillespie','Beatrice Dixon','01-15-973-3963' FROM dual UNION ALL  SELECT 7033,'Hilary','Bowen','IPO','7603 Sem, Street','A+',TO_DATE('10/09/1989', 'DD-MM-YYYY'),'attached','4','Sikhism','F','3022','Mohammad Mckinney','Shoshana Boyer','01-32-626-6694' FROM dual UNION ALL  SELECT 7034,'Kay','Harper','URP','Ap #279-2729 Ac, Avenue','B-',TO_DATE('03/01/1989', 'DD-MM-YYYY'),'attached','4','Judaism','F','8894','Keefe Mayer','Carla Ryan','01-07-782-6435' FROM dual UNION ALL  SELECT 7035,'Macy','Owens','EEE','P.O. Box 726, 4809 Neque Rd.','B-',TO_DATE('25/12/1997', 'DD-MM-YYYY'),'attached','2','Judaism','F','6137','Grant Oneill','Quincy Valenzuela','01-47-782-6129' FROM dual UNION ALL  SELECT 7036,'Virginia','Alvarado','MME','Ap #580-3062 Nunc Rd.','O-',TO_DATE('10/01/1989', 'DD-MM-YYYY'),'resident','1','Buddhism','F','4823','Boris Galloway','Xyla Finch','01-92-238-4622' FROM dual UNION ALL  SELECT 7037,'Mari','Merritt','ME','2413 Vel Avenue','A+',TO_DATE('07/05/1991', 'DD-MM-YYYY'),'attached','4','Christianity','F','9380','Devin Marquez','Farrah Gilmore','01-51-100-9924' FROM dual UNION ALL  SELECT 7038,'Felicia','Bradshaw','IPO','Ap #297-8125 Eu Rd.','B-',TO_DATE('02/11/1990', 'DD-MM-YYYY'),'attached','2','Hinduism','F','5784','Yasir Mullen','Kai Burt','01-91-841-4557' FROM dual UNION ALL  SELECT 7039,'Holly','Lester','EEE','P.O. Box 269, 4543 Quisque Road','O-',TO_DATE('17/09/1988', 'DD-MM-YYYY'),'resident','4','Islam','F','1288','Orson Rose','Yuri William','01-61-607-1583' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7040,'Meredith','Battle','URP','365-9051 Nec, Rd.','AB+',TO_DATE('25/06/1990', 'DD-MM-YYYY'),'attached','2','Sikhism','F','9520','Emery Lopez','Clio Ortega','01-67-384-9318' FROM dual UNION ALL  SELECT 7041,'MacKensie','Harrington','CE','6615 Orci Rd.','O-',TO_DATE('17/06/1993', 'DD-MM-YYYY'),'attached','3','Hinduism','F','1695','Lucius Hickman','Ariel Hester','01-88-528-8949' FROM dual UNION ALL  SELECT 7042,'Gloria','Hahn','IPO','Ap #224-6754 Molestie Ave','A+',TO_DATE('16/05/1996', 'DD-MM-YYYY'),'attached','1','Christianity','F','1842','Kenneth Hart','Amela Nguyen','01-25-418-5166' FROM dual UNION ALL  SELECT 7043,'Savannah','Horton','IPO','527-9896 Cursus Road','AB-',TO_DATE('18/06/1996', 'DD-MM-YYYY'),'attached','1','Sikhism','F','7339','Raphael Moreno','Shea Petty','01-66-637-3797' FROM dual UNION ALL  SELECT 7044,'Camille','Walters','CSE','P.O. Box 316, 2353 Tellus. St.','AB+',TO_DATE('14/11/1994', 'DD-MM-YYYY'),'resident','3','Christianity','F','8768','Rahim Weaver','Sopoline Vincent','01-45-297-7601' FROM dual UNION ALL  SELECT 7045,'Germane','Hansen','EEE','Ap #244-728 Vulputate St.','A-',TO_DATE('02/11/1995', 'DD-MM-YYYY'),'resident','3','Hinduism','F','6258','Merrill Stuart','Kiona Walton','01-51-443-6896' FROM dual UNION ALL  SELECT 7046,'Ava','Ingram','ME','700-1429 Fringilla St.','B-',TO_DATE('15/05/1996', 'DD-MM-YYYY'),'resident','3','Buddhism','F','4973','Nigel Holcomb','Maisie Wall','01-17-746-6753' FROM dual UNION ALL  SELECT 7047,'Genevieve','Randolph','CE','221-7488 Suspendisse Rd.','O-',TO_DATE('25/04/1988', 'DD-MM-YYYY'),'attached','2','Hinduism','F','1557','Cairo Gentry','Phyllis Tillman','01-90-766-5202' FROM dual UNION ALL  SELECT 7048,'Roary','Bryant','ME','901-3832 Donec Rd.','AB-',TO_DATE('03/04/1991', 'DD-MM-YYYY'),'attached','2','Sikhism','F','4968','Bradley Harper','Denise Holder','01-19-834-8474' FROM dual UNION ALL  SELECT 7049,'Irene','Stevens','IPO','219-4214 Amet Road','A+',TO_DATE('13/02/1994', 'DD-MM-YYYY'),'attached','1','Christianity','F','8675','Chase Cummings','Genevieve Owen','01-59-775-8561' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7050,'Zorita','Hobbs','URP','843 Leo Ave','O+',TO_DATE('18/03/1993', 'DD-MM-YYYY'),'attached','3','Sikhism','F','8613','Quentin Valdez','Amber Hines','01-05-554-5282' FROM dual UNION ALL  SELECT 7051,'Beverly','Hickman','ME','P.O. Box 528, 9933 Ante, St.','O-',TO_DATE('04/01/1991', 'DD-MM-YYYY'),'resident','3','Sikhism','F','6729','Gareth Tyson','Cleo Kirby','01-44-925-9159' FROM dual UNION ALL  SELECT 7052,'India','Lang','CE','Ap #297-9427 Vitae, St.','AB-',TO_DATE('11/12/1995', 'DD-MM-YYYY'),'resident','2','Judaism','F','3797','Vernon Kelley','Shea Butler','01-62-672-0372' FROM dual UNION ALL  SELECT 7053,'Alexa','Whitley','IPO','379-683 Et Rd.','B-',TO_DATE('26/12/1990', 'DD-MM-YYYY'),'resident','1','Judaism','F','9447','Brennan Price','Keelie Padilla','01-79-400-2755' FROM dual UNION ALL  SELECT 7054,'India','Clemons','CSE','2402 Justo Av.','AB+',TO_DATE('27/11/1991', 'DD-MM-YYYY'),'attached','1','Buddhism','F','9661','Dante Doyle','Juliet Garrett','01-78-527-6870' FROM dual UNION ALL  SELECT 7055,'Ciara','Jordan','URP','340-7011 Malesuada Rd.','AB+',TO_DATE('14/01/1989', 'DD-MM-YYYY'),'attached','2','Sikhism','F','9900','Ciaran Gallegos','Gretchen Hayes','01-13-695-4494' FROM dual UNION ALL  SELECT 7056,'Christine','Walters','ME','Ap #157-3730 Ornare, Rd.','O-',TO_DATE('11/06/1997', 'DD-MM-YYYY'),'attached','1','Judaism','F','4551','Cruz Higgins','Tatyana Holcomb','01-76-506-8758' FROM dual UNION ALL  SELECT 7057,'Naida','Horton','CHE','Ap #277-1311 Eu Rd.','AB-',TO_DATE('03/11/1989', 'DD-MM-YYYY'),'resident','2','Hinduism','F','4975','Daniel Workman','Carol Castaneda','01-93-367-4673' FROM dual UNION ALL  SELECT 7058,'Callie','Adkins','CSE','870-109 Convallis Rd.','AB+',TO_DATE('28/03/1994', 'DD-MM-YYYY'),'resident','1','Sikhism','F','7960','Eaton Peck','Emma Jacobs','01-05-465-8410' FROM dual UNION ALL  SELECT 7059,'Basia','Boyd','CHE','2391 Fames Ave','AB-',TO_DATE('20/02/1990', 'DD-MM-YYYY'),'resident','1','Christianity','F','9719','Tiger Huffman','Madaline Chang','01-47-391-3270' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7060,'Catherine','Maldonado','CHE','P.O. Box 661, 4217 Non, Rd.','O+',TO_DATE('09/10/1991', 'DD-MM-YYYY'),'resident','4','Islam','F','3076','Nigel Wong','Hilary Snyder','01-52-856-2353' FROM dual UNION ALL  SELECT 7061,'Octavia','Paul','MME','3084 Etiam St.','B-',TO_DATE('23/08/1995', 'DD-MM-YYYY'),'attached','4','Judaism','F','3336','Tad Bishop','Claire Tucker','01-42-430-5707' FROM dual UNION ALL  SELECT 7062,'Cherokee','Alvarez','ME','P.O. Box 150, 4583 Sed Ave','B-',TO_DATE('22/01/1996', 'DD-MM-YYYY'),'resident','4','Buddhism','F','9843','Amos Skinner','India Maynard','01-16-831-6502' FROM dual UNION ALL  SELECT 7063,'Dominique','Knapp','ME','Ap #102-5892 Justo Rd.','O+',TO_DATE('11/01/1994', 'DD-MM-YYYY'),'attached','2','Sikhism','F','3381','Nigel Cantu','Adria Clay','01-54-665-1721' FROM dual UNION ALL  SELECT 7064,'Candice','Lawson','MME','893-8338 Scelerisque, St.','O+',TO_DATE('11/09/1991', 'DD-MM-YYYY'),'resident','4','Christianity','F','8686','Emerson Ray','Quin Sherman','01-43-821-7062' FROM dual UNION ALL  SELECT 7065,'Cecilia','Wilcox','EEE','651-3616 Id Street','AB+',TO_DATE('02/01/1996', 'DD-MM-YYYY'),'resident','4','Islam','F','6368','Keane Watts','Phoebe Andrews','01-86-778-5414' FROM dual UNION ALL  SELECT 7066,'Lacota','Warner','CSE','P.O. Box 853, 1594 Non St.','AB+',TO_DATE('08/06/1991', 'DD-MM-YYYY'),'resident','1','Hinduism','F','6835','Slade Ramirez','Chelsea Kinney','01-22-664-0687' FROM dual UNION ALL  SELECT 7067,'Eliana','Baird','CE','8513 Aliquet Road','AB-',TO_DATE('09/05/1996', 'DD-MM-YYYY'),'resident','2','Judaism','F','1527','Raymond Flynn','Zenaida Washington','01-68-425-6558' FROM dual UNION ALL  SELECT 7068,'Ivory','Kennedy','MME','Ap #785-9737 Dapibus Ave','B-',TO_DATE('01/09/1998', 'DD-MM-YYYY'),'resident','2','Judaism','F','1898','Kato Ochoa','Jeanette Washington','01-58-718-4233' FROM dual UNION ALL  SELECT 7069,'Lee','Casey','CHE','Ap #489-6202 Nec Rd.','A+',TO_DATE('08/06/1994', 'DD-MM-YYYY'),'resident','3','Sikhism','F','9395','Ulysses Robbins','Cara Sanchez','01-90-140-9109' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7070,'Iliana','Zamora','EEE','Ap #886-5330 Pretium Street','O+',TO_DATE('05/01/1994', 'DD-MM-YYYY'),'resident','2','Christianity','F','1840','Colorado Lane','Avye Robles','01-52-458-9993' FROM dual UNION ALL  SELECT 7071,'Cassidy','Buchanan','CE','P.O. Box 775, 9726 Et Rd.','AB-',TO_DATE('27/09/1991', 'DD-MM-YYYY'),'attached','3','Hinduism','F','1934','Tarik Petersen','Clare Campbell','01-68-820-6974' FROM dual UNION ALL  SELECT 7072,'Wyoming','Burns','URP','3956 Magna. Road','A-',TO_DATE('16/06/1989', 'DD-MM-YYYY'),'resident','2','Islam','F','2508','Simon Moody','Nora Hahn','01-47-953-9064' FROM dual UNION ALL  SELECT 7073,'Alisa','Ortiz','CHE','P.O. Box 587, 9659 Duis Ave','O-',TO_DATE('21/04/1990', 'DD-MM-YYYY'),'resident','2','Judaism','F','3153','Ciaran Browning','Hadassah Washington','01-58-721-7513' FROM dual UNION ALL  SELECT 7074,'Sydney','Langley','IPO','2309 Integer Ave','A-',TO_DATE('11/12/1993', 'DD-MM-YYYY'),'attached','4','Hinduism','F','5345','Plato Decker','Stephanie Crawford','01-09-485-9576' FROM dual UNION ALL  SELECT 7075,'Yetta','Giles','IPO','334-118 Nec Rd.','A+',TO_DATE('28/12/1987', 'DD-MM-YYYY'),'attached','4','Islam','F','2558','Cole Dudley','Sybil Bennett','01-44-448-2165' FROM dual UNION ALL  SELECT 7076,'Eden','Ware','IPO','441-5966 Lorem, Av.','AB-',TO_DATE('06/08/1993', 'DD-MM-YYYY'),'resident','2','Judaism','F','9760','Zachary Bennett','Adara Robinson','01-74-183-7391' FROM dual UNION ALL  SELECT 7077,'Yael','Baker','MME','507-822 Sit St.','O+',TO_DATE('09/07/1991', 'DD-MM-YYYY'),'resident','2','Islam','F','6690','Josiah Tanner','Kiona Franco','01-76-752-0268' FROM dual UNION ALL  SELECT 7078,'Quail','Shannon','MME','Ap #174-6267 Auctor. Rd.','B-',TO_DATE('13/08/1995', 'DD-MM-YYYY'),'attached','1','Islam','F','4104','Rashad Phelps','Kaitlin Sears','01-19-592-1600' FROM dual UNION ALL  SELECT 7079,'Angela','Mitchell','URP','354-327 Arcu. St.','A-',TO_DATE('19/09/1995', 'DD-MM-YYYY'),'resident','4','Sikhism','F','4495','Ronan Haney','Liberty Hensley','01-70-287-0151' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7080,'Piper','Hopper','MME','5122 Aliquam Road','O+',TO_DATE('29/07/1993', 'DD-MM-YYYY'),'attached','4','Christianity','F','8544','Logan Mclaughlin','Cheyenne Davenport','01-52-391-9400' FROM dual UNION ALL  SELECT 7081,'Cara','Valencia','CE','P.O. Box 219, 3376 Tempor Av.','A+',TO_DATE('30/12/1995', 'DD-MM-YYYY'),'resident','1','Sikhism','F','7329','Emerson Gallegos','Cassandra Schultz','01-61-758-0679' FROM dual UNION ALL  SELECT 7082,'Tasha','Stout','ME','4745 Diam Ave','A-',TO_DATE('26/04/1988', 'DD-MM-YYYY'),'resident','3','Buddhism','F','6722','Nigel Kidd','Hollee Bradford','01-42-210-5051' FROM dual UNION ALL  SELECT 7083,'Kirestin','Stark','URP','P.O. Box 620, 9204 Sed Rd.','O-',TO_DATE('26/09/1997', 'DD-MM-YYYY'),'attached','1','Judaism','F','1420','Cedric Vasquez','Kelsie Fernandez','01-22-223-6746' FROM dual UNION ALL  SELECT 7084,'May','Wells','ME','P.O. Box 292, 9594 A, Street','AB-',TO_DATE('25/02/1998', 'DD-MM-YYYY'),'attached','3','Islam','F','5891','Nasim Pratt','Jorden Carr','01-16-143-0568' FROM dual UNION ALL  SELECT 7085,'Chantale','Kent','CE','6850 Dapibus Ave','AB+',TO_DATE('18/09/1991', 'DD-MM-YYYY'),'attached','3','Hinduism','F','5912','Amir Bender','Mallory Cross','01-01-396-8920' FROM dual UNION ALL  SELECT 7086,'Tatiana','Gilmore','CHE','539-8265 Massa. St.','O-',TO_DATE('21/12/1990', 'DD-MM-YYYY'),'resident','1','Sikhism','F','1234','Kenneth Daniels','Camilla Mann','01-06-549-2323' FROM dual UNION ALL  SELECT 7087,'Aretha','Cummings','IPO','P.O. Box 358, 5593 Ut, Ave','A-',TO_DATE('02/10/1998', 'DD-MM-YYYY'),'attached','2','Buddhism','F','1714','Ferris Mcknight','Hedwig Molina','01-82-136-3331' FROM dual UNION ALL  SELECT 7088,'Kirsten','Compton','CSE','548-7148 Donec St.','O+',TO_DATE('02/04/1996', 'DD-MM-YYYY'),'attached','1','Christianity','F','7390','Coby Hamilton','Mercedes Hanson','01-07-478-8830' FROM dual UNION ALL  SELECT 7089,'Moana','Miles','CE','5087 Curae; St.','AB-',TO_DATE('16/06/1997', 'DD-MM-YYYY'),'resident','2','Hinduism','F','9283','Kareem Mendoza','Tamara Garrett','01-22-743-8956' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7090,'Galena','Mckenzie','ME','P.O. Box 788, 5550 Consectetuer Street','A+',TO_DATE('27/05/1997', 'DD-MM-YYYY'),'resident','3','Judaism','F','7401','Justin Drake','Athena Graves','01-51-245-4665' FROM dual UNION ALL  SELECT 7091,'Ulla','Murphy','URP','Ap #525-3070 Lacus. Road','AB+',TO_DATE('15/05/1991', 'DD-MM-YYYY'),'resident','1','Sikhism','F','6301','Brady Coffey','Miranda Todd','01-99-226-8595' FROM dual UNION ALL  SELECT 7092,'Nomlanga','Bolton','ME','Ap #489-2400 Turpis. St.','B-',TO_DATE('12/08/1990', 'DD-MM-YYYY'),'resident','3','Judaism','F','1668','Gage Duran','Gwendolyn Moon','01-70-909-9251' FROM dual UNION ALL  SELECT 7093,'Karyn','Mcleod','EEE','Ap #416-6973 Cursus, Avenue','B-',TO_DATE('21/04/1988', 'DD-MM-YYYY'),'resident','2','Judaism','F','2962','Stewart Nunez','Sloane Nieves','01-82-590-5519' FROM dual UNION ALL  SELECT 7094,'Quail','Velez','ME','Ap #923-1489 Odio Rd.','AB+',TO_DATE('21/05/1997', 'DD-MM-YYYY'),'attached','2','Christianity','F','5460','Benjamin Cash','Darryl Obrien','01-61-994-1764' FROM dual UNION ALL  SELECT 7095,'Ayanna','Manning','EEE','P.O. Box 228, 5211 Mi Avenue','B-',TO_DATE('30/01/1995', 'DD-MM-YYYY'),'attached','4','Buddhism','F','8824','Xander House','Latifah Mccray','01-15-602-2654' FROM dual UNION ALL  SELECT 7096,'Abra','Horton','URP','Ap #290-8382 Et Ave','A+',TO_DATE('21/04/1996', 'DD-MM-YYYY'),'resident','4','Buddhism','F','6429','Justin Joyner','Yvette Beck','01-80-201-5033' FROM dual UNION ALL  SELECT 7097,'Yvonne','Soto','IPO','2244 At, Avenue','A-',TO_DATE('10/03/1988', 'DD-MM-YYYY'),'resident','4','Judaism','F','8179','Dillon Hamilton','Blythe Johnson','01-61-539-4497' FROM dual UNION ALL  SELECT 7098,'Signe','Haney','CSE','6244 Ac Avenue','AB+',TO_DATE('02/01/1990', 'DD-MM-YYYY'),'resident','3','Hinduism','F','3222','Barry Briggs','Marny Ware','01-52-709-4743' FROM dual UNION ALL  SELECT 7099,'Adria','Serrano','IPO','P.O. Box 722, 7601 Molestie Av.','A-',TO_DATE('03/05/1997', 'DD-MM-YYYY'),'attached','2','Islam','F','7305','Allen Turner','Alyssa Buckley','01-19-285-9230' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7100,'Theodore','Martin','IPO','3898 Aliquet. Avenue','B-',TO_DATE('25/11/1995', 'DD-MM-YYYY'),'attached','1','Christianity','M','5231','Cole Howell','Madeson Henson','01-78-489-0428' FROM dual UNION ALL  SELECT 7101,'Barry','Holloway','ME','298 Feugiat Rd.','A+',TO_DATE('07/12/1996', 'DD-MM-YYYY'),'attached','1','Islam','M','1510','Ross Beard','Meghan Bartlett','01-56-397-0644' FROM dual UNION ALL  SELECT 7102,'Gray','Rodriquez','CHE','8339 Vivamus Avenue','B-',TO_DATE('21/08/1998', 'DD-MM-YYYY'),'attached','2','Buddhism','M','9343','Zachery Sims','Catherine Sharpe','01-71-570-7310' FROM dual UNION ALL  SELECT 7103,'Grady','Harper','IPO','738-5913 Porttitor Rd.','A+',TO_DATE('19/12/1991', 'DD-MM-YYYY'),'resident','2','Judaism','M','4579','Addison Shields','Roary Merritt','01-30-497-6785' FROM dual UNION ALL  SELECT 7104,'Reed','Humphrey','EEE','Ap #838-237 Sociosqu Road','AB+',TO_DATE('08/04/1998', 'DD-MM-YYYY'),'resident','2','Buddhism','M','1797','Kevin Frost','Rebekah Gregory','01-38-938-9134' FROM dual UNION ALL  SELECT 7105,'Guy','Sutton','CSE','Ap #165-4855 Egestas. Avenue','AB+',TO_DATE('30/12/1994', 'DD-MM-YYYY'),'attached','1','Islam','M','3061','Aaron Sanchez','Martena Barrett','01-79-640-0562' FROM dual UNION ALL  SELECT 7106,'Jerome','Pena','EEE','1353 At, Street','O-',TO_DATE('31/10/1991', 'DD-MM-YYYY'),'attached','2','Judaism','M','9735','Louis Walls','Amaya Dyer','01-22-973-5989' FROM dual UNION ALL  SELECT 7107,'Chancellor','Lindsay','IPO','776-1285 Mauris, Avenue','O+',TO_DATE('02/08/1989', 'DD-MM-YYYY'),'resident','2','Buddhism','M','1907','Forrest Espinoza','Candace Osborn','01-25-938-5152' FROM dual UNION ALL  SELECT 7108,'Lucian','Duncan','MME','P.O. Box 933, 5564 Pede. Street','A+',TO_DATE('29/01/1997', 'DD-MM-YYYY'),'resident','2','Judaism','M','9531','Cadman Dale','Ebony Robertson','01-77-130-6065' FROM dual UNION ALL  SELECT 7109,'Aidan','Mcdonald','CSE','7633 In, Street','AB-',TO_DATE('11/07/1993', 'DD-MM-YYYY'),'resident','2','Christianity','M','5667','Bernard Forbes','Lesley Joyce','01-68-281-0138' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7110,'Clayton','Wade','EEE','7475 Gravida. Ave','AB-',TO_DATE('26/02/1992', 'DD-MM-YYYY'),'attached','2','Christianity','M','8466','Jamal Mendez','Rhona Padilla','01-96-491-8941' FROM dual UNION ALL  SELECT 7111,'Lars','Mccray','ME','Ap #459-4868 Sociis Rd.','A+',TO_DATE('01/04/1995', 'DD-MM-YYYY'),'attached','1','Hinduism','M','8682','Emmanuel Bryant','Jenna Herring','01-40-544-8709' FROM dual UNION ALL  SELECT 7112,'Dieter','Brown','URP','P.O. Box 622, 8415 Aenean Street','O-',TO_DATE('18/03/1996', 'DD-MM-YYYY'),'attached','2','Hinduism','M','7591','Ivor Reyes','Maia Hendricks','01-10-809-5586' FROM dual UNION ALL  SELECT 7113,'Lyle','Carney','IPO','702-4897 Sed Avenue','O-',TO_DATE('13/11/1996', 'DD-MM-YYYY'),'resident','1','Islam','M','2692','Tarik Dunn','Christine Maynard','01-16-789-5733' FROM dual UNION ALL  SELECT 7114,'Plato','Wilkerson','MME','P.O. Box 914, 1903 Posuere, Road','B-',TO_DATE('25/11/1992', 'DD-MM-YYYY'),'resident','2','Christianity','M','6321','Harrison Sheppard','Abra Chavez','01-42-648-5601' FROM dual UNION ALL  SELECT 7115,'Francis','Bowers','IPO','915-5306 Sit Street','O-',TO_DATE('07/10/1998', 'DD-MM-YYYY'),'attached','2','Christianity','M','2497','Tiger Steele','Katelyn White','01-02-417-1038' FROM dual UNION ALL  SELECT 7116,'Kenyon','Buckley','CE','3435 Nascetur Avenue','A+',TO_DATE('16/10/1989', 'DD-MM-YYYY'),'attached','1','Hinduism','M','3014','Timon Bradley','Rhea Henderson','01-16-817-1416' FROM dual UNION ALL  SELECT 7117,'Bruno','Wiley','CSE','503-1416 Sed Rd.','A+',TO_DATE('22/03/1994', 'DD-MM-YYYY'),'resident','1','Buddhism','M','1322','Hector Mccoy','Nichole Bowman','01-60-640-9971' FROM dual UNION ALL  SELECT 7118,'Nolan','Morrow','IPO','P.O. Box 206, 4162 Adipiscing Street','A+',TO_DATE('13/11/1987', 'DD-MM-YYYY'),'resident','2','Judaism','M','6467','Ali Vang','Quin Craig','01-43-531-6503' FROM dual UNION ALL  SELECT 7119,'Jack','Baldwin','IPO','830-2898 Placerat, Ave','A-',TO_DATE('21/05/1997', 'DD-MM-YYYY'),'attached','2','Judaism','M','2188','Thane Lara','Jaime Oconnor','01-41-819-0039' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7120,'Bradley','Stewart','IPO','577-9643 Sagittis. St.','O+',TO_DATE('31/08/1990', 'DD-MM-YYYY'),'attached','2','Buddhism','M','1472','Oren Burnett','Inez Ballard','01-00-663-3604' FROM dual UNION ALL  SELECT 7121,'Vaughan','Woods','CSE','754-8204 Sem. Street','A+',TO_DATE('19/08/1988', 'DD-MM-YYYY'),'resident','2','Judaism','M','5404','Kennedy Kelly','Galena Burks','01-95-550-0756' FROM dual UNION ALL  SELECT 7122,'Lester','Mcconnell','EEE','Ap #812-4127 Ligula. Rd.','O+',TO_DATE('09/02/1994', 'DD-MM-YYYY'),'resident','1','Judaism','M','4804','Odysseus Pena','Carly Knox','01-94-547-2175' FROM dual UNION ALL  SELECT 7123,'Dexter','Hurst','CHE','P.O. Box 929, 1482 Varius. Rd.','AB-',TO_DATE('28/01/1995', 'DD-MM-YYYY'),'resident','2','Islam','M','2756','Wing Puckett','Nadine Moon','01-51-978-6691' FROM dual UNION ALL  SELECT 7124,'Quentin','Harper','CSE','P.O. Box 573, 2546 Interdum. Road','O+',TO_DATE('15/05/1995', 'DD-MM-YYYY'),'resident','2','Christianity','M','9584','Howard Olsen','Charissa Lee','01-46-757-5753' FROM dual UNION ALL  SELECT 7125,'Alec','Alvarez','CE','7859 Tempor Rd.','A-',TO_DATE('03/01/1997', 'DD-MM-YYYY'),'resident','2','Buddhism','M','8639','Callum Rich','Germane Ramirez','01-70-503-5773' FROM dual UNION ALL  SELECT 7126,'Aaron','Holman','MME','Ap #781-1477 Convallis St.','B-',TO_DATE('11/08/1997', 'DD-MM-YYYY'),'resident','1','Hinduism','M','2894','Howard Hutchinson','Sheila Park','01-76-850-7805' FROM dual UNION ALL  SELECT 7127,'Mufutau','Ratliff','URP','136-4489 Montes, St.','AB+',TO_DATE('22/09/1993', 'DD-MM-YYYY'),'resident','2','Buddhism','M','3949','Jelani Winters','Unity Leblanc','01-08-532-3995' FROM dual UNION ALL  SELECT 7128,'Chaney','Mcdowell','URP','Ap #852-1845 Ipsum Av.','AB-',TO_DATE('27/02/1997', 'DD-MM-YYYY'),'attached','2','Judaism','M','1686','Preston Compton','Xantha Adams','01-88-635-5716' FROM dual UNION ALL  SELECT 7129,'Quamar','Houston','URP','Ap #346-2696 Et, Rd.','AB+',TO_DATE('06/07/1997', 'DD-MM-YYYY'),'resident','1','Judaism','M','9960','Coby Obrien','Reagan Reese','01-38-313-0640' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7130,'Yoshio','Hunt','MME','9541 Lorem, Road','B-',TO_DATE('25/01/1997', 'DD-MM-YYYY'),'attached','2','Islam','M','1383','Bernard Vang','Althea Bauer','01-39-261-0943' FROM dual UNION ALL  SELECT 7131,'Christian','Hester','MME','P.O. Box 925, 8624 Integer Road','AB-',TO_DATE('23/03/1994', 'DD-MM-YYYY'),'attached','2','Sikhism','M','7080','Marvin Boone','Madeson Hutchinson','01-14-625-0841' FROM dual UNION ALL  SELECT 7132,'Aristotle','Hunt','CSE','722-1324 Praesent St.','O+',TO_DATE('27/10/1991', 'DD-MM-YYYY'),'resident','1','Islam','M','5858','Hedley Grimes','Daria Reed','01-55-167-8473' FROM dual UNION ALL  SELECT 7133,'Laith','Daugherty','ME','710-9169 Sit Rd.','AB-',TO_DATE('02/02/1990', 'DD-MM-YYYY'),'attached','1','Islam','M','9664','Levi Davis','Aretha Pearson','01-99-966-5711' FROM dual UNION ALL  SELECT 7134,'Kaseem','Mcguire','CE','4671 Phasellus Road','AB-',TO_DATE('22/09/1997', 'DD-MM-YYYY'),'attached','2','Christianity','M','2330','Blaze Rowe','Veronica Gordon','01-89-165-7728' FROM dual UNION ALL  SELECT 7135,'Macaulay','Lewis','ME','Ap #841-2387 Vitae Avenue','A-',TO_DATE('19/09/1996', 'DD-MM-YYYY'),'attached','1','Sikhism','M','2070','Acton Slater','Medge Bradley','01-59-200-0590' FROM dual UNION ALL  SELECT 7136,'Akeem','Logan','URP','4468 Fringilla Rd.','O-',TO_DATE('02/02/1989', 'DD-MM-YYYY'),'resident','1','Hinduism','M','7297','Brandon Moses','Sacha Mcdaniel','01-62-685-4513' FROM dual UNION ALL  SELECT 7137,'Jackson','Higgins','ME','P.O. Box 884, 7998 At Street','AB+',TO_DATE('11/12/1993', 'DD-MM-YYYY'),'attached','2','Judaism','M','1463','Roth Hendrix','Roary Holder','01-16-882-6810' FROM dual UNION ALL  SELECT 7138,'Josiah','Gay','IPO','8188 Accumsan St.','B-',TO_DATE('29/07/1996', 'DD-MM-YYYY'),'resident','1','Sikhism','M','9377','Marshall Mosley','Amethyst Bryant','01-27-687-2752' FROM dual UNION ALL  SELECT 7139,'Lester','Mcclure','MME','690 Fusce Street','AB-',TO_DATE('01/02/1991', 'DD-MM-YYYY'),'attached','1','Hinduism','M','2864','Stuart Roberson','Savannah Fox','01-17-910-7961' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7140,'Timothy','Wilkins','CE','Ap #690-1157 Lacinia Rd.','AB-',TO_DATE('12/01/1998', 'DD-MM-YYYY'),'resident','1','Christianity','M','7700','Driscoll Logan','Ignacia Spence','01-11-466-4967' FROM dual UNION ALL  SELECT 7141,'Timothy','Justice','ME','8384 Eget Ave','AB-',TO_DATE('07/04/1988', 'DD-MM-YYYY'),'attached','2','Islam','M','8032','Joshua Beach','Xena Sawyer','01-10-398-9279' FROM dual UNION ALL  SELECT 7142,'Wayne','Page','EEE','1393 Odio, Rd.','AB-',TO_DATE('23/10/1988', 'DD-MM-YYYY'),'attached','1','Christianity','M','9427','Avram Callahan','Rylee Allison','01-26-547-2780' FROM dual UNION ALL  SELECT 7143,'Plato','Wolf','MME','Ap #737-8666 Mauris. Ave','O-',TO_DATE('28/03/1994', 'DD-MM-YYYY'),'resident','2','Christianity','M','2203','Noble Copeland','McKenzie Mills','01-35-389-6089' FROM dual UNION ALL  SELECT 7144,'Tyler','Frye','MME','2146 Nec Road','AB-',TO_DATE('29/05/1996', 'DD-MM-YYYY'),'resident','2','Judaism','M','8532','Jared Ware','Wanda Carroll','01-82-405-7975' FROM dual UNION ALL  SELECT 7145,'Brandon','Reid','CSE','P.O. Box 477, 7209 Mollis Avenue','A-',TO_DATE('15/10/1994', 'DD-MM-YYYY'),'resident','2','Sikhism','M','5650','Jonah Sutton','Glenna Briggs','01-59-531-9994' FROM dual UNION ALL  SELECT 7146,'Baxter','Lloyd','CSE','308-8268 Facilisis, Av.','O-',TO_DATE('30/09/1996', 'DD-MM-YYYY'),'resident','2','Sikhism','M','9644','Brandon Ray','Constance Washington','01-59-539-9179' FROM dual UNION ALL  SELECT 7147,'Curran','Velasquez','ME','Ap #687-7007 Justo. St.','B-',TO_DATE('12/05/1995', 'DD-MM-YYYY'),'resident','1','Judaism','M','1706','Fuller Patrick','Sopoline Meyer','01-75-447-8129' FROM dual UNION ALL  SELECT 7148,'Blake','Lang','CSE','P.O. Box 492, 6185 Duis St.','A+',TO_DATE('25/06/1989', 'DD-MM-YYYY'),'resident','2','Islam','M','5805','Zahir Edwards','Paloma Shannon','01-06-811-1918' FROM dual UNION ALL  SELECT 7149,'Boris','Simon','CE','616 Enim, Rd.','O+',TO_DATE('27/10/1991', 'DD-MM-YYYY'),'attached','2','Judaism','M','4392','Driscoll Hicks','Leah Watts','01-58-918-5768' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7150,'Burke','Bennett','MME','Ap #528-3345 Etiam St.','O-',TO_DATE('09/12/1997', 'DD-MM-YYYY'),'attached','2','Judaism','M','6839','Xavier Carter','Ingrid Bates','01-88-331-0238' FROM dual UNION ALL  SELECT 7151,'Rudyard','Mosley','URP','8453 Quis Street','B-',TO_DATE('02/08/1989', 'DD-MM-YYYY'),'resident','1','Sikhism','M','3262','Gannon Horton','Libby Oneil','01-00-947-3690' FROM dual UNION ALL  SELECT 7152,'Tanek','Maddox','MME','P.O. Box 321, 4306 Ac Rd.','A+',TO_DATE('02/08/1996', 'DD-MM-YYYY'),'resident','1','Buddhism','M','9035','Hiram Santos','Lisandra Gibson','01-15-855-8417' FROM dual UNION ALL  SELECT 7153,'Merritt','Delacruz','CHE','Ap #698-9903 Nec Street','A+',TO_DATE('22/01/1994', 'DD-MM-YYYY'),'resident','1','Islam','M','5342','Benjamin Glover','Aimee Gallagher','01-33-475-5507' FROM dual UNION ALL  SELECT 7154,'Armand','Kirby','CE','Ap #339-7170 Praesent Rd.','A-',TO_DATE('23/07/1990', 'DD-MM-YYYY'),'resident','1','Judaism','M','1656','Hasad Hanson','Deborah Rollins','01-22-751-5908' FROM dual UNION ALL  SELECT 7155,'Brady','Hubbard','URP','722-9903 Lobortis Rd.','A-',TO_DATE('19/08/1993', 'DD-MM-YYYY'),'attached','2','Sikhism','M','8046','Keane Clayton','Amanda Parker','01-28-263-5629' FROM dual UNION ALL  SELECT 7156,'Blake','Webb','MME','379-3587 Proin Road','A-',TO_DATE('27/11/1992', 'DD-MM-YYYY'),'resident','2','Islam','M','4593','Griffin Hendricks','Chava Finley','01-96-408-5748' FROM dual UNION ALL  SELECT 7157,'Lamar','Schroeder','MME','Ap #843-9423 Eu Street','A+',TO_DATE('09/05/1988', 'DD-MM-YYYY'),'attached','2','Hinduism','M','3784','Dylan Wise','Kelsey Long','01-06-385-8172' FROM dual UNION ALL  SELECT 7158,'Burke','Torres','CSE','P.O. Box 750, 3789 Tincidunt Rd.','A-',TO_DATE('02/06/1994', 'DD-MM-YYYY'),'resident','2','Christianity','M','5776','Wing Hurley','Moana Mathews','01-18-538-6547' FROM dual UNION ALL  SELECT 7159,'Driscoll','Walsh','ME','Ap #689-4024 Facilisis Avenue','AB+',TO_DATE('09/07/1996', 'DD-MM-YYYY'),'resident','2','Islam','M','7174','Harrison Riggs','Dawn Marks','01-79-700-9461' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7160,'Magee','Berg','ME','831-1667 Malesuada Ave','AB+',TO_DATE('25/01/1996', 'DD-MM-YYYY'),'resident','1','Hinduism','M','2360','Nissim Ratliff','Brenda Sears','01-47-725-2704' FROM dual UNION ALL  SELECT 7161,'Clark','Bush','CSE','354-9958 Non, St.','AB-',TO_DATE('19/01/1991', 'DD-MM-YYYY'),'attached','2','Christianity','M','3826','Bernard Vargas','Michelle Ramirez','01-83-929-7253' FROM dual UNION ALL  SELECT 7162,'Fletcher','Hatfield','CHE','349-1913 At, Ave','A-',TO_DATE('11/08/1994', 'DD-MM-YYYY'),'resident','1','Christianity','M','2934','Rahim Frazier','Claudia Cortez','01-37-732-8008' FROM dual UNION ALL  SELECT 7163,'Kareem','Mosley','MME','532-6665 Commodo Rd.','O+',TO_DATE('05/08/1995', 'DD-MM-YYYY'),'attached','2','Christianity','M','5208','Ezra Whitaker','Quemby Stanton','01-29-740-5829' FROM dual UNION ALL  SELECT 7164,'George','Vinson','CHE','399-1616 Duis St.','B-',TO_DATE('05/04/1994', 'DD-MM-YYYY'),'attached','1','Sikhism','M','8959','Carl Stevens','Wynter Hernandez','01-57-980-7865' FROM dual UNION ALL  SELECT 7165,'Nero','Bryant','ME','727-2713 Montes, Ave','O-',TO_DATE('01/09/1989', 'DD-MM-YYYY'),'resident','2','Islam','M','9575','Robert Cooley','Macey Sims','01-35-843-8486' FROM dual UNION ALL  SELECT 7166,'Neville','Strickland','MME','Ap #577-752 Urna, Avenue','A+',TO_DATE('09/08/1992', 'DD-MM-YYYY'),'resident','2','Buddhism','M','4581','Duncan Hendricks','Penelope Carson','01-17-415-7730' FROM dual UNION ALL  SELECT 7167,'Reece','Johnston','URP','714-270 Libero. St.','O-',TO_DATE('13/10/1994', 'DD-MM-YYYY'),'resident','1','Sikhism','M','7784','Keith Gardner','Jana Kelly','01-20-533-4065' FROM dual UNION ALL  SELECT 7168,'Daquan','Morse','ME','4248 Libero. Rd.','O-',TO_DATE('19/06/1997', 'DD-MM-YYYY'),'attached','2','Judaism','M','4123','Thaddeus Booker','India Dickerson','01-09-545-6690' FROM dual UNION ALL  SELECT 7169,'Clinton','Walls','ME','9480 Sed Road','AB+',TO_DATE('19/12/1991', 'DD-MM-YYYY'),'attached','2','Hinduism','M','6441','William Witt','Jeanette Davenport','01-56-744-4003' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7170,'Gannon','Snyder','URP','Ap #975-2226 Luctus, Ave','O+',TO_DATE('22/07/1997', 'DD-MM-YYYY'),'resident','2','Hinduism','M','2162','Harlan Jones','Sandra Simpson','01-35-507-5160' FROM dual UNION ALL  SELECT 7171,'Benedict','Hall','ME','2334 Aliquam Street','O-',TO_DATE('26/04/1992', 'DD-MM-YYYY'),'attached','2','Sikhism','M','6515','Hashim Wall','Samantha Hodges','01-41-238-7582' FROM dual UNION ALL  SELECT 7172,'George','Riley','MME','3153 Enim St.','O+',TO_DATE('27/07/1998', 'DD-MM-YYYY'),'resident','2','Judaism','M','9129','Cain Brennan','Rowan Beard','01-76-797-4235' FROM dual UNION ALL  SELECT 7173,'Howard','Richard','EEE','P.O. Box 774, 8323 Semper Rd.','B-',TO_DATE('14/01/1996', 'DD-MM-YYYY'),'resident','1','Buddhism','M','7490','Basil Meadows','Fiona Odom','01-82-535-5233' FROM dual UNION ALL  SELECT 7174,'Magee','Blair','CHE','6896 Enim Avenue','AB-',TO_DATE('13/01/1988', 'DD-MM-YYYY'),'resident','2','Buddhism','M','9052','Flynn Clements','Remedios Acevedo','01-54-526-7130' FROM dual UNION ALL  SELECT 7175,'Kenneth','Greene','CSE','Ap #681-6078 Eu Road','O-',TO_DATE('27/10/1990', 'DD-MM-YYYY'),'attached','2','Hinduism','M','6451','Gary Fischer','Ila Henderson','01-50-314-0111' FROM dual UNION ALL  SELECT 7176,'Jack','Anthony','CE','P.O. Box 377, 9774 Mauris Rd.','AB+',TO_DATE('26/02/1998', 'DD-MM-YYYY'),'resident','1','Judaism','M','8407','Alec Hooper','Lisandra Lane','01-48-301-4217' FROM dual UNION ALL  SELECT 7177,'Tanner','Swanson','CE','Ap #656-1928 Risus. St.','A+',TO_DATE('14/07/1996', 'DD-MM-YYYY'),'attached','2','Hinduism','M','2261','Elliott Floyd','Reagan Gilliam','01-36-590-3421' FROM dual UNION ALL  SELECT 7178,'Allistair','Griffin','IPO','P.O. Box 666, 9161 Ac St.','O+',TO_DATE('18/04/1995', 'DD-MM-YYYY'),'resident','1','Buddhism','M','5117','Hammett Bonner','Cassandra Murray','01-32-657-4889' FROM dual UNION ALL  SELECT 7179,'Kirk','Dudley','MME','P.O. Box 534, 3040 Cursus. Av.','A+',TO_DATE('17/03/1990', 'DD-MM-YYYY'),'resident','1','Hinduism','M','6316','Yasir Wallace','Odessa Conley','01-57-737-0692' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7180,'Hayes','Christensen','MME','532-8128 Est. St.','AB+',TO_DATE('03/04/1991', 'DD-MM-YYYY'),'resident','1','Christianity','M','8389','Hiram Jacobs','Yuri Mcknight','01-82-851-0505' FROM dual UNION ALL  SELECT 7181,'William','Chambers','EEE','P.O. Box 826, 8086 Ligula. Rd.','O+',TO_DATE('03/03/1995', 'DD-MM-YYYY'),'resident','2','Christianity','M','4000','Dustin Butler','Nora Mcleod','01-44-361-8481' FROM dual UNION ALL  SELECT 7182,'Elliott','Graves','MME','P.O. Box 331, 902 Auctor, St.','O+',TO_DATE('30/11/1993', 'DD-MM-YYYY'),'attached','2','Islam','M','8273','Jamal Wolf','Clio Valenzuela','01-92-968-9722' FROM dual UNION ALL  SELECT 7183,'Anthony','Marks','MME','P.O. Box 206, 7841 Imperdiet St.','B-',TO_DATE('27/10/1990', 'DD-MM-YYYY'),'resident','2','Hinduism','M','8795','Clark Rutledge','Maris Ware','01-16-936-2760' FROM dual UNION ALL  SELECT 7184,'Holmes','Baker','URP','768-6584 Sed Rd.','AB-',TO_DATE('07/02/1994', 'DD-MM-YYYY'),'attached','2','Hinduism','M','1632','Micah Jones','Bell Norris','01-38-800-3029' FROM dual UNION ALL  SELECT 7185,'Jonah','Barnett','URP','P.O. Box 353, 8120 Nec Rd.','AB+',TO_DATE('13/05/1993', 'DD-MM-YYYY'),'attached','1','Christianity','M','6688','Hop Lynch','Charissa Clay','01-20-573-6667' FROM dual UNION ALL  SELECT 7186,'Lucius','Bernard','CE','Ap #975-3497 Sed St.','A-',TO_DATE('03/11/1994', 'DD-MM-YYYY'),'resident','1','Hinduism','M','8331','Noble Collier','Phoebe Stuart','01-91-590-5633' FROM dual UNION ALL  SELECT 7187,'Alan','Briggs','EEE','643-7016 Praesent Road','O+',TO_DATE('14/07/1993', 'DD-MM-YYYY'),'attached','2','Christianity','M','3532','Armando Ballard','Shelby Wolfe','01-83-897-5928' FROM dual UNION ALL  SELECT 7188,'Guy','Williams','IPO','865-1019 Egestas Rd.','A-',TO_DATE('18/12/1987', 'DD-MM-YYYY'),'attached','2','Judaism','M','7052','Driscoll Lloyd','Chastity Hunt','01-36-219-1182' FROM dual UNION ALL  SELECT 7189,'Ignatius','Norman','MME','785-7565 Faucibus St.','A-',TO_DATE('16/03/1993', 'DD-MM-YYYY'),'resident','1','Judaism','M','6446','Myles Clements','Kelly Travis','01-60-414-2802' FROM dual;
	INSERT INTO table_student (id,first_name,last_name,department_id,address,blood_group,birth_date,type,hall_id,religion,gender,password,father_name,mother_name,contact_no)  SELECT 7190,'Evan','Reyes','MME','5256 Vivamus Avenue','B-',TO_DATE('28/12/1989', 'DD-MM-YYYY'),'resident','1','Islam','M','6166','Dante Thompson','Colette Jacobs','01-19-257-3651' FROM dual UNION ALL  SELECT 7191,'Dieter','Cross','ME','189 Commodo Av.','A+',TO_DATE('30/09/1988', 'DD-MM-YYYY'),'attached','2','Hinduism','M','1403','Aaron Maxwell','Priscilla Bryant','01-29-434-4785' FROM dual UNION ALL  SELECT 7192,'Rajah','Wheeler','IPO','P.O. Box 827, 1694 Imperdiet, Avenue','AB+',TO_DATE('26/02/1992', 'DD-MM-YYYY'),'resident','2','Christianity','M','4798','Beau Armstrong','Latifah Schwartz','01-12-768-0610' FROM dual UNION ALL  SELECT 7193,'Victor','Dunlap','IPO','3328 Sociis Rd.','O+',TO_DATE('28/11/1989', 'DD-MM-YYYY'),'resident','2','Judaism','M','3142','Adrian Cameron','Neve Terry','01-03-690-0609' FROM dual UNION ALL  SELECT 7194,'Finn','Klein','EEE','2760 Eu Rd.','AB-',TO_DATE('05/06/1998', 'DD-MM-YYYY'),'resident','1','Sikhism','M','3641','Grady Hess','Sade Mcgee','01-79-960-5320' FROM dual UNION ALL  SELECT 7195,'Dolan','Hawkins','URP','P.O. Box 100, 6381 Justo Road','A+',TO_DATE('17/02/1988', 'DD-MM-YYYY'),'attached','2','Buddhism','M','3656','Ralph Hess','Ivy Stewart','01-23-720-5961' FROM dual UNION ALL  SELECT 7196,'Quinn','Goff','CHE','265-8389 Nunc Street','AB+',TO_DATE('16/12/1990', 'DD-MM-YYYY'),'attached','2','Buddhism','M','5220','Oscar Hancock','Lacy Floyd','01-75-744-0919' FROM dual UNION ALL  SELECT 7197,'Alec','Wilcox','CHE','4189 Mauris Rd.','O+',TO_DATE('05/05/1990', 'DD-MM-YYYY'),'resident','1','Islam','M','3816','Upton Serrano','Idona Hicks','01-51-549-7845' FROM dual UNION ALL  SELECT 7198,'Kennedy','Knapp','CE','Ap #343-179 Gravida. Avenue','AB-',TO_DATE('22/03/1995', 'DD-MM-YYYY'),'resident','2','Judaism','M','4227','Porter Rodgers','Hadassah Joyce','01-85-867-0861' FROM dual UNION ALL  SELECT 7199,'Judah','Larsen','CHE','795-9491 Sapien, Rd.','O+',TO_DATE('07/03/1992', 'DD-MM-YYYY'),'attached','2','Judaism','M','9486','Uriah Hardy','Cheyenne Mcneil','01-37-607-0751' FROM dual;

	-- NEED TO UPDATE Female Students to make sure gender of hall matches
	update table_student
	set hall_id = (hall_id + 2)
	where (hall_id = 1 or hall_id = 2) and (gender = 'F');

-- ///////////////////////////////////


-- Room
	-- DEFAULT current_no_of_students is 0
	-- Room( hall_id(FK) , room_no(PK) , room_capacity, current_no_of residents)

	INSERT INTO table_room (hall_id,room_no,room_capacity)  SELECT '3',100,'6' FROM dual UNION ALL  SELECT '1',105,'6' FROM dual UNION ALL  SELECT '3',110,'5' FROM dual UNION ALL  SELECT '4',115,'4' FROM dual UNION ALL  SELECT '2',120,'4' FROM dual UNION ALL  SELECT '1',125,'5' FROM dual UNION ALL  SELECT '1',130,'5' FROM dual UNION ALL  SELECT '3',135,'4' FROM dual UNION ALL  SELECT '2',140,'6' FROM dual UNION ALL  SELECT '3',145,'4' FROM dual;
	INSERT INTO table_room (hall_id,room_no,room_capacity)  SELECT '1',150,'6' FROM dual UNION ALL  SELECT '1',155,'6' FROM dual UNION ALL  SELECT '2',160,'5' FROM dual UNION ALL  SELECT '1',165,'5' FROM dual UNION ALL  SELECT '1',170,'4' FROM dual UNION ALL  SELECT '2',175,'6' FROM dual UNION ALL  SELECT '1',180,'5' FROM dual UNION ALL  SELECT '3',185,'5' FROM dual UNION ALL  SELECT '1',190,'6' FROM dual UNION ALL  SELECT '1',195,'4' FROM dual;
	INSERT INTO table_room (hall_id,room_no,room_capacity)  SELECT '2',200,'4' FROM dual UNION ALL  SELECT '1',205,'6' FROM dual UNION ALL  SELECT '1',210,'6' FROM dual UNION ALL  SELECT '4',215,'6' FROM dual UNION ALL  SELECT '2',220,'6' FROM dual UNION ALL  SELECT '2',225,'4' FROM dual UNION ALL  SELECT '1',230,'5' FROM dual UNION ALL  SELECT '1',235,'6' FROM dual UNION ALL  SELECT '3',240,'4' FROM dual UNION ALL  SELECT '2',245,'6' FROM dual;
	INSERT INTO table_room (hall_id,room_no,room_capacity)  SELECT '3',250,'4' FROM dual UNION ALL  SELECT '3',255,'5' FROM dual UNION ALL  SELECT '1',260,'6' FROM dual UNION ALL  SELECT '1',265,'4' FROM dual UNION ALL  SELECT '3',270,'4' FROM dual UNION ALL  SELECT '3',275,'4' FROM dual UNION ALL  SELECT '1',280,'5' FROM dual UNION ALL  SELECT '4',285,'4' FROM dual UNION ALL  SELECT '1',290,'5' FROM dual UNION ALL  SELECT '2',295,'4' FROM dual;
	INSERT INTO table_room (hall_id,room_no,room_capacity)  SELECT '3',300,'6' FROM dual UNION ALL  SELECT '2',305,'6' FROM dual UNION ALL  SELECT '3',310,'4' FROM dual UNION ALL  SELECT '4',315,'4' FROM dual UNION ALL  SELECT '2',320,'5' FROM dual UNION ALL  SELECT '4',325,'4' FROM dual UNION ALL  SELECT '2',330,'5' FROM dual UNION ALL  SELECT '3',335,'6' FROM dual UNION ALL  SELECT '3',340,'4' FROM dual UNION ALL  SELECT '2',345,'6' FROM dual;
	INSERT INTO table_room (hall_id,room_no,room_capacity)  SELECT '4',350,'4' FROM dual UNION ALL  SELECT '3',355,'6' FROM dual UNION ALL  SELECT '2',360,'5' FROM dual UNION ALL  SELECT '3',365,'4' FROM dual UNION ALL  SELECT '4',370,'5' FROM dual UNION ALL  SELECT '1',375,'4' FROM dual UNION ALL  SELECT '2',380,'4' FROM dual UNION ALL  SELECT '1',385,'6' FROM dual UNION ALL  SELECT '1',390,'4' FROM dual UNION ALL  SELECT '3',395,'4' FROM dual;
	INSERT INTO table_room (hall_id,room_no,room_capacity)  SELECT '3',400,'6' FROM dual UNION ALL  SELECT '4',405,'5' FROM dual UNION ALL  SELECT '2',410,'6' FROM dual UNION ALL  SELECT '4',415,'4' FROM dual UNION ALL  SELECT '4',420,'6' FROM dual UNION ALL  SELECT '3',425,'5' FROM dual UNION ALL  SELECT '2',430,'5' FROM dual UNION ALL  SELECT '2',435,'6' FROM dual UNION ALL  SELECT '3',440,'4' FROM dual UNION ALL  SELECT '3',445,'5' FROM dual;
	INSERT INTO table_room (hall_id,room_no,room_capacity)  SELECT '2',450,'5' FROM dual UNION ALL  SELECT '2',455,'6' FROM dual UNION ALL  SELECT '4',460,'5' FROM dual UNION ALL  SELECT '2',465,'6' FROM dual UNION ALL  SELECT '3',470,'4' FROM dual UNION ALL  SELECT '2',475,'5' FROM dual UNION ALL  SELECT '4',480,'5' FROM dual UNION ALL  SELECT '4',485,'5' FROM dual UNION ALL  SELECT '1',490,'4' FROM dual UNION ALL  SELECT '3',495,'5' FROM dual;
	INSERT INTO table_room (hall_id,room_no,room_capacity)  SELECT '1',500,'4' FROM dual UNION ALL  SELECT '3',505,'5' FROM dual UNION ALL  SELECT '1',510,'4' FROM dual UNION ALL  SELECT '3',515,'6' FROM dual UNION ALL  SELECT '2',520,'6' FROM dual UNION ALL  SELECT '3',525,'4' FROM dual UNION ALL  SELECT '1',530,'5' FROM dual UNION ALL  SELECT '4',535,'4' FROM dual UNION ALL  SELECT '1',540,'5' FROM dual UNION ALL  SELECT '3',545,'4' FROM dual;
	INSERT INTO table_room (hall_id,room_no,room_capacity)  SELECT '3',550,'4' FROM dual UNION ALL  SELECT '4',555,'5' FROM dual UNION ALL  SELECT '4',560,'6' FROM dual UNION ALL  SELECT '4',565,'5' FROM dual UNION ALL  SELECT '3',570,'6' FROM dual UNION ALL  SELECT '2',575,'6' FROM dual UNION ALL  SELECT '3',580,'6' FROM dual UNION ALL  SELECT '2',585,'6' FROM dual UNION ALL  SELECT '1',590,'4' FROM dual UNION ALL  SELECT '3',595,'4' FROM dual;


-- ///////////////////////////////////


-- Event
	-- Cricket|Football|Chess|TableTennis|BasketBall|Debate
	-- Summer_Cricket|Winter_Cricket|InterHall_Cricket|Women_Cricket|Summer_Foortball|Winter_Foortball|InterHall_Foortball|Women_Foortball|Summer_Chess|Winter_Chess|InterHall_Chess|Women_Chess|Summer_BaseBall|Winter_BaseBall|InterHall_BaseBall|Women_BaseBall|Summer_TableTennis|Winter_TableTennis|InterHall_TableTennis|Women_TableTennis|Summer_Debate|Winter_Debate|InterHall_Debate|Women_Debate

	-- INSERT INTO table_event (name,year,sport,teacher_id)  SELECT 'InterHall_Foortball',2016,'Debate',244 FROM dual UNION  SELECT 'Summer_Debate',2015,'BasketBall',196 FROM dual UNION  SELECT 'Women_Foortball',2016,'Football',245 FROM dual UNION  SELECT 'Women_Chess',2012,'TableTennis',207 FROM dual UNION  SELECT 'Summer_Foortball',2015,'Cricket',267 FROM dual;
	-- INSERT INTO table_event (name,year,sport,teacher_id)  SELECT 'InterHall_Debate',2015,'BasketBall',128 FROM dual UNION  SELECT 'Summer_BaseBall',2013,'TableTennis',134 FROM dual UNION  SELECT 'Summer_Chess',2014,'Chess',130 FROM dual UNION  SELECT 'Winter_Foortball',2016,'Debate',159 FROM dual UNION  SELECT 'Summer_Foortball',2012,'Cricket',115 FROM dual UNION  SELECT 'Women_Foortball',2014,'TableTennis',288 FROM dual;
	-- INSERT INTO table_event (name,year,sport,teacher_id)  SELECT 'Winter_Debate',2015,'Football',187 FROM dual UNION  SELECT 'Winter_Cricket',2012,'Football',279 FROM dual UNION  SELECT 'Winter_TableTennis',2014,'Football',148 FROM dual UNION  SELECT 'Winter_Cricket',2014,'BasketBall',190 FROM dual UNION  SELECT 'Summer_Chess',2016,'Chess',142 FROM dual UNION  SELECT 'Women_Chess',2016,'Football',127 FROM dual;
	-- INSERT INTO table_event (name,year,sport,teacher_id)  SELECT 'Women_Foortball',2013,'BasketBall',191 FROM dual UNION  SELECT 'Women_Cricket',2012,'Chess',277 FROM dual UNION  SELECT 'Women_Cricket',2013,'Debate',130 FROM dual UNION  SELECT 'Summer_BaseBall',2014,'BasketBall',261 FROM dual UNION  SELECT 'Winter_Debate',2013,'TableTennis',183 FROM dual UNION  SELECT 'InterHall_TableTennis',2014,'Debate',127 FROM dual UNION  SELECT 'InterHall_Foortball',2012,'BasketBall',185 FROM dual;
	-- INSERT INTO table_event (name,year,sport,teacher_id)  SELECT 'Women_Foortball',2012,'BasketBall',228 FROM dual UNION  SELECT 'Summer_Chess',2015,'Debate',220 FROM dual UNION  SELECT 'Winter_TableTennis',2012,'TableTennis',165 FROM dual UNION  SELECT 'Summer_Chess',2017,'Football',128 FROM dual UNION  SELECT 'Winter_Chess',2013,'Cricket',242 FROM dual UNION  SELECT 'Women_Cricket',2017,'Cricket',293 FROM dual UNION  SELECT 'Women_Debate',2013,'Debate',228 FROM dual UNION  SELECT 'InterHall_BaseBall',2015,'BasketBall',233 FROM dual;
	-- INSERT INTO table_event (name,year,sport,teacher_id)  SELECT 'Winter_BaseBall',2015,'Chess',222 FROM dual UNION  SELECT 'InterHall_Chess',2012,'Football',210 FROM dual UNION  SELECT 'Summer_BaseBall',2012,'Debate',195 FROM dual UNION  SELECT 'Winter_Debate',2014,'Chess',254 FROM dual UNION  SELECT 'Women_Chess',2015,'Chess',148 FROM dual UNION  SELECT 'InterHall_Cricket',2015,'TableTennis',266 FROM dual UNION  SELECT 'Women_BaseBall',2017,'TableTennis',181 FROM dual;
	-- INSERT INTO table_event (name,year,sport,teacher_id)  SELECT 'Summer_BaseBall',2017,'Chess',277 FROM dual UNION  SELECT 'InterHall_BaseBall',2013,'Debate',211 FROM dual UNION  SELECT 'Winter_BaseBall',2017,'TableTennis',242 FROM dual UNION  SELECT 'Women_Chess',2013,'BasketBall',295 FROM dual UNION  SELECT 'Winter_Cricket',2015,'Chess',175 FROM dual UNION  SELECT 'Summer_Foortball',2013,'Football',236 FROM dual UNION  SELECT 'Summer_Cricket',2013,'Cricket',241 FROM dual UNION  SELECT 'InterHall_TableTennis',2017,'Debate',122 FROM dual UNION  SELECT 'Summer_Cricket',2015,'Football',268 FROM dual;
	-- INSERT INTO table_event (name,year,sport,teacher_id)  SELECT 'Winter_TableTennis',2015,'BasketBall',127 FROM dual UNION  SELECT 'Winter_TableTennis',2013,'TableTennis',260 FROM dual UNION  SELECT 'Women_Cricket',2014,'Cricket',178 FROM dual UNION  SELECT 'InterHall_Cricket',2016,'TableTennis',149 FROM dual UNION  SELECT 'Summer_Foortball',2017,'Debate',165 FROM dual UNION  SELECT 'Winter_Foortball',2017,'Football',294 FROM dual UNION  SELECT 'Summer_Cricket',2017,'BasketBall',206 FROM dual UNION  SELECT 'Winter_Chess',2012,'Cricket',144 FROM dual UNION  SELECT 'Women_Debate',2015,'Football',123 FROM dual;
	-- INSERT INTO table_event (name,year,sport,teacher_id)  SELECT 'Women_BaseBall',2013,'Football',152 FROM dual UNION  SELECT 'Women_TableTennis',2016,'Debate',232 FROM dual UNION  SELECT 'Women_Debate',2012,'Chess',122 FROM dual UNION  SELECT 'InterHall_Debate',2012,'Football',188 FROM dual UNION  SELECT 'InterHall_BaseBall',2012,'Cricket',127 FROM dual UNION  SELECT 'Summer_TableTennis',2017,'BasketBall',183 FROM dual UNION  SELECT 'Women_Cricket',2016,'Debate',120 FROM dual UNION  SELECT 'InterHall_Debate',2013,'Football',248 FROM dual;
	-- INSERT INTO table_event (name,year,sport,teacher_id)  SELECT 'InterHall_TableTennis',2016,'Chess',182 FROM dual UNION  SELECT 'Women_Chess',2017,'Cricket',150 FROM dual UNION  SELECT 'Winter_Cricket',2017,'TableTennis',213 FROM dual UNION  SELECT 'Summer_Foortball',2014,'BasketBall',111 FROM dual UNION  SELECT 'Summer_Cricket',2016,'BasketBall',109 FROM dual UNION  SELECT 'Women_Cricket',2015,'Chess',154 FROM dual UNION  SELECT 'Summer_TableTennis',2016,'Debate',173 FROM dual UNION  SELECT 'Women_BaseBall',2016,'TableTennis',186 FROM dual UNION  SELECT 'Women_TableTennis',2014,'Cricket',253 FROM dual;

-- INSERT INTO TABLE_EVENT VALUES( 'Football_2k15' , '2015' , 'Football' , '100' );
-- INSERT INTO TABLE_EVENT VALUES( 'Football_2k16' , '2016' , 'Football' , '120' );
-- INSERT INTO TABLE_EVENT VALUES( 'Football_2k17' , '2017' , 'Football' , '140' );
-- INSERT INTO TABLE_EVENT VALUES( 'Football_2k18' , '2018' , 'Football' , '160' );
-- INSERT INTO TABLE_EVENT VALUES( 'Football_2k19' , '2019' , 'Football' , '180' );
-- INSERT INTO TABLE_EVENT VALUES( 'Cricket_2k15' , '2015' , 'Cricket' , '200' );
-- INSERT INTO TABLE_EVENT VALUES( 'Cricket_2k16' , '2016' , 'Cricket' , '220' );
-- INSERT INTO TABLE_EVENT VALUES( 'Cricket_2k17' , '2017' , 'Cricket' , '240' );
-- INSERT INTO TABLE_EVENT VALUES( 'Cricket_2k18' , '2018' , 'Cricket' , '260' );
-- INSERT INTO TABLE_EVENT VALUES( 'Cricket_2k19' , '2019' , 'Cricket' , '280' );
-- INSERT INTO TABLE_EVENT VALUES( 'Chess_2k15' , '2015' , 'Chess' , '300' );
-- INSERT INTO TABLE_EVENT VALUES( 'Chess_2k16' , '2016' , 'Chess' , '320' );
-- INSERT INTO TABLE_EVENT VALUES( 'Chess_2k17' , '2017' , 'Chess' , '340' );
-- INSERT INTO TABLE_EVENT VALUES( 'Chess_2k18' , '2018' , 'Chess' , '360' );
-- INSERT INTO TABLE_EVENT VALUES( 'Chess_2k19' , '2019' , 'Chess' , '380' );



-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Football_2015' , '2015' , 'Football' , '150' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Football_2016' , '2016' , 'Football' , '170' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Football_2017' , '2017' , 'Football' , '190' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Football_2018' , '2018' , 'Football' , '210' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Football_2019' , '2019' , 'Football' , '230' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Cricket_2015' , '2015' , 'Cricket' , '250' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Cricket_2016' , '2016' , 'Cricket' , '270' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Cricket_2017' , '2017' , 'Cricket' , '290' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Cricket_2018' , '2018' , 'Cricket' , '310' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Cricket_2019' , '2019' , 'Cricket' , '330' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Chess_2015' , '2015' , 'Chess' , '350' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Chess_2016' , '2016' , 'Chess' , '370' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Chess_2017' , '2017' , 'Chess' , '390' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Chess_2018' , '2018' , 'Chess' , '110' );
-- INSERT INTO TABLE_EVENT VALUES( 'INTERHALL_Chess_2019' , '2019' , 'Chess' , '130' );



INSERT INTO TABLE_EVENT("EVENT_ID", "EVENT_NAME", "EVENT_YEAR", "EVENT_SPORT", "EVENT_TYPE", "EVENT_STATUS", "HALL_ID", "EVENT_SUPERVISOR_ID", "WINNER_TEAM_ID", "RUNNERUP_TEAM_ID") VALUES ('1', 'Football_2017_InterHall', '2017', 'FOOTBALL', 'OVER', 'LOCAL', '4', '201', NULL, NULL);
INSERT INTO TABLE_EVENT("EVENT_ID", "EVENT_NAME", "EVENT_YEAR", "EVENT_SPORT", "EVENT_TYPE", "EVENT_STATUS", "HALL_ID", "EVENT_SUPERVISOR_ID", "WINNER_TEAM_ID", "RUNNERUP_TEAM_ID") VALUES ('2', 'Football_2018_InterHall', '2018', 'FOOTBALL', 'UPCOMING', 'LOCAL', '4', '204', NULL, NULL);
-- ///////////////////////////////////




-- )
--  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\









-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- Layer 3
-- (

-- Allowed Guest
	
	INSERT INTO TABLE_ALLOWED_GUEST (NID,STUDENT_ID,RELATION) SELECT 5820,7000,'Father' from dual UNION
	SELECT 5820,7001,'Uncle' from dual UNION
	SELECT 5363,7000,'Uncle' from dual UNION
	SELECT 5363,7001,'Uncle' from dual ;
	INSERT INTO TABLE_ALLOWED_GUEST VALUES (5363, 7163, 'father');
	INSERT INTO TABLE_ALLOWED_GUEST VALUES (5820, 7163, 'mother');
	INSERT INTO TABLE_ALLOWED_GUEST VALUES (5820, 7162, 'aunt');
	INSERT INTO TABLE_ALLOWED_GUEST VALUES (6775, 7165, 'uncle');
	INSERT INTO TABLE_ALLOWED_GUEST VALUES (6104, 7173, 'brother');
	INSERT INTO TABLE_ALLOWED_GUEST VALUES (6775, 7173, 'father');
	INSERT INTO TABLE_ALLOWED_GUEST VALUES (6104, 7165, 'cousin');
	INSERT INTO TABLE_ALLOWED_GUEST VALUES (7704, 7172, 'uncle');
	INSERT INTO TABLE_ALLOWED_GUEST VALUES (5459, 7172, 'aunt');
	
-- ///////////////////////////////////


-- )
--  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\










-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- Layer 4
-- (


-- Hall_history


-- ///////////////////////////////////


-- Room_history

INSERT INTO "HALL_MANAGEMENT"."TABLE_ROOM_HISTORY"("HALL_ID", "ROOM_NO", "STUDENT_ID", "START_DATE", "END_DATE") VALUES ('4', '115', '7000', TO_DATE('2012-09-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "HALL_MANAGEMENT"."TABLE_ROOM_HISTORY"("HALL_ID", "ROOM_NO", "STUDENT_ID", "START_DATE", "END_DATE") VALUES ('2', '120', '7102', TO_DATE('2012-09-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2013-09-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "HALL_MANAGEMENT"."TABLE_ROOM_HISTORY"("HALL_ID", "ROOM_NO", "STUDENT_ID", "START_DATE", "END_DATE") VALUES ('2', '140', '7102', TO_DATE('2013-09-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "HALL_MANAGEMENT"."TABLE_ROOM_HISTORY"("HALL_ID", "ROOM_NO", "STUDENT_ID", "START_DATE", "END_DATE") VALUES ('3', '110', '7002', TO_DATE('2012-10-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "HALL_MANAGEMENT"."TABLE_ROOM_HISTORY"("HALL_ID", "ROOM_NO", "STUDENT_ID", "START_DATE", "END_DATE") VALUES ('1', '125', '7100', TO_DATE('2013-02-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL);


-- ///////////////////////////////////


-- Guest_log

INSERT INTO "HALL_MANAGEMENT"."TABLE_GUEST_LOG"("NID", "STUDENT_ID", "START_TIME", "END_TIME") VALUES ('5363', '7000', TO_DATE('2016-06-15 12:21:39', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-15 15:54:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "HALL_MANAGEMENT"."TABLE_GUEST_LOG"("NID", "STUDENT_ID", "START_TIME", "END_TIME") VALUES ('5820', '7000', TO_DATE('2016-06-18 11:21:39', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-18 15:54:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "HALL_MANAGEMENT"."TABLE_GUEST_LOG"("NID", "STUDENT_ID", "START_TIME", "END_TIME") VALUES ('5363', '7001', TO_DATE('2016-06-21 11:21:39', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-21 15:54:39', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "HALL_MANAGEMENT"."TABLE_GUEST_LOG"("NID", "STUDENT_ID", "START_TIME", "END_TIME") VALUES ('5363', '7000', TO_DATE('2018-01-05 13:01:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-01-05 14:22:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "HALL_MANAGEMENT"."TABLE_GUEST_LOG"("NID", "STUDENT_ID", "START_TIME", "END_TIME") VALUES ('5820', '7001', TO_DATE('2018-01-05 13:01:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-01-05 17:01:00', 'SYYYY-MM-DD HH24:MI:SS'));

-- ///////////////////////////////////


-- Teacher_Hall


INSERT INTO "HALL_MANAGEMENT"."TABLE_HALL_HEAD_HISTORY"("TEACHER_ID", "HALL_ID", "START_DATE", "END_DATE") VALUES ('100', '4', TO_DATE('1997-09-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "HALL_MANAGEMENT"."TABLE_HALL_HEAD_HISTORY"("TEACHER_ID", "HALL_ID", "START_DATE", "END_DATE") VALUES ('101', '3', TO_DATE('2001-01-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "HALL_MANAGEMENT"."TABLE_HALL_HEAD_HISTORY"("TEACHER_ID", "HALL_ID", "START_DATE", "END_DATE") VALUES ('205', '2', TO_DATE('2005-07-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2008-07-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "HALL_MANAGEMENT"."TABLE_HALL_HEAD_HISTORY"("TEACHER_ID", "HALL_ID", "START_DATE", "END_DATE") VALUES ('206', '2', TO_DATE('2008-08-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "HALL_MANAGEMENT"."TABLE_HALL_HEAD_HISTORY"("TEACHER_ID", "HALL_ID", "START_DATE", "END_DATE") VALUES ('210', '1', TO_DATE('2010-12-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), NULL);


-- ///////////////////////////////////


-- Staff_Hall

INSERT INTO TABLE_STAFF_WORKSAT_HALL VALUES(1, 108);
INSERT INTO TABLE_STAFF_WORKSAT_HALL VALUES(2, 109);
INSERT INTO TABLE_STAFF_WORKSAT_HALL VALUES(3, 112);
INSERT INTO TABLE_STAFF_WORKSAT_HALL VALUES(4, 114);


-- ///////////////////////////////////


-- Student_Team


-- ///////////////////////////////////


-- Winner_List


-- ///////////////////////////////////


-- Event_History


-- ///////////////////////////////////


-- Inter_Hall_Team


-- ///////////////////////////////////


-- Application

INSERT INTO TABLE_APPLICATION(APPLICATION_ID, STUDENT_ID, HALL_ID, APPLICATION_DATE, HAS_ROOM) 
VALUES(1, 7000, 4, TO_DATE('29/09/2015', 'DD/MM/YYYY'), 'N');

INSERT INTO TABLE_APPLICATION(APPLICATION_ID, STUDENT_ID, HALL_ID, APPLICATION_DATE, HAS_ROOM) 
VALUES(2, 7003, 3, TO_DATE('29/09/2015', 'DD/MM/YYYY'), 'N');

INSERT INTO TABLE_APPLICATION(APPLICATION_ID, STUDENT_ID, HALL_ID, APPLICATION_DATE, HAS_ROOM) 
VALUES(3, 7001, 4, TO_DATE('29/09/2015', 'DD/MM/YYYY'), 'N');

INSERT INTO TABLE_APPLICATION(APPLICATION_ID, STUDENT_ID, HALL_ID, APPLICATION_DATE, HAS_ROOM) 
VALUES(4, 7100, 1, TO_DATE('03/09/2016', 'DD/MM/YYYY'), 'Y');

INSERT INTO TABLE_APPLICATION(APPLICATION_ID, STUDENT_ID, HALL_ID, APPLICATION_DATE, HAS_ROOM) 
VALUES ( 5 , 7000 , 4 , TO_DATE( '29/09/1997' , 'dd/MM/yyyy') , 'N' );

-- ///////////////////////////////////

-- Applicaiton Room List 

INSERT INTO TABLE_APPLICATION_ROOM_LIST VALUES(4, 1, 105);
INSERT INTO TABLE_APPLICATION_ROOM_LIST VALUES(4, 1, 125);
INSERT INTO TABLE_APPLICATION_ROOM_LIST VALUES(4, 1, 150);
INSERT INTO TABLE_APPLICATION_ROOM_LIST VALUES(4, 1, 155);


-- ///////////////////////////////////
-- )
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
