select name
from Student, Taking, Class
where semester=Spring2018 and Taking.studentnum=Student.studentnum and department=CMPSC and scehedule=430;

