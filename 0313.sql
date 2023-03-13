-- �׷� �Լ� ���� : MAX, MIN, SUM, AVG, COUNT
select sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp;
select sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp where deptno = 10;
select sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp where deptno = 20;
select sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp where deptno = 30;
-- ! �׷��Լ��� ���� ����ϴ� Į���� �ݵ�� group by�� �־�� �Ѵ�. !
select deptno, sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp group by deptno;
--select deptno, sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp; ���� �߻�

-- group by: �����Ͱ� ���� �ų��� ��ġ�� ��
select deptno, job, sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp group by deptno, job order by deptno, job;
select deptno, job, sum(sal), avg(sal), max(sal), min(sal), count(*) from emp group by deptno, job order by deptno, job;

select sum(sal), avg(sal), sum(sal)/count(*) from emp;

-- !! ȥ�� ���� !! -- 
-- sum(comm)/ count(comm) :  Ŀ�̼��� �޴� �����, comm�� null�� ����� ����
-- sum(comm)/count(*), sum(nvl(comm,0))/count(*) : comm�� �� �޴� ������� �հ�
-- ������ data������ null�� ���� ���� ����
select sum(comm), avg(comm),sum(comm)/count(comm), sum(comm)/count(*), sum(nvl(comm,0))/count(*), avg(nvl(comm,0)) from emp;
------------------------------------------------------------------------------------------------------------------------------
--1. �μ��� �޿��հ�, �޿� ���
--2. ������ �ִ� �޿�, �ּ� �޿�
--3. ������ manager�̰ų� analyst�� ����� �޿��հ�, �޿����
--4. �μ���, �޿��հ�, �ִ� �޿�
--5. �μ���, �ٹ���, �޿��հ�, �ο��� �μ����
--6. �μ���, �ִ�޿�, �ּұ޿�, �ο��� comm�� null�� �ƴ� ���
--7. ������ �ִ�޿�, �ּұ޿�, �ο��� ������ ����
--8. �μ���, ������, �ִ�޿�, �ּұ޿�, �ο��� �μ����, ������ �� ����
--9. ������ �޿��հ�, �ִ�޿�, �ּұ޿�, �ο���


--1. �μ��� �޿��հ�, �޿� ���
select deptno, sum(sal), avg(nvl(sal,0)), avg(sal) from emp group by deptno;

--2. ������ �ִ� �޿�, �ּ� �޿�
select job, max(sal), min(sal) from emp group by job;

--3. ������ manager�̰ų� analyst�� ����� �޿��հ�, �޿����
select job, sum(sal), avg(sal) from emp where lower(job) in ('manager','analyst') group by job;
select sum(sal), avg(sal) from emp where lower(job) in ('manager','analyst');

desc dept;
desc emp;

--4. �μ���, �޿��հ�, �ִ� �޿�
select dname, sum(sal), max(sal) from emp e, dept d where e.deptno = d.deptno group by dname;

--5. �μ���, �ٹ���, �޿��հ�, �ο��� �μ����
select dname, loc, sum(sal), count(*) from emp e, dept d where e.deptno = d.deptno group by dname, loc order by dname;

--6. �μ���, �ִ�޿�, �ּұ޿�, �ο��� comm�� null�� �ƴ� ���
select dname, max(sal), min(sal), count(*) from emp e, dept d where e.deptno = d.deptno and comm is not null group by dname;

--7. ������ �ִ�޿�, �ּұ޿�, �ο��� ������ ����
select job, max(sal), min(sal), count(*) from emp group by job order by job;

--8. �μ���, ������, �ִ�޿�, �ּұ޿�, �ο��� �μ����, ������ �� ����
select dname, job, max(sal), min(sal), count(*) from emp e, dept d where e.deptno = d.deptno group by dname, job 
order by dname, job; 

-- count(*) : ex) �ش� �÷����� �޿��� �� �޴� ������� ����.

--9. ������ �޿��հ�, �ִ�޿�, �ּұ޿�, �ο���
select sum(sal), max(sal), min(sal), count(*) from emp;
------------------------------------------------------------------------------------------------------------------------------

-- select �÷�,... from table��,... where ����(���̺�κ��� ����) group by �÷�/�� having ����(�׷��Լ��� ���� ����) order by �÷�/����/��Ī/��;
-- group by���� ���� ��Ī�� �� �� ����.

-- �μ��� �ο����� 4�� �̻��� �μ��� �ִ�޿�, �޿��հ�, �ο���
select deptno, max(sal), sum(sal), count(*) from emp where count(*) >= 4 group by deptno;  -- ���� �߻�
-- �� ������ �߻��ұ�?
-- where�� ���̺�κ��� �����͸� �����ϴ� ���� : ���̺�κ��� ������ �� check -> �� �������� �� �� �ִµ� ���� �Ȳ������Ƿ�
-- ��� �ذ��� �� �ִ���?
-- !!! having�� �׷��Լ��� ���� ���� (where ��: �׷쿡 ���� ����, having: �׷��Լ��� ���� ����) !!!
--- ! �׷쿡 ���� ������ where���� �ۼ��ϸ� �ȵȴ� !
select deptno, max(sal), sum(sal), count(*) from emp group by deptno having count(*) >= 4; 

-- ��ø�Լ� : �Լ��� 2�� �̻� ���� ��� (oracle�� ��ø�Լ� �ذ� ���� ��밡��)
select max(max(sal)), min(min(sal)), min(min(sal)), max(min(sal))  from emp group by deptno;
------------------------------------------------------------------------------------------------------------------------------
--1. �μ���, �޿��հ�, �ִ�޿�, �ִ�޿��� 2900 �̻�
select deptno, sum(sal), max(sal) from emp group by deptno having max(sal) >= 2900;

--2. ������, �޿��հ�, �ִ�޿�, �ο����� 3�� �̻��� ����
select job, sum(sal), max(sal), count(*) from emp group by job having count(*) >= 3;

--3. ������ �ִ�޿� �� ���� ���� �޿��� ���� ���� �޿�
select max(max(sal)), min(max(sal)) from emp group by job;

--4. �μ��� �޿��հ� �߿� �ּұ޿�, �ִ�޿�, �ִ��ο�
select min(sum(sal)), max(sum(sal)), max(count(*)) from emp group by deptno;

--5. �μ���, �޿��հ� �޿��հ谡 9000�̻��� �μ�
select dname, sum(sal) from emp e, dept d where e.deptno = d.deptno group by dname having sum(sal) >= 9000;

--6. �μ���, ��ձ޿�(�Ҽ��� 1�ڸ� �ݿø�) ��� �޿��� 2000 �̻��� �μ� �μ���� ����
select dname, round(avg(sal), 1) from emp e, dept d where e.deptno = d.deptno group by dname having avg(sal)>= 2000 order by dname;
------------------------------------------------------------------------------------------------------------------------------
--1. EMP ���̺��� �ο���,�ִ� �޿�,�ּ� �޿�,�޿��� ���� ����Ͽ� ����ϴ� SELECT ������ �ۼ��Ͽ���.
--2. EMP ���̺��� �� �������� �ִ� �޿�,�ּ� �޿�,�޿��� ���� ����ϴ� SELECT ������ �ۼ��Ͽ���.
--3. EMP ���̺��� ������ �ο����� ���Ͽ� ����ϴ� SELECT ������ �ۼ��Ͽ���.
--4. EMP ���̺��� �ְ� �޿��� �ּ� �޿��� ���̴� ���ΰ� ����ϴ� SELECT ������ �ۼ��Ͽ���.
--5. EMP ���̺��� �Ʒ��� ����� ����ϴ� SELECT ������ �ۼ��Ͽ���

--1. EMP ���̺��� �ο���,�ִ� �޿�,�ּ� �޿�,�޿��� ���� ����Ͽ� ����ϴ� SELECT ������ �ۼ��Ͽ���.
select count(*), max(sal), min(sal), sum(sal) from emp;

--2. EMP ���̺��� �� �������� �ִ� �޿�,�ּ� �޿�,�޿��� ���� ����ϴ� SELECT ������ �ۼ��Ͽ���.
select job, max(sal), min(sal), sum(sal) from emp group by job;

--3. EMP ���̺��� ������ �ο����� ���Ͽ� ����ϴ� SELECT ������ �ۼ��Ͽ���.
select job, count(*) from emp group by job;

--4. EMP ���̺��� �ְ� �޿��� �ּ� �޿��� ���̴� ���ΰ� ����ϴ� SELECT ������ �ۼ��Ͽ���.
select max(sal) - min(sal)�޿����� from emp;

--5. EMP ���̺��� �Ʒ��� ����� ����ϴ� SELECT ������ �ۼ��Ͽ��� (�����Լ��� groupby.pdf 29������ �������� 5��)
SELECT to_char(hiredate, 'yy') "H_YEAR", COUNT(*), MIN(SAL), MAX(SAL), AVG(SAL), SUM(SAL) FROM EMP
GROUP BY to_char(hiredate, 'yy')ORDER BY to_char(hiredate, 'yy') ;

--6
select sum(count(*)) TOTAL, sum(decode(to_char(hiredate, 'yy'), 80, count(*))) "1980",
sum(decode(to_char(hiredate, 'yy'), 81, count(*))) "1981", sum(decode(to_char(hiredate, 'yy'), 82, count(*))) "1982",
sum(decode(to_char(hiredate, 'yy'), 83, count(*))) "1983" from emp group by hiredate;

--7
select job, sum(decode(deptno, 10, sal)) "Deptno 10", sum(decode(deptno, 20, sal)) "Deptno 20", 
sum(decode(deptno, 30, sal)) "Deptno 30", sum(sal) Total from emp group by job order by job;
------------------------------------------------------------------------------------------------------------------------------

select deptno, job, sum(sal) from emp group by deptno, job order by deptno, job;
select deptno, job, sal from emp order by deptno, job;

-- ���� �ڵ带 �ǹ� ���̺�� ���� ���� �ٲٴ� ���� ��ǥ
select deptno, sum(decode(job,'CLERK',sal)) CLERK, sum(decode(job,'MANAGER',sal)) MANAGER, 
sum(decode(job,'PRESIDENT',sal)) PRESIDENT, sum(decode(job,'ANALYST',sal)) ANALYST, sum(decode(job,'SALESMAN',sal)) SALESMAN 
from emp group by deptno order by deptno;

-- ���� �հ�
select deptno, sum(decode(job,'CLERK',sal)) CLERK, sum(decode(job,'MANAGER',sal)) MANAGER, 
sum(decode(job,'PRESIDENT',sal)) PRESIDENT, sum(decode(job,'ANALYST',sal)) ANALYST, sum(decode(job,'SALESMAN',sal)) SALESMAN, 
sum(sal)�հ� from emp group by deptno order by deptno;
-- ���� �հ�
select deptno, sum(decode(job,'CLERK',sal)) CLERK, sum(decode(job,'MANAGER',sal)) MANAGER, 
sum(decode(job,'PRESIDENT',sal)) PRESIDENT, sum(decode(job,'ANALYST',sal)) ANALYST, sum(decode(job,'SALESMAN',sal)) SALESMAN, 
sum(sal) �հ� from emp group by rollup(deptno) order by deptno;

------------------------------------------------------------------------------------------------------------------------------
--(�����Լ��� groupby.pdf 35������)
--1. ������̺��� �ִ�޿�, �ּұ޿�, ��ü �޿���, ����� ���Ͻÿ�
--2. ������̺��� �μ��� �ο����� ���Ͻÿ�
--3. ������̺��� �μ��� �ο����� 6�� �̻��� �μ��ڵ带 ���Ͻÿ�
--4. ������̺��� ������ ���� ����� ������ �Ͻÿ�
--5. ������̺��� �޿��� ���� ������� ����� �ο��Ͽ� ������ ���� ����� ������ �Ͻÿ�.  ��Ʈ self join, group by, count���

--1. ������̺��� �ִ�޿�, �ּұ޿�, ��ü �޿���, ����� ���Ͻÿ�
select max(sal), min(sal), sum(sal), avg(sal) from emp;

--2. ������̺��� �μ��� �ο����� ���Ͻÿ�
select deptno, count(*) �ο��� from emp group by deptno;

--3. ������̺��� �μ��� �ο����� 6�� �̻��� �μ��ڵ带 ���Ͻÿ�
select deptno, count(*) from emp group by deptno having count(*) >= 6;

--4. ������̺��� ������ ���� ����� ������ �Ͻÿ�
select dname,  sum(decode(job,'CLERK',sal)) CLERK, sum(decode(job,'MANAGER',sal)) MANAGER,
sum(decode(job,'PRESIDENT',sal)) PRESIDENT, sum(decode(job,'ANALYST',sal)) ANALYST, sum(decode(job,'SALESMAN',sal)) SALESMAN
from emp e, dept d where e.deptno = d.deptno group by dname order by dname;

--5. ������̺��� �޿��� ���� ������� ����� �ο��Ͽ� ������ ���� ����� ������ �Ͻÿ�.  ��Ʈ self join, group by, count���
select e1.ename, count(e2.sal) + 1 ��� from emp e1, emp e2 where e1.sal < e2.sal(+) group by e1.ename order by ���;

select ename, rank() over (order by sal desc) ��� from emp;
