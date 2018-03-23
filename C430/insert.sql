INSERT INTO Class VALUES(1235, 'CMPSC', 'S18', 463, 'TuTh', '13', 'Olmstead E240', 20);
INSERT INTO Class VALUES(1236, 'CMPSC', 'S18', 121, 'MWF', '9', 'Olmstead E240', 30);
INSERT INTO Class VALUES(1232, 'CMPSC', 'S18', 360, 'ThTr', '18', 'Olmstead E240', 60);

INSERT INTO Student VALUES(6265443, 'Diablo', 'Sophomore', 4.0);
INSERT INTO Student VALUES(6265444, 'Lisa', 'Senior', 3.0);
INSERT INTO Student VALUES(6265445, 'James', 'Senior', 3.0);


INSERT INTO Taking
select studentnum
from Student
where(schedulenum) IN
(select schedulenum
 from Class
 where department = 'CMPSC');

update Student
set gpa = case
when gpa >= 3.5 then 4.0
else gpa + 0.5
End;

create view report_card as
select name, semester, department, num, grade
from Student natural join Taking natural join Class
where semester = 'F17';

delete from Student
where studentnum IN
(select studentnum
from Taking natural join Class
where department = 'CMPSC' and num= 463);

