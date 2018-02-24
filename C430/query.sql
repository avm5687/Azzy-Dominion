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
from Student natural join Taking
where not exists
	(select name
		from Class
		where  department='CMPSC' and num=430);

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
where gpa >= max(gpa);

select count(gpa)
from Student
where gpa > 3.0;
