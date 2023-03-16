select * from emp e where exists (select * from emp where e.empno = mgr);

create table emp01 as select * from emp where 1 = 0;
desc emp01;

drop table emp01;

CREATE TABLE EMP01( 
EMPNO NUMBER(4), 
ENAME VARCHAR2(20), 
SAL NUMBER(7, 2));

select * from emp01;

alter table emp01 add(job varchar2(20));
alter table emp01 drop(job);

create table dept02 (
    deptno number(2) primary key,
    dname varchar2(14),
    loc varchar2(13));
    
select * from dept02;    
alter table dept02 add(dmgr varchar(20));
alter table dept02 drop(dmgr);
drop table emp01;

-- ���� ���Ἲ ��������: �ڽ��� �ִ� �����ʹ� ������ �� ����.
-- restrict default : �ڽ��� �ִ� �����ʹ� ������ �� ����.
-- set null: �θ� �����͸� ����� �ڽ��� fk�� ���� null�� ����
-- 
create table emp01 as select * from emp;
select * from emp01;
-- truncate�� �����͸� ����� ������ �ȵȴ�.
truncate table emp01;
-----------------------------------------------------------------------------
-- dept ���̺��� �̿��Ͽ� dept01 ���̺� ����
-- dept01 ���̺� ����
-- dept ���̺� ����

create table dept01 as select * from dept;
select * from dept01;
truncate table dept01;
drop table dept01;

create table dept01 as select * from dept;
alter table dept01 rename to buseo;
alter table buseo rename to dept01;

drop table dept01;

-------------------------------------------------------------
--08.CreateTable.pdf 38 ������
create table juso (
    no number(3),
    name varchar2(10),
    addr varchar2(20),
    email varchar2(5));

alter table juso add(phone varchar2(10));

alter table juso modify(email varchar2(20));

alter table juso drop(addr);

select * from juso;

drop table juso;
-------------------------------------------------------------
--08.CreateTable.pdf 39p
--1. EMP ���̺��� SAL, COMM�� ������ ��� COLUMN�� ���� �����ϴ� EMP_DEMO ���̺��� �����ϴ� SQL���� �ۼ��Ͽ���.
--2. EMP ���̺�� DEPT ���̺��� �̿��Ͽ� �Ʒ��� ������ �����ϴ� ���̺�(EMP_DEPT)�� �����Ͽ���.
--EMPNO ENAME JOB DNAME LOC
--------- ---------- --------- -------------- ------------
--7839 KING PRESIDENT ACCOUNTING NEW YORK
--7698 BLAKE MANAGER SALES CHICAGO
--. . . . . . . . . .
--3. EMP ���̺�� SALGRADE ���̺��� �̿��Ͽ� �Ʒ��� ������ �����ϴ� ���̺� (EMP_GRADE)�� �����Ͽ���.
--EMPNO ENAME JOB SAL COMM GRADE
----------- ---------- --------- --------- --------- ---------
--7839 KING PRESIDENT 5000 5
--7698 BLAKE MANAGER 2850 4
--7782 CLARK MANAGER 2450 4
--7566 JONES MANAGER 2975 4
--. . . . . . . . . .
--4. 3������ ������ ���̺� SAL�� ���е��� ���� �κ��� 12�ڸ� �Ҽ� ���� 4�ڸ��� �����ϴ� SQL ���� �ۼ��Ͽ���.
--5. 2���� 3������ ������ ���̺��� ��� �����ϴ� SQL���� �ۼ��Ͽ���


-------------------------------------------------------------
desc emp;
drop table emp_demo;
--1. EMP ���̺��� SAL, COMM�� ������ ��� COLUMN�� ���� �����ϴ� EMP_DEMO ���̺��� �����ϴ� SQL���� �ۼ��Ͽ���.
create table emp_demo as select empno, ename, job, mgr, hiredate, deptno from emp;  

--2. EMP ���̺�� DEPT ���̺��� �̿��Ͽ� �Ʒ��� ������ �����ϴ� ���̺�(EMP_DEPT)�� �����Ͽ���.
--EMPNO ENAME JOB DNAME LOC
--------- ---------- --------- -------------- ------------
--7839 KING PRESIDENT ACCOUNTING NEW YORK
--7698 BLAKE MANAGER SALES CHICAGO
--. . . . . . . . . .
create table emp_dept as select empno, ename, job, dname, loc from emp e, dept d
where e.deptno = d.deptno;
     
    
--3. EMP ���̺�� SALGRADE ���̺��� �̿��Ͽ� �Ʒ��� ������ �����ϴ� ���̺� (EMP_GRADE)�� �����Ͽ���.
--EMPNO ENAME JOB SAL COMM GRADE
----------- ---------- --------- --------- --------- ---------
--7839 KING PRESIDENT 5000 5
--7698 BLAKE MANAGER 2850 4
--7782 CLARK MANAGER 2450 4
--7566 JONES MANAGER 2975 4
--. . . . . . . . . .
create table emp_grade as select empno, ename, job, sal, comm, grade 
from emp, salgrade where sal between losal and hisal;

--4. 3������ ������ ���̺� SAL�� ���е��� ���� �κ��� 12�ڸ� �Ҽ� ���� 4�ڸ��� �����ϴ� SQL ���� �ۼ��Ͽ���.
alter table emp_grade modify(sal number(12,4));

--5. 2���� 3������ ������ ���̺��� ��� �����ϴ� SQL���� �ۼ��Ͽ���
drop table emp_demo;
drop table emp_dept;
drop table emp_grade;
-------------------------------------------------------------
-- �Է�
--1) insert into table�� (�÷�,...) values (��,...);
--   * ���� �÷��� ������ ���� ���� ������ ������ ��ġ�ؾ� �Ѵ�
--2) insert into table�� values(��,....);
--   * ��� �÷��� �ش��ϴ� ���� �־�� �Ѵ�.
--   * ���� ������ ���̺� ���ǿ� ���ƾ� �Ѵ�.
--3) sub query�� �̿��� �Է�

drop table dept01;
create table dept01 as select * from dept where 1 = 0;
select * from dept01;
insert into dept01 (deptno, dname) values(10, '����');
insert into dept01 (deptno, loc) values(20, '����');
insert into dept01 values(30,'�λ�','�뱸');

insert into dept01 values(40,'ȫ��', null);

-------------------------------------------------------------
drop table emp01;
--emp01 ���, �̸�, ����, �޿�
--1111 ���� 
--1234 ���� �λ� 1000 �÷�
--2222 ���� ȸ�� 2000 values

create table emp01 as select empno, ename, job, sal from emp where 1 = 0;
select * from emp01;
insert into emp01 (empno, ename) values(1111, '����');
insert into emp01 (empno, ename, job, sal) values (1234, '����', '�λ�', 1000);
insert into emp01 values (2222, '����', 'ȸ��' ,2000);
-------------------------------------------------------------
drop table emp01;
create table emp01 as select empno, ename, job, sal from emp where 1 = 0;
alter table emp01 add(hiredate date);
select * from emp01;

-- sysdate ����
insert into emp01 values(1111,'����','ȫ��',1000,sysdate);
-- user�� �α����� �����
insert into emp01 values(1112,user,'ȫ��',1000,to_date('03/02/23', 'rr/mm/dd'));

-------------------------------------------------------------
--09.DML���.pdf 15p
--1. ���� �������� �̿��Ͽ� ������ ���� ������ SAM01 ���̺��� �����Ͻÿ�. ������ ��� DROP TABLE�� ���� �� �����Ͻÿ�.
drop table sam01;
create table sam01 as select empno, ename, job, sal from emp where 1=0;

--2. SAM01 ���̺� ������ ���� �����͸� �߰��Ͻÿ�.
insert into sam01 values(1000,'APPLE','POLICE',10000);
insert into sam01 values(1010,'BANANA','NURSE',15000);
insert into sam01 values(1020,'ORANGE','DOCTOR',25000);
insert into sam01 values(1030, 'VERY', null, 10000);
insert into sam01 values(1040, 'CAT',null,2000);
--3. SAM01 ���̺� ������ ���� NULL ���� ���� ���� �߰��Ͻÿ�.
select * from sam01;
-------------------------------------------------------------
-- �� �κ� �������
select empno, ename, &a from emp;
select * from emp where sal >= &sal and lower(job) = '&job';
-- & a : ��� ���, &aa: ������ �ȹ��
select empno, ename, &&aa from emp;
define aa
define aa = sal

accept department prompt '�μ��� : '
select * from dept where dname = upper('&department');

select * from dept01;
truncate table dept01;

-- create�� ���� as�� �ִµ� insert�� ���� as�� ����
insert into dept01 select * from dept;
-------------------------------------------------------------
--SAM01 ���̺� ���� �������� ����Ͽ� EMP �� ����� ��� �� deptno�� 10�� ����� ������ �߰��Ͻÿ�
select * from sam01;
insert into sam01 select empno, ename, job, sal
from emp where deptno = 10;

-------------------------------------------------------------
-- update
-- 1) update table�� set �÷� = ��, ... where ����;
--      ������ ������ ��� ������ ����
-- 2) sub query�� update 

select * from emp01;
update emp01 set sal = 1500;
update emp01 set sal = 2000 where ename = '����';
update emp01 set ename='����', sal = 2500, hiredate=sysdate where empno=1112;
-------------------------------------------------------------
--1) sam01 deptno ����2 �÷��߰�
alter table sam01 add(deptno number(2));
desc sam01;
--2) �޿��� 2000�̻��� ��� �޿� 30% �λ�
update sam01 set sal = sal*1.3 where sal >= 2000;
--3) �޿��� 10000�̻��� ��� �޿� 5000�� �谨
update sam01 set sal = sal - 5000 where sal >= 10000;
--4) ����� 1030�� ����� �̸��� ������, �޿��� 10% �λ�
select * from sam01;
update sam01 set ename = '������', sal = sal * 1.1 where deptno = 1030;

--5) job�� null�� ����� job�� �������� ����
update sam01 set job = 'MUSIC' where job is null;
select * from sam01;


drop table sam01;
create table sam01 as select empno, ename, job, sal from emp where 1=0;

--2. SAM01 ���̺� ������ ���� �����͸� �߰��Ͻÿ�.
insert into sam01 values(1000,'APPLE','POLICE',10000);
insert into sam01 values(1010,'BANANA','NURSE',15000);
insert into sam01 values(1020,'ORANGE','DOCTOR',25000);
insert into sam01 values(1030, 'VERY', null, 10000);
insert into sam01 values(1040, 'CAT',null,2000);
alter table sam01 add(hiredate date);
select * from sam01;

insert into sam01 select empno, ename, job, sal, hiredate from emp where deptno = 10;
alter table sam01 add(deptno number(2));

update sam01 set sal = sal*1.3 where sal >= 2000;
update sam01 set sal = sal - 5000 where sal >= 10000;
update sam01 set ename = '������', sal = sal * 1.1 where deptno = 1030;
update sam01 set job = 'MUSIC' where job is null;
select * from sam01;

-- job 7900, sal = 7844 1020
update sam01 set sal = (select sal from emp where empno = 7844), job = (select job
from emp where empno=7900) where empno = 1020;
select * from sam01;

update sam01 set hiredate = sysdate where hiredate is null;
update sam01 set deptno = 20; -- ���� �� 20���� �ٲ�
update sam01 set deptno = 10 where empno in (select empno from emp);

-------------------------------------------------------------
--1. ����� 1000�� ����� �Ի����� scott�� ���� �޿��� adams�� ���� ����
--2. dname varchar2(20) �߰�
--3. dept ���̺��� �����Ͽ� sam01�� dname�� ä��ÿ�
--4. ��� 1030 �Ի����� 21/05/05�� ����
--5. ��� 1010�� ����� �μ��ڵ带 30���� �ϰ� �μ����� dept���̺� �����Ͽ� 30�μ������� ����

--1. ����� 1000�� ����� �Ի����� scott�� ����, �޿��� adams�� ���� ����
update sam01 set hiredate = (select hiredate from emp where ename = 'SCOTT'),
sal = (select sal from emp where ename = 'ADAMS') where empno = 1000;

--2. dname varchar2(20) �߰�
alter table sam01 add(dname varchar2(20));

--3. dept ���̺��� �����Ͽ� sam01�� dname�� ä��ÿ� [������� ����]
update sam01 s set dname = (select dname from dept where s.deptno = deptno);

--4. ��� 1030 �Ի����� 21/05/05�� ����
update sam01 set hiredate = to_date('21/05/05', 'rr/mm/dd') where empno = 1030;

--5. ��� 1010�� ����� �μ��ڵ带 30���� �ϰ� �μ����� dept���̺� �����Ͽ� 30�μ������� ����
update sam01 set deptno = 30, dname = (select dname from dept where deptno = 30)
where empno = 1010;



