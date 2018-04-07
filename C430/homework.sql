create table Instructor(
	name varchar2(255) not null,
	department varchar2(255) not null,
	office varchar2(255) not null,
	primary key(name)
);

create table Class(
	schedulenum int not null,
	department varchar2(255) not null,
	semester varchar2(255) not null,
	num int not null,
	days varchar2(255) not null,
	time int not null,
	place varchar2(255) not null,
	enrollment int not null,
	primary key(schedulenum, semester),
	unique(semester, days, time, place),
	check(days = 'MWF' or days = 'TuTh' and time > 0 and time < 24));

create table Teaches(
	name varchar2(255) not null,
	schedulenum int not null,
	semester varchar2(255) not null,
	primary key(name, schedulenum, semester),
	foreign key(name) references Instructor,
	foreign key(schedulenum, semester) references Class
);

create table Student(
	studentnum int not null,
	name varchar2(255) not null,
	standing varchar2(255) not null,
	gpa decimal(3,2) not null,
	primary key(studentnum)
);

create table Taking(
	studentnum int not null,
	schedulenum int not null,
	semester varchar2(255) not null,
	grade decimal(2,1),
	primary key(studentnum, schedulenum, semester),
	foreign key(studentnum) references Student,
	foreign key(schedulenum, semester) references Class
);

create or replace trigger StudentDeletion
before delete on Student
Referencing old as oldStudent
for each row
Begin
	delete from Taking
	where studentnum = :oldStudent.studentnum;
End;
/

create table gradeTrack(
	userName varchar2(30) not null,
	STAMP timestamp,
	studentnum int not null,
	department varchar2(255) not null,
	num int not null,
	oldGrade decimal(2,1),
	newGrade decimal(2,1)
);

create or replace trigger GradeUpdate
after update of grade on Taking
Referencing old as oldG new as newG
for each row
Begin
	Insert into gradeTrack VALUES(user, SYSTIMESTAMP, :oldG.studentnum, select department from class where schedulenum = :oldG.schedulenum, select num from class where schedulenum = :oldG.schedulenum, :oldG.grade, :newG.grade);
END;
/

 


--#3 create assertion ClassConstraint Check(select count(*) from class) <= select enrollment from class
--#8 all studenta were delected due to cascade
--9a NO i can't, I need to use the commit command in the 2nd terminal.
--9b Yes, because once I execute another query it executes my previous queries.
--9c Yes, because I properly exited.
--9d No, because i terminated the program before changes were commited.
