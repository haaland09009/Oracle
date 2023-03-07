select ename, sal from emp where sal >= 2000 and sal <= 3000;
-- �÷��� between A and B : A���� ũ�ų� ���� B���� �۰ų� ����
select ename, sal from emp where sal between 2000 and 3000;
--select ename, sal from emp where sal between 3000 and 2000; ���� ���� �տ� �����.

-- =�� ����
select ename, sal from emp where sal not between 2000 and 3000;
select ename, sal from emp where sal < 2000 or sal > 3000;

-- �̸��� K�� S�� �����ϴ� ��� : S���� SC�� ũ��.  S < SC  �տ� �� ���ھ� ���ؼ� ������ ���� ����
select ename from emp where ename between 'K' and 'SZZ';

-- 10�� �Ǵ� 20���� �ٹ��ϴ� ���
select ename, deptno from emp where deptno = 10 or deptno = 20;
select ename, deptno from emp where deptno in (10, 20); -- ��ȣ �ȿ� ���� ������ ���� ���� ���� �ۼ��� �� �ִ�.
-- 10�� �Ǵ� 20���� �ٹ����� �ʴ� ���
select ename, deptno from emp where deptno not in (10, 20); 
----------------------------------------------------------------------------------------------------------------------
--1. �޿��� 1500 ~ 3000�� ����� ���, �̸�, �Ի���, �޿�
--2. �޿��� 2000 ~ 3500�̰� comm�� null�� �ƴ� ��� �̸�, �޿�, �Ի���, comm
--3. �޿��� 2000 ~ 4000 ���̰� �ƴϰų� comm�� null�� ����� �̸� �޿�, comm
--4. ������ SALESMAN�̰ų� CLERK�̰ų� ANALYST�� ����� ���, �̸�, ����
--5. �μ��� 10�̰ų� 30���� ����� ���, �̸�, �μ��ڵ�
--6. ������ MANAGER�� �ƴϰ� CLERK�� �ƴ� ����� ���, �̸�, ����
--7. 81�⵵�� �Ի��� ����� ���, �̸�, �Ի���
--8. �̸��� D�� T������ ���ڷ� �����ϴ� ����� �̸�
--9. �޿��� 1000~3000�� ����� �̸�, �޿�, Ŀ�̼�, ����(=(�޿�+comm)*12 comm�� null�̸� 0) ��Ī
--10. �̸�(����)�� �޿��� xxx�̰� ������ xxx�̴�(���� ����� 9�� ����)

--1. �޿��� 1500 ~ 3000�� ����� ���, �̸�, �Ի���, �޿�
select empno, ename, hiredate, sal from emp where sal between 1500 and 3000;

--2. �޿��� 2000 ~ 2500�̰� comm�� null�� �ƴ� ��� �̸�, �޿�, �Ի���, comm
select ename, sal, hiredate, comm from emp where sal between 2000 and 3500 and comm is not null;

--3. �޿��� 2000 ~ 4000 ���̰� �ƴϰų� comm�� null�� ����� �̸�, �޿�, comm
select ename, sal, comm from emp where sal not between 2000 and 4000 or comm is null;

--4. ������ SALESMAN�̰ų� CLERK�̰ų� ANALYST�� ����� ���, �̸�, ����
select empno, ename, job from emp where job in ('SALESMAN','CLERK','ANALYST');

--5. �μ��� 10�̰ų� 30���� ����� ���, �̸�, �μ��ڵ�
select empno, ename, deptno from emp where deptno in (10, 30);

--6. ������ MANAGER�� �ƴϰ� CLERK�� �ƴ� ����� ���, �̸�, ����
select empno, ename, job from emp where job != 'MANAGER' and job != 'CLERK';
select empno, ename, job from emp where job not in ('MANAGER','CLERK');

--7. 81�⵵�� �Ի��� ����� ���, �̸�, �Ի���
select empno, ename, hiredate from emp where hiredate between '81/01/01' and '81/12/31';

--8. �̸��� D�� T������ ���ڷ� �����ϴ� ����� �̸�
select ename from emp where ename between 'D' and 'TZZ';

--9. �޿��� 1000~3000�� ����� �̸�, �޿�, Ŀ�̼�, ����(=(�޿�+comm)*12 comm�� null�̸� 0) ��Ī
select ename, sal, comm, (sal+nvl(comm,0))*12 ���� from emp where sal between 1000 and 3000;

--10. �̸�(����)�� �޿��� xxx�̰� ������ xxx�̴�(���� ����� 9�� ����)
select ename||'('||job||')'||'��  �޿��� ' || sal || '�̰� ������ ' || (sal+nvl(comm,0))*12 || '�̴�' from emp;
----------------------------------------------------------------------------------------------------------------------

-- 81�� �����ϰ� �������� ���(%)
select empno, ename, hiredate from emp where hiredate like '81%';

select ename from emp where ename like 'S%';

-- %(���) T % (���) ���� �� ���� ����
select ename from emp where ename like '%T%';
-- R�� ������ ���
select ename from emp where ename like '%R';

-- �����(_)�� �ƹ� ���ڳ� ��������� ���ڼ� �Ѱ�
-- A�� �ѱ��� �� �� ��° ���ڰ� A, A �ڿ��� ��� (���� �� ���� ���� �ƹ� ���� ����)
select ename from emp where ename like '_A%';
select ename from emp where ename like '__R%';

select * from emp;
-- ����� 7369�� ����� �̸��� SMI%TH�� ����
update emp set ename='SMI%TH' where empno =7369;
-- %�� ���Ե� �̸� \�ڿ� �ִ� �� ���ڷ� �ν�
-- %�� _�� ���Ե� ���ڸ� �˻��� ���� escape ���ڸ� Ȱ��
-- % ��η� ���� , ���� �ѱ��� + % ����ϸ� %�� ���ڷ� �ν�, escape�� ���� �˻��� ���� ���� �ѱ��ڴ� ����
select ename from emp where ename like '%\%%' escape '\'; -- �ַ� ���
select ename from emp where ename like '%K%%' escape 'K';

select ename from emp where ename not like '%\%%' escape '\';
----------------------------------------------------------------------------------------------------------------------
--1. �̸��� R�� ���Ե� ����� �̸�
--2. �̸��� S�� ������ ����� �̸�
--3. 81�⵵ �Ի��ϰ� ������ MANAGER�� ����� �̸��� ����
--4. �̸� �ι�° ���ڰ� L�� ����� �̸�
--5. �̸� ������ �ι� ° ���ڰ� R�� ����� �̸�
--6. %�� �̸��� ���Ե� ����� �̸�
--7. �̸��� TT�� ���ӿ� �پ� �ִ� ����� �̸�
--8. �̸��� L�� �ΰ��� ����� �̸�
--9. �μ��ڵ尡 3���� �����ϰų� �޿��� 2500 ~ 3000�� ����� �̸�, �޿�, �μ��ڵ�
--10. �̸��� ������ 3��° ���ڰ� N�� ����� �̸�
--11. �̸��� S�� �������� �ʴ� ����� �̸�


--1. �̸��� R�� ���Ե� ����� �̸�
select ename from emp where ename like '%R%';

--2. �̸��� S�� ������ ����� �̸�
select ename from emp where ename like '%S';

--3. 81�⵵ �Ի��ϰ� ������ MANAGER�� ����� �̸��� ����
select ename, job from emp where hiredate like '81%' and job = 'MANAGER';

--4. �̸� �ι�° ���ڰ� L�� ����� �̸�
select ename from emp where ename like '_L%';

--5. �̸� ������ �ι� ° ���ڰ� R�� ����� �̸�
select ename from emp where ename like '%R_';

--6. %�� �̸��� ���Ե� ����� �̸�
select ename from emp where ename like '%\%%' escape '\';

--7. �̸��� TT�� ���ӿ� �پ� �ִ� ����� �̸�
select ename from emp where ename like '%TT%';

--8. �̸��� L�� �ΰ��� ����� �̸�
select ename from emp where ename like '%L%L%';

--9. �μ��ڵ尡 3���� �����ϰų� �޿��� 2500 ~ 3000�� ����� �̸�, �޿�, �μ��ڵ�
select ename, sal, deptno from emp where deptno like '3%' or sal between 2500 and 3000;

--10. �̸��� ������ 3��° ���ڰ� N�� ����� �̸�
select ename from emp where ename like '%N__';

--11. �̸��� S�� �������� �ʴ� ����� �̸�
select ename from emp where ename not like 'S%';

----------------------------------------------------------------------------------------------------------------------
--!!! ���ǻ��� !!!
-- ���� ��� ������ ���캸��, and ������ �켱������ �����̹Ƿ� ù��° �ڵ��  job ='MANAGER' and sal >= 2000 ���� �����
-- and�� �켱���� ���� (not > and > or)

-- and�� ���� ����, �Ŵ����̸鼭 �޿��� 2000�̻��̰ų� salesman�� ���� ã��
select empno, ename, job, sal from emp where job='SALESMAN' or job ='MANAGER' and sal >= 2000;
select empno, ename, job, sal from emp where job='SALESMAN' or (job ='MANAGER' and sal >= 2000);
-- ������ salesman�̰ų� manager �߿��� �޿��� 2000�̻��� ��
select empno, ename, job, sal from emp where (job='SALESMAN' or job ='MANAGER') and sal >= 2000;
------------------------------------------------------------------------------------------------------------------------

select * from emp;
select * from emp order by sal desc;

-- select �÷�,....from ���̺�� where ���� order by �÷���(����, ��, ��Ī); ���� ��(asc ����), ū ����(desc)
select ename �̸�, sal from emp order by sal;
select ename �̸�, sal from emp order by �̸� desc;
select ename �̸�, sal from emp order by �̸� desc;

select ename �̸�, sal from emp order by 2 desc;
select ename, sal, comm, sal+nvl(comm,0) from emp order by sal+nvl(comm,0);

-- �μ��ڵ� ���� ������ ����, �μ��ڵ尡 ������ �޿��� ���� ������ ����
select ename, sal, deptno from emp order by deptno, sal;
select ename, sal, deptno from emp order by deptno, sal desc;
select ename, sal, deptno from emp order by deptno desc, sal;
select ename, sal, deptno from emp order by deptno desc, sal desc;

--! ���ǻ��� ! : oracle���� null�� ū ���� �ν��Ѵ�.
select ename, sal, comm from emp order by comm;
select ename, sal, comm from emp order by comm desc;
------------------------------------------------------------------------------------------------------------------------
--1. ���, �̸�, �޿� �޿� ū ������
--2. �̸�, ����, �޿�, �Ի��� ������(���� ��), �޿� ���� ��
--3. �̸�, �μ��ڵ�, ����, �Ի���, �޿�  [�μ���, ������, �޿� ū��]
--4. �̸�, �μ��ڵ�, ����, �Ի���, �޿�  [81�⿡ �Ի��� ��� ����, �Ի��� ��
--5. �̸�, �޿�, comm, ����((�޿�+comm_*12, comm�� null�̸� 0) ���� ū ��
--6. �̸�, �޿�, comm [comm ū ��]
--7. �̸�, �޿�, �μ��ڵ�, �Ի��� �޿��� 1500 ~ 3500 �����ε� �Ի��� ��


--1. ���, �̸�, �޿� �޿� ū ������
select empno, ename, sal from emp order by sal desc; -- 3 desc�� ����

--2. �̸�, ����, �޿�, �Ի��� ������(���� ��), �޿� ���� ��
select ename, job, sal, hiredate from emp order by job, sal;

--3. �̸�, �μ��ڵ�, ����, �Ի���, �޿�  [�μ���, ������, �޿� ū��]
select ename, deptno, job, hiredate, sal from emp order by deptno, job, sal desc;
select ename, deptno, job, hiredate, sal from emp order by 2,3,5 desc;

--4. �̸�, �μ��ڵ�, ����, �Ի���, �޿�  [81�⿡ �Ի��� ��� ����, �Ի��� ��
select ename, deptno, job, hiredate, sal from emp where hiredate like '81%' order by job, hiredate; -- order by 3,4�� ����

--5. �̸�, �޿�, comm, ����((�޿�+comm_*12, comm�� null�̸� 0) ���� ū ��
select ename, sal, comm, (sal+nvl(comm,0)) * 12 ���� from emp order by ���� desc;

--6. �̸�, �޿�, comm [comm ū ��]
select ename, sal, comm from emp order by comm desc;

--7. �̸�, �޿�, �μ��ڵ�, �Ի��� �޿��� 1500 ~ 3500 �����ε� �Ի��� ��
select ename, sal, deptno, hiredate from emp where sal between 1500 and 3500 order by hiredate;

------------------------------------------------------------------------------------------------------------------------
--1. EMP ���̺��� sal�� 3000�̻��� ����� empno, ename, job, sal�� ����ϴ� SELECT ������ �ۼ�
--2. EMP ���̺��� empno�� 7788�� ����� ename�� deptno�� ����ϴ� SELECT ����
--3. EMP ���̺��� hiredate�� 1981�� 2�� 20�� 1981�� 5�� 1�� ���̿� �Ի��� �����
--ename,job,hiredate�� ����ϴ� SELECT ������ �ۼ�(�� hiredate ������ ���)
--4. EMP ���̺��� deptno�� 10,20�� ����� ��� ������ ����ϴ� SELECT ������ �ۼ�(�� ename������ ����)
--5. EMP ���̺��� sal�� 1500�̻��̰� deptno�� 10,30�� ����� ename�� sal�� ����ϴ� SELECT ������ �ۼ�
--   (�� HEADING�� employee�� Monthly Salary�� ���)
--6. EMP ���̺��� hiredate�� 1982���� ����� ��� ������ ����ϴ� SELECT ���� �ۼ�



--1. EMP ���̺��� sal�� 3000�̻��� ����� empno, ename, job, sal�� ����ϴ� SELECT ������ �ۼ�
select empno, ename, job, sal from emp where sal >= 3000;

--2. EMP ���̺��� empno�� 7788�� ����� ename�� deptno�� ����ϴ� SELECT ����
select ename, deptno from emp where empno = 7788;

--3. EMP ���̺��� hiredate�� 1981�� 2�� 20�� 1981�� 5�� 1�� ���̿� �Ի��� �����
--ename,job,hiredate�� ����ϴ� SELECT ������ �ۼ�(�� hiredate ������ ���)
select ename, job, hiredate from emp where hiredate between '81/02/20' and '81/05/01' order by hiredate;

--4. EMP ���̺��� deptno�� 10,20�� ����� ��� ������ ����ϴ� SELECT ������ �ۼ�(�� ename������ ����)
select * from emp where deptno in (10,20) order by ename;

--5. EMP ���̺��� sal�� 1500�̻��̰� deptno�� 10,30�� ����� ename�� sal�� ����ϴ� SELECT ������ �ۼ�
--   (�� HEADING�� employee�� Monthly Salary�� ���)
select ename as "employee", sal as "Monthly Salary" from emp where sal >= 1500 and deptno in (10,30);
select ename employee, sal "Monthly Salary" from emp where sal >= 1500 and deptno in (10,30);

--6. EMP ���̺��� hiredate�� 1982���� ����� ��� ������ ����ϴ� SELECT ���� �ۼ�
select * from emp where hiredate like '82%';

------------------------------------------------------------------------------------------------------------------------
--1. EMP ���̺��� COMM�� NULL�� �ƴ� ����� ��� ������ ����ϴ� SELECT ���� �ۼ�
--2. EMP ���̺��� comm�� sal���� 10%���� ��� ����� ���Ͽ� ename,sal, ���ʽ��� ����ϴ� SELECT ���� �ۼ�
--3. EMP ���̺��� job�� CLERK�̰ų� ANALYST�̰� sal�� 1000,3000,5000�� �ƴ� ��� ����� ������ ����ϴ� SELECT ���� �ۼ�
--4. EMP ���̺��� ename�� L�� �� �ڰ� �ְ� deptno�� 30�̰ų� �Ǵ� mgr��7782�� ����� ��� ������ ����ϴ� SELECT ���� �ۼ��Ͽ���.


--1. EMP ���̺��� COMM�� NULL�� �ƴ� ����� ��� ������ ����ϴ� SELECT ���� �ۼ�
select * from emp where comm is not null;

--2. EMP ���̺��� comm�� sal���� 10% ���� ��� ����� ���Ͽ� ename,sal, ���ʽ��� ����ϴ� SELECT ���� �ۼ�
select ename, sal, comm from emp where comm > sal * 1.1;

--3. EMP ���̺��� job�� CLERK�̰ų� ANALYST�̰� sal�� 1000,3000,5000�� �ƴ� ��� ����� ������ ����ϴ� SELECT ���� �ۼ�
select * from emp where job in ('CLERK','ANALYST') and sal not in (1000,3000,5000);

--4. EMP ���̺��� ename�� L�� �� �ڰ� �ְ� deptno�� 30�̰ų� �Ǵ� mgr�� 7782�� ����� ��� ������ ����ϴ� SELECT ���� �ۼ��Ͽ���.
select * from emp where ename like '%L%L%' and (deptno = 30 or mgr = 7782);

------------------------------------------------------------------------------------------------------------------------
--1. ��� ���̺��� �Ի����� 81�⵵�� ������ ���,�����, �Ի���, ����, �޿�
--2. ��� ���̺��� �Ի����� 81���̰� ������ 'SALESMAN'�� �ƴ� ������ ���, �����, �Ի���, ����, �޿�.
--3. ��� ���̺��� ���, �����, �Ի���, ����, �޿��� �޿��� ���� ������ �����ϰ�, �޿��� ������ �Ի����� ���� ������� ����
--4. ��� ���̺��� ������� �� ��° ���ĺ��� 'N'�� ����� ���, ������� �˻�
--5. ��� ���̺��� ����(SAL*12)�� 35000 �̻��� ���, �����, ������ �˻�



--1. ��� ���̺��� �Ի����� 81�⵵�� ������ ���,�����, �Ի���, ����, �޿�
select empno, ename, hiredate, job, sal from emp where hiredate like '81%';

--2. ��� ���̺��� �Ի����� 81���̰� ������ 'SALESMAN'�� �ƴ� ������ ���, �����, �Ի���, ����, �޿�
select empno, ename, hiredate, job, sal from emp where hiredate like '81%' and job != 'SALESMAN';

--3. ��� ���̺��� ���, �����, �Ի���, ����, �޿��� �޿��� ���� ������ �����ϰ�, �޿��� ������ �Ի����� ���� ������� ����
select empno, ename, hiredate, job, sal from emp order by sal desc, hiredate;

--4. ��� ���̺��� ������� �� ��° ���ĺ��� 'N'�� ����� ���, ������� �˻�
select empno, ename from emp where ename like '__N%';

--5. ��� ���̺��� ����(SAL*12)�� 35000 �̻��� ���, �����, ������ �˻�
-- !!!! ����: where ���忡���� ��Ī�� ������� ���Ѵ�. order by������ ��Ī ��� ���� !!!!
select empno, ename, sal*12 ���� from emp where sal*12 >= 35000; 







