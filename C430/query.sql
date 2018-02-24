select distinct name
from Student, Taking, Class
where Taking.semester='Spring 2018' and Taking.studentnum=Student.studentnum and department='CMPSC' and num=430;

select distinct name
from Student
where studentnum in
	(select studentnum
		from Taking, Class
		where Taking.semester='Spring 2018' and Taking.studentnum=Student.studentnum and department='CMPSC' and num=430);

select distinct name, standing
from Student natural join Taking
where schedulenum in
	(select schedulenum
	from Teaches
	where name='Linda Null' or name='Jeremy Blum');

select distinct name, standing
from Student, Taking
where Student.studentnum = Taking.studentnum and not exists
	(select *
		from Class, Taking
		where  department='CMPSC' and num=430 and Student.studentnum = Taking.studentnum and Class.schedulenum = Taking.schedulenum);

select distinct name, standing
from Student
where standing=
	(select standing
	from Student
	where name='Alice')
order by name asc;

select distinct name, department
from Instructor
where office like '%Olmstead%';

select avg(gpa)
from Student;

select distinct name, standing
from Student
where gpa >=
(select MAX(gpa) AS highest_gpa
from Student);

select count(gpa)
from Student
where gpa > 3.0;

select distinct schedulenum, semester, avg(grade)
from Taking
where schedulenum in
(select schedulenum
from Class
where  department='CMPSC' and num=430)
group by schedulenum, semester;


with allCredits as
(
	select studentnum, count(schedulenum) as classCount
	from Taking
	where semester='Spring 2018'
	group by studentnum
)
select name, classCount
from student, allCredits
where student.studentnum = allCredits.studentnum and classCount >=
(select max(classCount) from allCredits);

select distinct name, standing
from Student, Taking
where Student.studentnum = Taking.studentnum and not exists
	(select *
		from Class, Taking
		where  department='CMPSC' and num=430 and Student.studentnum = Taking.studentnum and Class.schedulenum = Taking.schedulenum);