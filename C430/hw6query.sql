delete from Student
where studentnum IN
(select studentnum
from Taking natural join Class
where department = 'CMPSC' and num= 463);


update Taking
	set grade = 3.2;