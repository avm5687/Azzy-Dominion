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
	time varchar2(255) not null,
	place varchar2(255) not null,
	enrollment int not null,
	primary key(schedulenum, semester),
	unique(semester, days, time, place),
	check(days = 'MWF' or days = "TuTh" and time > 0 and time < 24)

);

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
	grade decimal(2,1) not null,
	primary key(studentnum, schedulenum, semester),
	foreign key(studentnum) references Student
	on delete cascade,
	foreign key(schedulenum, semester) references Class
	on delete cascade
);


--#3 create assertion ClassConstraint Check(select count(*) from class) <= select enrollment from class
