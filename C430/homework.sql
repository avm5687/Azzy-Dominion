create table Instructor(
	name varchar2(255) not null,
	department varchar2(255) not null,
	office varchar2(255) not null,
	primary key(name)
);

create table Class(
	schedulenum int not null,
	semester varchar2(255) not null,
	department varchar2(255) not null,
	num int not null,
	days varchar2(255) not null,
	time varchar2(255) not null,
	place varchar2(255) not null,
	enrollment varchar2(255) not null,
	primary key(schedulenum, semester)
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
	studentnum varchar2(255) not null,
	name varchar2(255) not null,
	standing varchar2(255) not null,
	gpa real not null,
	primary key(studentnum)
);

create table Taking(
	studentnum varchar2(255) not null,
	schedulenum int not null,
	semester varchar2(255) not null,
	grade real not null,
	primary key(studentnum, schedulenum, semester),
	foreign key(studentnum) references Student,
	foreign key(schedulenum, semester) references Class
);