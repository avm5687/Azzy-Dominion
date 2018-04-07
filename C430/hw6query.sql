delete from Student
where studentnum IN
(select studentnum
from Taking natural join Class
where department = 'CMPSC' and num= 463);


update Taking
	set grade = case
				when grade >= 2.0 then 1.0
				end;

update Taking
	set grade = 2.0;

update Taking
	set grade = case
		when grade >= 3.0 then 1.5
		end;
