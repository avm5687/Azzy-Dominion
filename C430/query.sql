select name
from Student, Taking, Class
where Taking.semester='Spring 2018' and Taking.studentnum=Student.studentnum and department='CMPSC' and num=430;

