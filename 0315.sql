-- ȸ�� �����޿� ��պ��� ���� �޴� ���
select ename, sal from emp where sal > (select avg(sal) from emp);
select round(avg(sal)) from emp;

select deptno, round(avg(sal)) from emp group by deptno;
-- ȸ����� 2017, 10�� 2917, 20�� 2175, 30�� 1567

-- ������ �μ� ��պ��� ���� �޴� ���
-- main query�� sub query�� �����͸� ���Ͽ� ó���ϴ� sql�� ������� query
select ename, sal from emp e1 where sal > (select avg(sal) from emp e2 where e1.deptno = e2.deptno);
-- sub query ������ ��Ī�� ���� ����
select ename, sal from emp e where sal > (select avg(sal) from emp where e.deptno = deptno);

-- main query ������ �Ѱ��� �о �� �������� ����� sub query�� ���̺� mgr�� ������ ���
-- �ؿ� ������ ������ (�� �����ڸ�) ���
select empno, ename, sal from emp e where exists (select empno from emp where e.empno = mgr); -- ���ؾȰ�
select empno, ename, sal from emp e where not exists (select empno from emp where e.empno = mgr);
----------------------------------------------------------------------------------------------------------

--(��)--  exists !!!!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!
select * from emp;
1. �ڱ� �����޿� ��պ��� ���� �޴� ����� �̸�, �޿�, ����
select ename, sal, job from emp e where sal > (select avg(sal) from emp where e.job = job);

2. �ڱ� �μ� ��պ��� ���� �޴� ����� �̸�, �޿�, �μ��ڵ�, �μ���
select ename, sal, e.deptno, dname from emp e, dept d where e.deptno = d.deptno 
and sal > (select avg(sal) from emp where e.deptno = deptno);

3. exists ����Ͽ� ������ ���
select * from emp e where exists (select empno from emp where e.empno = mgr);

4. exists ������� �ʰ� �����ڸ� ���
select * from emp where empno in (select mgr from emp);

5. exists ����Ͽ� ���� ���� ���
select * from emp e where not exists (select empno from emp where e.empno = mgr);

6. exists ������� �ʰ� ���� ���� ���
select * from emp where empno not in (select mgr from emp where mgr is not null);

7. ȸ�� ��պ��� �޿��� ���� �޴� ��� �̸�, �޿�, �μ���, �޿����, �μ����, �޿�ū��
select ename, sal, dname, grade from emp e, dept d, salgrade where e.deptno = d.deptno;
and e.sal between losal and hisal and sal > (select avg(sal) from emp) order by dname, sal desc;

----------------------------------------------------------------------------------------------------------
--1. EMP ���̺��� Blake�� ���� �μ��� �ִ� ��� ����� �̸��� �Ի����ڸ� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
--2. EMP ���̺��� ��� �޿� �̻��� �޴� ��� �������� ���ؼ� ������ ��ȣ�� �̸��� ����ϴ� SELECT���� �ۼ��Ͻÿ�. �� �޿��� ���� ������ ����Ͽ���.
--3. EMP ���̺��� �̸��� ��T���� �ִ� ����� �ٹ��ϴ� �μ����� �ٹ��ϴ� ��� �������� ���� ��� ��ȣ,�̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�. 
--�� �����ȣ ������ ����Ͽ���.
--4. EMP ���̺��� �μ� ��ġ�� Dallas�� ��� �������� ���� �̸�,����,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
--5. EMP ���̺��� King���� �����ϴ� ��� ����� �̸��� �޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
--6. EMP ���̺��� SALES�μ� ����� �̸�,������ ����ϴ� SELECT���� �ۼ��Ͻÿ�.
--7. EMP ���̺��� ������ �μ� 30�� ���� ���޺��� ���� ����� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
--8. EMP ���̺��� �μ� 10���� �μ� 30�� ����� ���� ������ �ð� �ִ� ����� �̸��� ������ ����ϴ� SELECT���� �ۼ��Ͻÿ�.
--9. EMP ���̺��� FORD�� ������ ���޵� ���� ����� ��� ������ ����ϴ� SELECT���� �ۼ��Ͻÿ�


--1. EMP ���̺��� Blake�� ���� �μ��� �ִ� ��� ����� �̸��� �Ի����ڸ� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select ename, hiredate from emp where deptno = (select deptno from emp where ename = 'BLAKE');

--2. EMP ���̺��� ��� �޿� �̻��� �޴� ��� �������� ���ؼ� ������ ��ȣ�� �̸��� ����ϴ� SELECT���� �ۼ��Ͻÿ�. �� �޿��� ���� ������ ����Ͽ���.
select empno, ename from emp where sal >= (select avg(sal) from emp) order by sal desc;

--3. EMP ���̺��� �̸��� ��T���� �ִ� ����� �ٹ��ϴ� �μ����� �ٹ��ϴ� ��� �������� ���� ��� ��ȣ,�̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
--�� �����ȣ ������ ����Ͽ���.
select empno, ename, sal from emp where deptno in (select deptno from emp where ename like '%T%') order by empno;

select * from dept;
--4. EMP ���̺��� �μ� ��ġ�� Dallas�� ��� �������� ���� �̸�,����,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select ename, job, sal from emp where deptno = (select deptno from dept where loc = 'DALLAS');

--5. EMP ���̺��� King���� �����ϴ� ��� ����� �̸��� �޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select ename, sal from emp where mgr in (select deptno from emp where ename ='KING');
-- select ename, sal from emp e where mgr = (select empno from emp where e.mgr = empno and mgr is null);
--select ename, sal from emp e where mgr in (select empno from emp where e.mgr = empno and ename = 'KING');

--6. EMP ���̺��� SALES �μ� ����� �̸�,������ ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select ename, job from emp where deptno = (select deptno from dept where dname = 'SALES');

--7. EMP ���̺��� ������ �μ� 30�� ���� ���޺��� ���� ����� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select * from emp where sal > (select min(sal) from emp where deptno = 30);

--8. EMP ���̺��� �μ� 10���� �μ� 30�� ����� ���� ������ �ð� �ִ� ����� �̸��� ������ ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select ename, job from emp where deptno = 10 and job in (select job from emp where deptno = 30);

--(��)-- --9. EMP ���̺��� FORD�� ������ ���޵� ���� ����� ��� ������ ����ϴ� SELECT���� �ۼ��Ͻÿ�
select * from emp where (job, sal) = (select job, sal from emp where ename = 'FORD') and ename != 'FORD';
--select * from emp where job = (select job from emp where ename = 'FORD') and sal =(select sal from emp where ename = 'FORD');

----------------------------------------------------------------------------------------------------------
--10. EMP ���̺��� ������ JONES�� ���ų� ������ FORD�̻��� ����� ������ �̸�,����,�μ���ȣ,�޿��� ����ϴ� SELECT���� �ۼ�
--�� ������, ������ ���� ������ ����Ͽ���.
select ename, job, deptno, sal from emp where job = (select job from emp where ename = 'JONES' ) or
sal >= (select sal from emp where ename = 'FORD') order by job, sal desc;

--11. EMP ���̺��� SCOTT �Ǵ� WARD�� ������ ���� ����� ������ �̸�,����,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select ename, job, sal from emp where sal in (select sal from emp where ename in('SCOTT', 'WARD'));

--12. EMP ���̺��� CHICAGO���� �ٹ��ϴ� ����� ���� ������ �ϴ� ����� �̸�,������ ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select ename, job from emp where job in (select job from emp where deptno = (select deptno from dept where loc ='CHICAGO'));

--(��)-- --13. EMP ���̺��� �μ����� ������ ��� ���޺��� ���� ����� �μ���ȣ,�̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�. 
select deptno, ename, sal from emp e where sal > (select avg(sal) from emp where e.deptno = deptno);

--(��)-- --14. EMP ���̺��� �������� ������ ��� ���޺��� ���� ����� �μ���ȣ,�̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select deptno, ename, sal from emp e where sal < (select avg(sal) from emp where e.job = job);

--15. EMP ���̺��� ��� �Ѹ� �̻����κ��� ���� ���� �� �ִ� ����� ����,�̸�,�����ȣ,�μ���ȣ�� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select job, ename, empno, deptno from emp e where exists (select * from emp where e.empno = mgr);
select job, ename, empno, deptno from emp e where empno in (select mgr from emp);


--16. EMP ���̺��� ���� ����� �����ȣ,�̸�,����,�μ���ȣ�� ����ϴ� SELECT���� �ۼ��Ͻÿ�
select job, ename, empno, deptno from emp e where not exists (select * from emp where e.empno = mgr);
select job, ename, empno, deptno from emp e where empno not in (select mgr from emp where mgr is not null);
----------------------------------------------------------------------------------------------------------

-- DB��(schema).table��
create table emp_test (
    empid varchar2(5) primary key,
    firstname varchar2(10),
    LASTNAME varchar2(10),
    salary number(7)
    );

-- ���̺� ���� (drop table table��;)
drop table a;
drop table emp_test;

--08.CreateTable.pdf 9������ ��������
create table MY_DATA1 (
    id number(4) primary key not null,
    name varchar2(10),
    userid varchar2(30),
    salary number(10,2)
    );
    
drop table MY_DATA1;

-- ������ �ִ� ���̺��� �����ؼ� ���� �� �ִ�.
create table emp1 as select * from emp;
select * from emp1;
create table emp2 as select empno, ename, hiredate, sal from emp;
select * from emp2;
drop table emp1;

-- char(100) character ���� 1, 10, 100 = 100 byte ����
-- varchar(100) variable character ���� 1byte, 10byte, 100byte 
-- ������̸� Ȯ�� 2byte�� ����
-- => oracle���� varchar�� �����ؼ� varchar2�� �������

-- number(7) ���� 7�ڸ�
-- number(10,2) ���ڰ� �� 10�ڸ�, �Ҽ��� ���� 2�ڸ�
-- number ���� 38�ڸ� (default)
    

create table emp01 (
     empno number(4),
     ename varchar(20),
     sal number(7,2));

drop table emp01;

CREATE TABLE DEPT01 (
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)); --= varchar  13�ڸ�
    
drop table dept01;
    
CREATE TABLE EMP03 
AS 
SELECT EMPNO, ENAME FROM EMP;

select * from emp03;

-- 08.CreateTable.pdf �������� 22p
create table emp04 
as 
select empno, ename, sal from emp;

select * from emp04;

create table emp05 as select * from emp where deptno = 10;
select * from emp05;

-- ���̺� ������ ���� : where false�� �Ǵ� �������� �ۼ�
create table emp01 as select * from emp where 1 = 0;
-- �����ʹ� ���� �÷��� ������ ������ ����
select * from emp01;
desc emp01;

drop table emp01;

create table dept02 as select * from dept where 1 = 0;
desc dept02;


create table emp01 (
    empno number(4) primary key,
    ename varchar2(20) default '�ƹ���',
    sal number(5) default 1000
    );
    
desc emp01;
-- �Է�
-- insert into table�� values(��,....); : ��� �÷��� �����͸� ���� ä���� �Ѵ�.
-- insert into table�� (�÷�,....) values(��,....); : �÷��� �ִ� �����͸� �Է�
insert into emp01 values(1, '����', 2000);
select * from emp01;
insert into emp01 (empno, ename) values(2, '����');
insert into emp01 (empno, sal) values(3, 3000);

select * from emp01;
alter table emp01 add (job varchar2(20), hiredate date); -- �÷��� �߰��Ҷ�
select * from emp01;
alter table emp01 modify(job varchar2(15)); -- �÷��� �����Ҷ�
desc emp01;

drop table emp01;
drop table dept02;
--------------------------------------------------------------------
--08.CreateTable.pdf 30p ��������

--1. EMP01 ���̺� ���� Ÿ���� ����(JOB) Į���� �߰�
--2. DEPT02 ���̺� ���� Ÿ���� �μ���(DMGR) Į���� �߰�
--3. emp01 ���̺��� ����(JOB) Į���� �ִ� 30���ڱ��� ������ �� �ְ�
--������ ������ ����. 
--4. DEPT02 ���̺��� �μ���(DMGR) Į���� ���� Ÿ������ ������ ���ô�.

create table emp01 as select empno, ename, sal from emp where 1=0;
create table dept02 as select * from dept where 1 = 0;

--1. EMP01 ���̺� ���� Ÿ���� ����(JOB) Į���� �߰�
alter table emp01 add (job varchar2(20));
select * from emp01;
desc emp01;

--2. DEPT02 ���̺� ���� Ÿ���� �μ���(DMGR) Į���� �߰�
alter table dept02 add (dmgr varchar2(20));
desc dept02;

--3. emp01 ���̺��� ����(JOB) Į���� �ִ� 30���ڱ��� ������ �� �ְ�
--������ ������ ����. 
alter table emp01 modify (job varchar2(30));
desc emp01;

--4. DEPT02 ���̺��� �μ���(DMGR) Į���� ���� Ÿ������ ������ ���ô�.
alter table dept02 modify (dmgr number(20));
desc dept02;




alter table emp01 add (job varchar2(30));
