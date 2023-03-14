-- ���� �հ�
select deptno, sum(decode(job,'CLERK',sal)) CLERK,
sum(decode(job,'MANAGER',sal)) MANAGER, 
sum(decode(job,'PRESIDENT',sal)) PRESIDENT,
sum(decode(job,'ANALYST',sal)) ANALYST,
sum(decode(job,'SALESMAN',sal)) SALESMAN, 
sum(sal) �հ� from emp group by rollup(deptno) order by deptno;

-- rollup�� cube�� �� �ڵ�� ���� ����� �������� �ٸ� ����.
select deptno, sum(decode(job,'CLERK',sal)) CLERK,
sum(decode(job,'MANAGER',sal)) MANAGER, 
sum(decode(job,'PRESIDENT',sal)) PRESIDENT,
sum(decode(job,'ANALYST',sal)) ANALYST,
sum(decode(job,'SALESMAN',sal)) SALESMAN, 
sum(sal) �հ� from emp group by CUBE(deptno) order by deptno;

select deptno, sum(sal) from emp group by deptno order by deptno;
select deptno, sum(sal) from emp group by rollup(deptno) order by deptno;
select deptno, sum(sal) from emp group by cube(deptno) order by deptno;

select deptno,job,sum(sal) from emp group by deptno,job order by deptno;
select deptno, job,sum(sal) from emp group by rollup(deptno,job) order by deptno;
select deptno, job,sum(sal) from emp group by cube(deptno,job) order by deptno;

-- GROUPING() �Լ�: ���� ������� ����
select grouping(deptno), deptno, sum(sal) from emp group by rollup(deptno) order by deptno;

-- ���� ����
-- ȸ�翡�� ���� �޿��� ���� ����� �̸��� �޿�
select ename, max(sal) from emp group by ename; --�ùٸ� �ڵ尡 �ƴ�. ����� �� ����� ������ ����.
select ename, sal from emp;


-- ȸ�翡�� ���� �޿��� ���� ����� �̸��� �޿�
select max(sal) from emp;
select ename, sal from emp where sal = 5000;
-- ���� �ڵ�� �� �������� �Ǿ� �ִ�. -> �� �������� ���� �ʿ䰡 �ִ�.
            -- main query                -- sub query
select ename, sal from emp where sal = (select max(sal) from emp); -- ��ȣ �ӿ� �ڵ带 ������ �� �ڵ带 ���� ���� -> ���� ����

-- scott�� �μ���
select dname from dept where deptno = (select deptno from emp where ename = 'SCOTT');

-------------------------------------------------------------------------------------------------------------
--1. �޿��� ���� ���� ����� �̸��� �޿�
--2. ���� ���� �Ի��� ����� �̸�, �Ի���, �޿�, �޿����
--3. ���� �ֱٿ� �Ի��� ����� �̸�, �޿�, �޿����, �μ���
--4. NEW YORK�� �ٹ��ϴ� ����� ��� �̸�, ����, �Ի���, �μ��ڵ�
--5. ALLEN�� ���� ������ �����ϴ� ����� �̸�, �޿�, ����, COMM
--6. ȸ�� ��� �޿����� ���� �޴� ����� �̸�, �޿�, �μ��ڵ�
--7. ȸ�� ��պ��� ���� �޴� ����� �̸�, �޿�, �μ��� �μ����
--8. RESEARCH �μ��� �ٹ��ϴ� ����� �̸�, �޿�, ����, �޿����, �μ���
--9. 81�⿡ �Ի��� ��� �߿��� ȸ�� �޿� ��պ��� �޿��� ���� �޴� ����� �̸�, �޿�, �μ���, �޿����, �μ���� ����

--1. �޿��� ���� ���� ����� �̸��� �޿�
select ename, sal from emp where sal = (select min(sal) from emp);

--2. ���� ���� �Ի��� ����� �̸�, �Ի���, �޿�, �޿����
select ename, hiredate, sal, grade from emp, salgrade where sal between losal and hisal and
hiredate = (select min(hiredate) from emp);

--3. ���� �ֱٿ� �Ի��� ����� �̸�, �޿�, �޿����, �μ���
select ename, sal, grade, dname from emp e, dept d, salgrade where e.deptno = d.deptno and 
e.sal between losal and hisal and hiredate = (select max(hiredate) from emp);

--4. NEW YORK�� �ٹ��ϴ� ����� ��� �̸�, ����, �Ի���, �μ��ڵ�
select ename, job, hiredate, d.deptno from emp e, dept d where e.deptno = d.deptno and loc = 'NEW YORK';
select ename, job, hiredate, deptno from emp where deptno = (select deptno from dept where loc = 'NEW YORK'); -- ���� Ǯ��

--5. ALLEN�� ���� ������ �����ϴ� ����� �̸�, �޿�, ����, COMM
select ename, sal, job, comm from emp where job = (select job from emp where ename = 'ALLEN');

--6. ȸ�� ��� �޿����� ���� �޴� ����� �̸�, �޿�, �μ��ڵ�
select ename, sal, deptno from emp where sal > (select avg(sal) from emp);

--7. ȸ�� ��պ��� ���� �޴� ����� �̸�, �޿�, �μ��� �μ����
select ename, sal, dname from emp e, dept d where e.deptno = d.deptno and sal < (select avg(sal) from emp) order by dname;

--8. RESEARCH �μ��� �ٹ��ϴ� ����� �̸�, �޿�, ����, �޿����, �μ���
select ename, sal, job, grade, dname from emp e, dept d, salgrade where e.deptno = d.deptno 
and e.sal between losal and hisal and dname = 'RESEARCH';

--9. 81�⿡ �Ի��� ��� �߿��� ȸ�� �޿� ��պ��� �޿��� ���� �޴� ����� �̸�, �޿�, �μ���, �޿����, �μ���� ����
select ename, e.sal, dname, grade from emp e, dept d, salgrade where e.deptno = d.deptno and e.sal between losal and hisal
and to_char(hiredate, 'yy') = '81' and sal > (select avg(sal) from emp) order by dname;

-------------------------------------------------------------------------------------------------------------
--1. ��� ���̺��� BLAKE���� �޿��� ���� ������� ���, �̸�, �޿�
select empno, ename, sal from emp where sal > (select sal from emp where ename = 'BLAKE');

--2. ��� ���̺��� MILLER���� �ʰ� �Ի��� ����� ���, �̸�, �Ի���
select empno, ename, hiredate from emp where hiredate > (select hiredate from emp where ename = 'MILLER');

--3. ��� ���̺��� ��� ��ü ��� �޿����� �޿��� ���� ������� ���, �̸�, �޿�
select empno, ename, sal from emp where sal > (select avg(sal) from emp);

--4. ��� ���̺��� CLERK�� ���� �μ��̸�, ����� 7698�� ������ �޿����� ���� �޿��� �޴� ������� ���, �̸�, �޿�
select empno, ename, sal from emp where deptno = (select deptno from emp where ename ='CLERK') 
and sal > (select sal from emp where empno = '7698');

--5. ��� ���̺��� �μ��� �ִ� �޿��� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� (�����)
select empno, ename, deptno, sal from emp where sal in (select max(sal) from emp group by deptno);
select empno, ename, deptno, sal from emp where sal = any(select max(sal) from emp group by deptno);
select empno, ename, deptno, sal from emp where sal = some(select max(sal) from emp group by deptno);
-------------------------------------------------------------------------------------------------------------
-- 07.SubQuery.pdf 12������ ��������
--1. EMP ���̺��� ename�� SCOTT�� �����Ϳ� ���� �μ�(deptno)���� �ٹ��ϴ� ����� �̸�(ename)�� �μ� ��ȣ(deptno)�� ����ϴ� SQL ���� �ۼ��� ���ÿ�.
select ename, deptno from emp where deptno = (select deptno from emp where ename = 'SCOTT');

--2. EMP ���̺��� ename�� SCOTT�� �����Ϳ� ������ ����(JOB)�� ���� ����� ��� �÷��� ����ϴ� SQL ���� �ۼ��� ���ÿ�.
select * from emp where job = (select job from emp where ename = 'SCOTT');

--3. EMP ���̺��� ename�� SCOTT�� �������� �޿�(SAL)�� �����ϰų� �� ���� �޴� �����(ename)�� �޿�(sal)�� ����Ͻÿ�.
select ename, sal from emp where sal >= (select sal from emp where ename = 'SCOTT') ;

--4. EMP ���̺��� DEPT ���̺��� LOC�� DALLAS�� ����� �̸�(ename), �μ� ��ȣ(deptno)�� ����Ͻÿ�.
select ename, deptno from emp where deptno = (select deptno from dept where loc = 'DALLAS');
select ename, e.deptno from emp e, dept d where e.deptno = d.deptno and loc = 'DALLAS';

--5. EMP ���̺��� DEPT ���̺��� dname�� SALES(������)�� �μ����� �ٹ��ϴ� ����� �̸�(ename)�� �޿�(sal)�� ����Ͻÿ�.
select ename, sal from emp where deptno = (select deptno from dept where dname = 'SALES');
SELECT ename, sal from emp e, dept d where e.deptno = d.deptno and dname = 'SALES';

--6. EMP ���̺��� ���ӻ��(mgr)�� �̸��� KING�� ����� �̸�(ename)�� �޿�(sal)�� ����Ͻÿ�. 
select ename, sal from emp where mgr = (select empno from emp where ename = 'KING');
select e1.ename, e1.sal from emp e1, emp e2 where e1.mgr = e2.empno and e2.ename = 'KING'; 

-------------------------------------------------------------------------------------------------------------
select deptno, min(sal) from emp group by deptno;
-- !!! WHERE���Ӹ� �ƴ϶� HAVING������ �������� ��� ����, ������ ORDER BY ������ ���������� ����� �� ����. !!!
select deptno, min(sal) from emp group by deptno 
having min(sal) > (select min(sal) from emp where deptno = 20);

--select ename, sal from emp where sal = (select min(sal) from emp group by deptno); -- ���� �������̱� ������ ���� �߻�

-------------------------------------------------------------------------------------------------------------
--1. �μ����� �Ի����� ���� ���� ����� �̸��� �Ի���
--2. �������� ���� �޿��� ���� �޴� ����� �̸��� �޿�
--3. �μ����� �޿��� ���� ���� ����� �̸�, ����, �޿�, �μ���
--4. �������� �Ի簡 ���� ���� ����� �̸�, ����, �Ի���, �޿�, �޿����, �μ���

--1. �μ����� �Ի����� ���� ���� ����� �̸��� �Ի���
select ename, hiredate from emp where hiredate in (select min(hiredate) from emp group by deptno);

--2. �������� ���� �޿��� ���� �޴� ����� �̸��� �޿�
select ename, job, sal from emp where sal in (select max(sal) from emp group by job);

--3. �μ����� �޿��� ���� ���� ����� �̸�, ����, �޿�, �μ���
select ename, job, sal, dname from emp e, dept d where e.deptno = d.deptno and 
sal in (select min(sal) from emp group by deptno);

----4. �������� �Ի簡 ���� ���� ����� �̸�, ����, �Ի���, �޿�, �޿����, �μ��� (job�� hiredate�� ���)
select ename, job, hiredate, sal, grade, dname from emp e, dept d, salgrade where e.deptno = d.deptno
and e.sal between losal and hisal and (job, hiredate) in (select job, min(hiredate) from emp group by job);

-- in ��ſ� any, some���� �ص� �ȴ�
-------------------------------------------------------------------------------------------------------------

select ename, sal from emp where sal > (select min(sal) from emp where job = 'SALESMAN')
and job != 'SALESMAN';


select deptno, round(avg(sal)) from emp group by deptno order by deptno;

-- All
-- deptno avg(sal)
--10	2917
--20	2175
--30	1567

--1. ��� �μ��� ��ձ޿����� ���� �޴� ����� �̸��� �޿� -> 2917���� ���� �޴� ���
select ename, sal from emp where sal > all(select avg(sal) from emp group by deptno); -- 2917���� ���� �޴� ���
--2. ��� �μ��� ��պ��ٵ� �޿��� ���� �޴� ����� �̸��� �޿� -> 1567���� ���� �޴� ���
select ename, sal from emp where sal > any(select avg(sal) from emp group by deptno); -- 1567���� ���� ���

-- ���� �ڵ� ���� -> �����ϴ� �ڵ� (�׷��Լ� ��ø, ����Ŭ�� ���������� mysql������ �� ��)
select ename, sal from emp where sal > (select max(avg(sal)) from emp group by deptno); -- 2917���� ���� �޴� ���
select ename, sal from emp where sal > (select min(avg(sal)) from emp group by deptno); -- 2917���� ���� �޴� ���

-- �� ��
select empno, sal, deptno from emp where (sal, deptno) in (select sal, deptno from emp where deptno = 30 
and comm is not null);

-- ������ ��
--select empno, sal, deptno from emp where sal in (select sal from emp where deptno = 30 
--and comm is not null) and deptno in (select deptno from emp where deptno = 30 and comm is not null);

-- ������ ���� �Ͱ� ������ ���� ���� ����� �ٸ� (����) -> ���� ���� �����ϱ� 
select empno, job, deptno from emp where (job, deptno) in (select job, deptno from emp where empno in (7369, 7499));
s
select empno, job, deptno from emp where job in (select job from emp where empno in (7369, 7499))
and deptno in (select deptno from emp where empno in (7369, 7499));

---------------
select empno, job, deptno from emp where empno in (7369, 7499);

--!! ���� ���� !!
--1. parewise �� : �ΰ� �÷� �̻� ���� ��ġ
--2. nonparewise ��: �ΰ� �÷� ���� ���� ��ġ

-------------------------------------------------------------------------------------------------------------
--07.SubQuery.pdf 30������ ��������
-- emp ���̺��� �μ����� ���� �޿��� ���� �޴� ����� ��� ��ȣ(empno), ����̸�(ename), �޿�(sal), �μ���ȣ(deptno)�� ����Ͻÿ�.(IN ������ �̿�)
select empno, ename, sal, deptno from emp where sal in (select max(sal) from emp group by deptno);
select empno, ename, sal, deptno from emp where (deptno, sal) in (select deptno, max(sal) from emp group by deptno); -- ����

-- emp ���̺��� ����(JOB)�� MANAGER�� ����� ���� �μ��� �μ� ��ȣ(deptno)�� �μ���(dname)�� ����(loc)�� ����Ͻÿ�.
select e.deptno, dname, loc from emp e, dept d where e.deptno = d.deptno and job = 'MANAGER';
select deptno, dname, loc from dept where deptno in (select deptno from emp where job='MANAGER') order by deptno;

