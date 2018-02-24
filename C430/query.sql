select name
from Student, Taking, Class
where Taking.semester='Spring 2018' and Taking.studentnum=Student.studentnum and department='CMPSC' and num=430;

select name
from Student
where studentnum in
	(select studentnum
		from Taking, Class
		where semester='Spring 2018' and Taking.studentnum=Student.studentnum and department='CMPSC' and num=430);

select name, standing
from Student natural join Taking
where schedulenum
	(select schedulenum
	from Teaches
	where name='Linda Null' or name='Jeremy Blum');

select name, standing
from Student natural join Taking
where not exists
	(select schedulenum
		from Class
		where  department='CMPSC' and num=430);

select standing
from Student
where 