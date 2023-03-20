create view emp_v1 as select empno, ename, job, deptno from emp where deptno = 10;
-- view : ���� �����ʹ� ������ select���� �����Ͽ� �����͸� �����ͼ� ��¥ ���̺�ó�� ���
-- view : ���� ���̺��� ������ �ִ� ��ó�� ���
select * from emp_v1;
-- �Ʒ� �ҽ��ڵ�� ���� �߻�
create view emp_v1 as select empno, ename, job, e.deptno, dname from emp e, dept d where e.deptno = d.deptno;


-- �� ����
create or replace view emp_v1 as select empno, ename, job, e.deptno, dname from emp e, dept d where e.deptno = d.deptno;
select * from emp_v1;

-- �並 �����ϴ� ���
drop view emp_v1;
------------------------------------------------
create or replace view emp_v1 as select w.ename worker, m.ename manager from emp w, emp m
where w.mgr = m.empno;

select * from emp_v1;

-- �Ʒ� �ҽ��ڵ�� ���� �߻�, !! �׻� �÷� ���� ��Ī�� �� ������� !!
create or replace view emp_v1 as select w.ename, m.ename from emp w, emp m
where w.mgr = m.empno;
-- �ƴϸ� �� �ڿ� ��Ī�� ����Ѵ�.
create or replace view emp_v1(worker, manager) as select w.ename, m.ename from emp w, emp m
where w.mgr = m.empno;

select * from emp_v1;
------------------------------------------------
-- �並 ���̺�ó�� ��� ����
select empno, ename, job, manager from emp, emp_v1 where ename = worker; -- worker�� ������ ������ ename
------------------------------------------------
CREATE OR REPLACE VIEW v_emp2 (�����ȣ, �̸�, �μ���ȣ) 
AS SELECT empno, ename, deptno FROM emp WHERE deptno=20;

select * from v_emp2;
-- �並 ����ϸ� ��ġ ���̺�ó�� ��� ����
------------------------------------------------
--11.View,Sequence,Index.pdf 10p

-- �Ʒ� �ҽ��ڵ�� ���� �߻� sal*12��� �÷��� emp�� �������� �����Ƿ�
create or replace view v_emp2 as select empno, ename, sal*12 from emp;
-- join ������ ���� �÷����� ���� ��Ī�� ����ϰų� view �ڿ� �÷����� �Ἥ ���� �ٸ��� �����ؾ� �Ѵ�.
-- �Ʒ� �ڵ�� ���̽����� ������� �÷��� ��Ī�� �������־�� �Ѵ�.
create or replace view v_emp2 as select empno, ename, sal*12 year_sal from emp;
select * from v_emp2;
------------------------------------------------
-- �μ��� �޿��հ�, ��ձ޿�(�ݿø�)�� �μ��ڵ�, �޿��հ�, ��ձ޿��� ���� emp_v2�� �����
create or replace view emp_v2 as select deptno, sum(sal) �޿��հ�, round(avg(sal)) ��ձ޿�
from emp group by deptno order by deptno;
-- �Լ��� ����ִ� ���� �÷����� ����� �� ���� ������ ��Ī�� �������� �Ѵ�.
select * from emp_v2;

-- !  �Լ��� ���Ե� �÷��� �ݵ�� ��Ī�� ����Ͽ� �÷����� �����ؾ� �Ѵ�.  !
create or replace view emp_v2 (deptno, sum_sal, avg_sal) 
as select deptno, sum(sal), round(avg(sal)) from emp group by deptno order by deptno;

select * from emp_v2;

-- ���� �μ� ��պ��� �޿��� ���� �޴� ����� �̸�, �޿�, �μ��ڵ�, �μ��޿� ���
-- avg_sal�� ���� emp_v2 �信�� ������ �÷����̴�
select ename, sal, e.deptno, avg_sal from emp e, emp_v2 v where e.deptno = v.deptno;
------------------------------------------------

select * from emp03; -- ���߿� ���� �÷� �߰��ؾ���. 0317
create or replace view v_emp03 as select * from emp03;
select * from v_emp03;

-- �並 �����ߴ��� ���� �����͵� �����Ǿ���. -> ���� ������ ��
delete from v_emp03 where empno = 1111;
select * from emp03;
insert into v_emp03 values(1234,'����',5000); -- ����


-- �� �������� ������ �ִ�. �����ڷ� 12p ����
 -- !! VIEW�� ������ ���� �Ѵٸ� ���� ������ �� �����ϴ�. !!
    -- �׷� �Լ�
    -- GROUP BY��
    -- DISTINCTŰ����
    
select * from emp_v2;
delete from emp_v2 where deptno = 10; -- �����Ͱ� �������� �ʴ´�. ��?
insert into emp_v2 values(40, 4000, 2500); -- ���� �߻�
------------------------------------------------
-- 14p 
-- check option : where ���ǿ� ���� �ʴ� �����ʹ� �Է�,����,������ �� ����.
create or replace view view_chk30 as select empno, ename, sal, comm, deptno
from emp where deptno = 30 with check option;
-- �μ��ڵ� 30�� �����͸� �� �� �ִ�.

update view_chk30 set deptno = 20; -- ���� �߻�
------------------------------------------------
-- read only 16p ����
 CREATE OR REPLACE VIEW v_Read_Only AS
SELECT empno, ename, deptno FROM emp WHERE deptno = 10 WITH READ ONLY;
-- �ܼ��� �б� �� �� �� �ְ� �����ʹ� �Է����� ���Ѵ�.
------------------------------------------------
-- !! �߿� !! �ζ��� �� : �並 �������� �ʰ� �ѹ��� ����ϴ� ���
-- �μ���� �޿����� ���� �޴� ���
select empno, ename, sal, deptno from emp e 
where sal > (select round(avg(sal)) from emp where e.deptno = deptno);

-- ���� �߻�, �׷� �Լ��� ���̴� �÷��� group by���� �������.
select empno, ename, sal, deptno, avg(sal) from emp e 
where sal > (select round(avg(sal)) from emp where e.deptno = deptno); 

-- �÷��� ��ձ޿��� �����Ͽ� ����ϰ� ���� ��
select * from emp_v2;

select empno, ename, sal, e.deptno, avg_sal from emp e, emp_v2 v
where e.deptno = v.deptno;

-- emp_v2 ���� view�� ���� ��? 
-- from �ڿ� sub query�� ����Ͽ� ���̺�ó�� ����ϴ� ���� �ζ��� ���� �Ѵ�.
-- �ζ��� ��� �信 ����� ���� �ʴ´�. �� ���� ��� ����
select empno, ename, sal, e.deptno, avg_sal from emp e,
(select deptno, round(avg(sal)) avg_sal from emp group by deptno) v
where e.deptno = v.deptno;
------------------------------------------------
--1. ���,�̸�,����,�Ի���,�μ��ڵ带 ���� view emp_v1 ����
--2. ���,�̸�,����,�޿�,����(=(�޿�+comm)*12 �� comm�� null�̸� 0)�� ���� emp_v2
--3. ���,�̸�,����,�޿�,����� ���� emp_v3
--4. ���,�̸�,����,�μ��ڵ�,�μ���,�ٹ����� ���� emp_dept_v1
--5. �μ��ڵ�,�ִ�޿�,�ּұ޿�,�޿��հ踦 ���� emp_v4
--6. �ڱ���� ��պ��� ���� �޴� ����� �̸�,����,�޿�,������ձ޿��� in_line view�� ����Ͽ� �ۼ�


--1. ���,�̸�,����,�Ի���,�μ��ڵ带 ���� view emp_v1 ����
create or replace view emp_v1 as select empno,ename,job,hiredate,deptno from emp;
select * from emp_v1;

--2. ���,�̸�,����,�޿�,����(=(�޿�+comm)*12 �� comm�� null�̸� 0)�� ���� emp_v2
create or replace view emp_v2 as select empno,ename,job,sal,(sal+nvl(comm,0))*12 year_sal
from emp;
select * from emp_v2;

--3. ���,�̸�,����,�޿�,����� ���� emp_v3
create or replace view emp_v3 as select w.empno,w.ename worker,w.job,w.sal,m.ename manager from emp w, emp m
where w.mgr = m.empno;
select * from emp_v3;

--4. ���,�̸�,����,�μ��ڵ�,�μ���,�ٹ����� ���� emp_dept_v1
create or replace view emp_dept_v1 as select empno,ename,job,e.deptno,dname,loc from emp e, dept d
where e.deptno = d.deptno;
select * from emp_dept_v1;

--5. �μ��ڵ�,�ִ�޿�,�ּұ޿�,�޿��հ踦 ���� emp_v4
--1)
create or replace view emp_v4(deptno,max_sal,min_sal,sum_sal)
as select deptno,max(sal),min(sal),sum(sal) from emp group by deptno;
select * from emp_v4;
--2)
create or replace view emp_v4
as select deptno,max(sal) max,min(sal) min,sum(sal) sum from emp group by deptno;

--6. �ڱ���� ��պ��� ���� �޴� ����� �̸�,����,�޿�,������ձ޿��� in_line view�� ����Ͽ� �ۼ�
select ename,e.job,sal,avg_job from emp e,(select job,round(avg(sal)) avg_job from emp
group by job) a where e.job = a.job and e.sal > avg_job;
------------------------------------------------
select rownum, ename, sal from emp;
-- rownum ���̺�κ��� �����͸� �����ϴ� ����

-- ó�� ���̺� ������� ���� rownum ������ �״�� ������ �ִ�.
select rownum, ename, sal from emp order by sal desc;

-- �ζ��� ��, ��ȣ �ȿ� �ִ� �ڵ�� ���̺�� ���
select rownum, ename, sal from (select ename, sal from emp order by sal desc);
-- rn�� ���� rownum
select rownum, rn, ename, sal from (select rownum rn, ename, sal from emp order by sal desc);
------------------------------------------------
-- topN ��û �߿� !!!!

-- topN �޿��� ���� �޴� ������ 5��
select rownum, rn, ename, sal from (select rownum rn, ename, sal from emp order by sal desc)
where rownum <= 5;

-- topN �޿� 6 ~ 10��°���� ���
-- rownum: ���̺��� �������� �����̹Ƿ� �Ʒ� �ڵ�� ��µ��� �ʴ´�.
select rownum, rn, ename, sal from (select rownum rn, ename, sal from emp order by sal desc)
where rownum between 6 and 10; -- ��µ��� �ʴ´�.
-- ������¼��� rownum�� �ٲ��.

-- topN �޿� 6 ~ 10��°���� ���
select * from (select rownum rn, ename, sal from 
(select rownum rn, ename, sal from emp order by sal desc))
where rn between 6 and 10;

-- topN �޿� 6 ~ 10��°���� ���
select rownum, ename, sal from (select rownum rn, a.* from 
(select ename, sal from emp order by sal desc) a)
where rn between 6 and 10;

select rownum, rn, ename, sal from (select rownum rn, a.* from 
(select ename, sal from emp order by sal desc) a)
where rn between 6 and 10;
------------------------------------------------
--37p
--1. EMP ���̺��� ��� ��ȣ(empno), �̸�(ename), ����(job)�� �����ϴ� EMP_VIEW VIEW�� �����Ͽ���.
--2. 1������ ������ VIEW�� �̿��Ͽ� 10�� �μ��� �ڷḸ ��ȸ�Ͽ���.
--3. EMP ���̺�� �ζ��� �並 ����Ͽ� �޿��� ���� �޴� ������� 3�� ����ϴ� ��(SAL_TOP5_VIEW)�� �ۼ��Ͻÿ�.


--1. EMP ���̺��� ��� ��ȣ(empno), �̸�(ename), ����(job)�� �����ϴ� EMP_VIEW VIEW�� �����Ͽ���.
create view EMP_VIEW as select empno, ename, job from emp;
select * from EMP_VIEW;

--2. 1������ ������ VIEW�� �̿��Ͽ� 10�� �μ��� �ڷḸ ��ȸ�Ͽ���.
select * from emp_view v, emp e where v.empno = e.empno and e.deptno = 10;

--3. EMP ���̺�� �ζ��� �並 ����Ͽ� �޿��� ���� �޴� ������� 3�� ����ϴ� ��(SAL_TOP3_VIEW)�� �ۼ��Ͻÿ�.
select * from (select * from emp order by sal desc) where rownum <= 3;
------------------------------------------------
-- rank() 
select empno, ename, sal, rank() over(order by sal desc) rank from emp;

-- where : table�κ��� �����͸� �����ϴ� ���� 
select empno, ename, sal, rank() over(order by sal desc) rank from emp
where rank <= 5; -- ���� �߻�

-- 'rank'��� �÷��� �������Ƿ� ��� ����
select * from (select empno, ename, sal, rank() over(order by sal desc) rank from emp)
where rank <= 5;

-- �޿� 6 ~ 10
select * from (select empno, ename, sal, rank() over(order by sal desc) rank from emp)
where rank between 6 and 10;

-- 2���� 2��, 10���� 2�� ���
select empno, ename, sal, rank() over(order by sal desc) rank from emp;

-- dense_rank() �Լ� 
select empno, ename, sal, rank() over(order by sal desc) rank,
dense_rank() over(order by sal desc) dense from emp;

-- row_number() �Լ� : �������
select empno, ename, sal, rank() over(order by sal desc) rank,
dense_rank() over(order by sal desc) dense, 
row_number() over(order by sal desc) rn from emp;

-- partition by : �� �μ����� �� ������?
select empno, ename, sal, rank() over(order by sal desc) rank,
dense_rank() over(order by sal desc) dense, 
row_number() over(order by sal desc) rn,
deptno, rank() over(partition by deptno order by sal desc) part from emp;

select empno, ename, sal, rank() over(partition by deptno order by sal desc) part, 
deptno from emp;

-----------------------------------
-- WITH �̰� ���� �Ⱦ�
WITH summary as (SELECT dname, sum(sal) dept_total FROM emp, dept
WHERE emp.deptno = dept.deptno GROUP BY dname)
SELECT dname, dept_total FROM summary WHERE dept_total > (select sum(dept_total) * 1/3 from summary)
ORDER BY dept_total desc;
-----------------------------------
--p44
--1. EMP ���̺��� ��� ��ȣ,�̸�,����, �μ��ڵ带 �����ϴ� EMP_VIEW VIEW�� �����Ͽ���.
--2. 1������ ������ VIEW�� �̿��Ͽ� 10�� �μ��� �ڷḸ ��ȸ�Ͽ���.
--3. EMP ���̺�� DEPT ���̺��� �̿��Ͽ� �̸�,����,�޿�,�μ���,��ġ�� �����ϴ� EMP_DEPT_NAME�̶�� VIEW�� �����Ͽ���.


--1. EMP ���̺��� ��� ��ȣ,�̸�,����,�μ��ڵ带 �����ϴ� EMP_VIEW VIEW�� �����Ͽ���.
create or replace view EMP_VIEW as select empno, ename, job, deptno from emp;
select * from EMP_VIEW;

--2. 1������ ������ VIEW�� �̿��Ͽ� 10�� �μ��� �ڷḸ ��ȸ�Ͽ���.
select * from EMP_VIEW where deptno = 10;

--3. EMP ���̺�� DEPT ���̺��� �̿��Ͽ� �̸�,����,�޿�,�μ���,��ġ�� �����ϴ� EMP_DEPT_NAME�̶�� VIEW�� �����Ͽ���.
create or replace view EMP_DEPT_NAME as select ename,job,sal,dname,loc from emp e, dept d
where e.deptno = d.deptno;
-----------------------------------
--p45
--1. �μ���, ������� ����ϴ� dname_ename_view ����
--2. �����, ����� worker_manager_view ����
--3. ���, �����, �Ի���  �Ի����� ���� ������ ���� (�ֱ� �Ի�)
--4. ���, �����, �Ի���  �Ի����� ���� �� 5��
--5. ���, �����, �Ի���  �Ի����� ���� �� 6�� ~ 10��


--1. �μ���, ������� ����ϴ� dname_ename_view ����
create view dname_ename_view as select dname, ename from emp e, dept d
where e.deptno = d.deptno;
select * from dname_ename_view;

--2. �����, ����� worker_manager_view ����
create view worker_manager_view as select e1.ename ���, e2.ename ������
from emp e1, emp e2 where e1.mgr = e2.empno;

--3. ���, �����, �Ի���  �Ի����� ���� ������ ���� (�ֱ� �Ի�)
select empno, ename, hiredate from emp order by hiredate desc;

--4. ���, �����, �Ի���  �Ի����� ���� �� 5��
select empno, ename, hiredate from (select empno, ename, hiredate from emp order by hiredate desc)
where rownum <= 5;

--5. ���, �����, �Ի���  �Ի����� ���� �� 6�� ~ 10��
select * from (select rownum rn, a.* from (select * from emp order by hiredate desc) a)
where rn between 6 and 10;
-----------------------------------
drop view emp_v1;

drop table sawon;

-- ������
-- sawon_seq.nextval 1���� �����ؼ� 1�� ����
create table sawon (num number(5) primary key, val varchar2(20));
create sequence sawon_seq;
insert into sawon values(sawon_seq.nextval,'�ȳ��ϼ���');
insert into sawon values(sawon_seq.nextval,'�ݰ����ϴ�');
insert into sawon values(sawon_seq.nextval,'�ݰ�����');
select * from sawon;

-- �ٸ� DB������ auto_increment�� ����ϸ� 1���� 1�� ����
-- increment by : �����ϴ� ũ�� ���� ����, start with: �����ϴ� ��ȣ ���Ƿ� ���ϱ�
create sequence sawon_seq2 increment by 2 start with 11;
insert into sawon values(sawon_seq2.nextval,'�ȳ�');
insert into sawon values(sawon_seq2.nextval,'����');
insert into sawon values(sawon_seq2.nextval,'����');
select * from sawon;

-- currval: ���� ��, from dual?
select sawon_seq.currval from dual;

alter sequence sawon_seq increment by 2;
insert into sawon values(sawon_seq.nextval,'����');
select * from sawon;

-- ������ ����
drop sequence sawon_seq;
-----------------------------------
--11.View,Sequence,Index.pdf 65p

--1. ���� ���� 1�̰� 1�� �����ϰ�, �ִ��� 100000�� �Ǵ� ������ EMP_SEQ �����մϴ�
create sequence emp_seq start with 1 increment by 1 maxvalue 100000;

--2. �̹����� ������ �������� ����ϱ� ���ؼ� ��� ��ȣ�� �⺻ Ű�� �����Ͽ� EMP01�� �̸����� ���Ӱ� �����սô�.
drop table emp01; -- �̹� �ִ� ���̺� �����
create table emp01 (
    empno number(4) primary key,
    ename varchar(10),
    hiredate date);
select * from emp01;

--3. ��� ��ȣ�� �����ϴ� EMPNO �÷��� �⺻ Ű�� �����Ͽ����Ƿ� �ߺ��� ���� ���� �� �����ϴ�. 
--������ ������ EMP_SEQ �������κ��� �����ȣ�� �ڵ����� �Ҵ� �޾� �����͸� �߰��ϴ� �����Դϴ�. 
insert into emp01 values(emp_seq.nextval, 'JULIA', sysdate);
-----------------------------------
-- 72p 
--5. �μ� ��ȣ�� �����ϴ� ������ ��ü�� �����Ͽ� ������ ��ü�� �̿��Ͽ� �μ� ��ȣ�� �ڵ� �����ϵ��� �� ���ô�. 
--�� ������ Ǯ�� ���ؼ� ������ ���� �μ� ���̺��� �����մϴ�.

create table dept_example(
    deptno number(4) primary key,
    dname varchar(15),
    loc varchar(15));
    
desc dept_example;    

--5.1 DEPTNO �÷��� ������ ���� ���� �� �ֵ��� ������ ��ü ����(������ �̸� : DEPT_EXAMPLE_SEQ)�� ���ô�
create sequence dept_example_seq start with 10 increment by 10;

--5.2 ���ο� �ο츦 �߰��� ������ �������� ���ؼ� ������ ���� �μ���ȣ�� �ڵ� �ο��ǵ��� �� ���ô�.
insert into dept_example values (dept_example_seq.nextval,'�λ��','����');
insert into dept_example values (dept_example_seq.nextval,'�����','��õ');
select * from dept_example;  -- �� ���� �ٽ� �����ؾ���. pdf Ȯ��
-----------------------------------
-- create index index�� on table�� (�÷�,...);
-- drop index index��

-- 87p
--���̺� EMP01�� �÷� �߿��� �̸�(ENAME)�� ���ؼ� �ε����� �����غ��ô�. 
create index idx_emp01_name on emp01(ename);

select * from emp01;

--EMP01 ���̺��� IDX_EMP01_ENAME�� ����ڰ� �ε����� ������ ���Դϴ�. �̸� ������ ���ô�. ������ �ε��� ��ü��
--�����ϱ� ���ؼ��� DROP INDEX ���� ����մϴ�
drop index idx_emp01_name;
-----------------------------------
-- 91p
-- EMP ���̺��� �̸��� ������ INDEX(emp_ename_indx)�� ����
create index emp_ename_indx on emp(ename);

---------------------------------
-- ���Ǿ�
create synonym e for emp;
select * from e;

-- ����� �߰�
-- create user user_id(����) identified by ��ȣ

create user c##kim identified by k1;
grant create session to c##kim;

grant select on c##scott.dept to c##kim;
revoke select on c##scott.emp from c##kim;

grant select on c##scott.emp to c##kim;
grant update (dname, loc) on c##scott.dept to c##kim;
---------------------------------
-- 57p
drop user c##kim;
-- ���߿� �����ϱ�

-- 1. ������ KIM, ��ȣ�� LION�� ����� ������ �ۼ��Ͻÿ�.
create user c##kim identified by lion;

-- 2. KIM���� CREATE TABLE�� CREATE SESSION ������ �ο��Ͻÿ�.
grant create table, create session to c##kim;

-- 3. KIM���� SCOTT�� DEPT, EMP ���̺��� SELECT ������ �ο��Ͻÿ�.
grant select on c##scott.dept to c##kim;
grant select on c##scott.emp to c##kim;

-- 4. KIM���� SCOTT�� EMP ���̺� SAL,COMM �÷��� UPDATE�� �� �ִ� ������ �ο��Ͻÿ�.
grant update (sal,comm) on c##scott.emp to c##kim;

-- 5. KIM���� �ο��� EMP ���̺��� UPDATE ������ ȸ���Ͻÿ�.
revoke update on c##scott.emp from c##kim;
---------------------------------
-- 58p
--1. ����ڴ� KSH�̰� �н������ KIM�� ����ڸ� �����Ͽ���.
create user c##ksh identified by c##kim;

--2. ������ ����ڿ��� CONNECT�� RESOURCE������ �ο��Ͽ���.
grant connect, resource to c##ksh;

--3. �ο��� ������ ����ϰ� KSH����ڸ� �����Ͽ���.
revoke connect, resource from c##ksh;
drop user c##ksh;

-----------------------------
select * from dept;
select * from emp;
drop table emp; -- �ڽ�
drop table dept; -- �θ�

 select w.ename ����, m.ename ������, dname �μ��� from emp w, emp m, dept d where w.deptno = d.deptno and w.mgr = m.empno;
select ename, job, dname from emp e, dept d where e.deptno = d.deptno;




