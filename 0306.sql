-- *�� ��� Į��
select * from emp;
-- ���ڴ� ���� ����ǥ(')�� ���Ѵ�, ��ҹ��� ������
select ename,job,sal from emp where job = "ANALYST";

select * from emp where deptno = 10 and job = 'MANAGER';
select * from emp where deptno = 10 or job = 'MANAGER';

-- '�ƴϴ�'�� ��ȣ
select * from emp where job != 'MANAGER';
select * from emp where job ^= 'MANAGER';
select * from emp where job <> 'MANAGER';
select * from emp where not job = 'MANAGER';
-------------------------------------------------------------------------
-- emp table ���� 
-- scott�� ����� �� �ִ� table ��ȸ 
-- �޿��� 2000�̻��� ���� 
-- �޿��� 2000�̻��̸鼭 ������ MANAGER�� ���
-- �޿��� 1500�̸��̰ų� ������ ANALYST�� ��� 
-- 10���ΰ� �ƴ� ����� �̸�, ����, �μ��ڵ� 
-- ������ MANAGER�̰ų� SALESMAN�� ����� �̸�,����,�μ��ڵ�
-- ������ SALESMAN�� �ƴϰų� �޿��� 2000�̻��� ����� �̸�,����,�޿� 
-- ���ʽ��� 300�� ����� �̸�, ����, �޿�, ���ʽ�, �μ��ڵ�, �Ի���
-- 82/01/01 ���Ŀ� �Ի��� ����� ���, �̸�, ����, �Ի��� ,�μ��ڵ�

-- emp table ����
desc emp; 

--  scott�� ����� �� �ִ� table ��ȸ
select * from tab;

-- �޿��� 2000�̻��� ����
select * from emp where sal >= 2000;

-- �޿��� 2000�̻��̸鼭 ������ MANAGER�� ���
select * from emp where sal >= 2000 and job = 'MANAGER';

-- �޿��� 1500�̸��̰ų� ������ ANALYST�� ���
select * from emp where sal < 1500 and job = 'ANALYST';

-- 10���ΰ� �ƴ� ����� �̸�, ����, �μ��ڵ�
select ename, job, deptno from emp where deptno != 10;

-- ������ MANAGER�̰ų� SALESMAN�� ����� �̸�,����,�μ��ڵ�
select ename, job, deptno from emp where job = 'MANAGER' or job = 'SALESMAN';

--  ������ SALESMAN�� �ƴϰų� �޿��� 2000�̻��� ����� �̸�,����,�޿�
select ename, job, sal from emp where job != 'SALESMAN' or sal >= 2000;

-- ���ʽ��� 300�� ����� �̸�, ����, �޿�, ���ʽ�, �μ��ڵ�, �Ի���
select ename, job, sal, comm, deptno, hiredate from emp where comm = 300;

-- 82/01/01 ���Ŀ� �Ի��� ����� ���, �̸�, ����, �Ի��� ,�μ��ڵ�
select empno, ename, job, hiredate, deptno from emp where hiredate >= '82/01/01';
-----------------------------------------------------------------------------------------

select * from emp;
select ename, sal, sal + 1000, sal * 2 from emp; -- �� ���� �͵� ����
-- java���� null�� ���� ���ٴ� ���̴�. ���� == ���� �����ϴ�.
-- !!! DB������ null�� �� �� ���ٴ� ���̴�. ����� �� ����. ������ �� ����. �� = ���� ���� �� ���� is �Ǵ� is not���� ���Ѵ�. !!!
select ename, job, sal, comm from emp where comm = null; -- ���̺��� �� ������ ���� �߰�
select ename, job, sal, comm from emp where comm is null; 
select ename, job, sal, comm from emp where comm != null; 
select ename, job, sal, comm from emp where comm is not null; 

-------------------------------------------------------------------------------------------
-- comm�� null�� ����� ���, �̸�, �޿�, COMM
-- comm�� null �ƴ� ����� ���, �̸�, �޿�, comm, �޿� + comm
-- ������ MANAGER�̰ų� comm�� null�� ����� �̸�, ����, �޿�, comm
-- comm�� null�� �ƴ� ��� �߿��� �μ��ڵ尡 30���� ����� �̸�, ����, �޿�
-- �Ի����� 82���� ����� �̸�, ����, �Ի���


-- comm�� null�� ����� ���, �̸�, �޿�, COMM
select empno, ename, sal, comm from emp where comm is null;

-- comm�� null �ƴ� ����� ���, �̸�, �޿�, comm, �޿� + comm
select empno, ename, sal, comm, sal + comm from emp where comm is not null;

-- ������ MANAGER�̰ų� comm�� null�� ����� �̸�, ����, �޿�, comm
select ename, job, sal, comm from emp where job = 'MANAGER' or comm is null;

-- comm�� null�� �ƴ� ��� �߿��� �μ��ڵ尡 30���� ����� �̸�, ����, �޿�
select ename, job, sal from emp where comm is not null and deptno = 30;

-- �Ի����� 82���� ����� �̸�, ����, �Ի���
select ename, job, hiredate from emp where hiredate >= '82/01/01' and hiredate <= '82/12/31';

-------------------------------------------------------------------------------------------

-- null ��� ������ ó���� ���ΰ�?
select ename, sal, comm, sal + comm from emp;
-- nvl, nvl2�� ����Ŭ�� �ȴ�.
-- nvl (null value logic) : ���� null�̸� ��� ó���� ���ΰ�? - ����Ŭ�� �ش�ȴ�. �ٸ� ���������� �� ��.
select ename, sal, comm, sal + nvl(comm, 0), sal + nvl(comm, 100) from emp;

-- nvl2      nvl(comm, 0) -> comm�� null�̸� 0����   
--           nvl2(comm, comm+sal, sal) -> comm�� ���� ������ (null�� �ƴϸ�) sal + comm�� �ϰ�, null�̸� sal�� ���
--           coalesce(sal+comm, sal) -> coalesce �տ������� null�� �ƴ� ������ ���� �� ���� -> ����Ŭ�Ӹ� �ƴ϶� �ٸ� �������� ����
select ename, sal, comm, sal + nvl(comm, 0), nvl2(comm, comm+sal, sal), coalesce(sal+comm, sal) from emp;

-- ��Ī -> as, ū����ǥ�� as�� ���� ����, �ܾ �� ĭ ������ ���� ū����ǥ�� ���ξ� �Ѵ�.
select ename as "�̸�" , sal "�޿�", comm, sal + nvl(comm, 0) �޿��ͺ��ʽ���, 
nvl2(comm, comm+sal, sal) "�޿��� ���ʽ���", coalesce(sal+comm, sal) �հ� from emp;

-------------------------------------------------------------------------------------------
-- �̸�, �޿�, ���ʽ� ,�޿� + ���ʽ� (��, ���ʽ��� null�̸� 0����) nvl, nvl2, coalesce ����Ͽ� ó��
-- �̸�, �޿�, ���ʽ�, ���� (������ (�޿� + ���ʽ�) *12 ��, ���ʽ��� null�̸� 0���� 
-- 81�⵵�� �Ի��� ��� �߿��� ������ MANAGER�� ���
-- comm�� null�� ����� �޿�+comm ��Ī���� �޿��� ���ʽ������� ǥ��
-- comm�� null�� �ƴϰ� �޿��� 1500 �̻��� ����� �̸�, �޿�, ���ʽ�, ���� (������ (�޿�+���ʽ�)*12, �� ���ʽ��� null�̸� 0����)
-- �μ��ڵ尡 10���̰ų� ������ MANAGER�� ����� �̸�, �޿�, �μ��ڵ� / �÷����� �ѱ۷� ���
-- �޿��� 1500 ���ϰų� ������ CLERK�� ����� �̸�, �޿�, ���ʽ�, �޿� + ���ʽ� (���ʽ��� null�̸� 0) �÷����� �Ǳ޿��� ǥ��

-- �̸�, �޿�, ���ʽ� ,�޿� + ���ʽ� (��, ���ʽ��� null�̸� 0����) nvl, nvl2, coalesce ����Ͽ� ó��
select ename, sal, comm ,sal+nvl(comm, 0), nvl2(comm, sal+comm, sal), coalesce(sal+comm, sal) from emp;

-- �̸�, �޿�, ���ʽ�, ���� (������ (�޿� + ���ʽ�) *12 ��, ���ʽ��� null�̸� 0���� 
select ename, sal, comm, (sal+nvl(comm, 0)) * 12 ���� from emp;

-- 81�⵵�� �Ի��� ��� �߿��� ������ MANAGER�� ���
select * from emp where hiredate >= '81/01/01' and hiredate <= '81/12/31' and job='MANAGER';

-- comm�� null�� ����� �޿�+comm ��Ī���� �޿��� ���ʽ������� ǥ��
select ename, sal + nvl(comm, 0) "�޿��� ���ʽ���" from emp where comm is null;

-- comm�� null�� �ƴϰ� �޿��� 1500 �̻��� ����� �̸�, �޿�, ���ʽ�, ���� (������ (�޿�+���ʽ�)*12, �� ���ʽ��� null�̸� 0����)
select ename, sal, comm, (sal+nvl(comm,0))*12 from emp where comm is not null and sal >= 1500;

-- �μ��ڵ尡 10���̰ų� ������ MANAGER�� ����� �̸�, �޿�, �μ��ڵ� / �÷����� �ѱ۷� ���
select ename as "�̸�", sal �޿�, deptno �μ��ڵ� from emp where deptno = 10 or job = 'MANAGER';

-- �޿��� 1500 ���ϰų� ������ CLERK�� ����� �̸�, �޿�, ���ʽ�, �޿� + ���ʽ� (���ʽ��� null�̸� 0) �÷����� �Ǳ޿��� ǥ��
select ename, sal, comm, sal+nvl(comm,0) �Ǳ޿� from emp where sal <= 1500 or job = 'CLERK';

-------------------------------------------------------------------------------------------
-- oracle���� concat�� �ΰ� �׸� ���� 
select concat(ename,sal) from emp;
select ename||'('||sal||')' from emp;
select ename||'�� �޿��� '|| sal||'�̴�' from emp;
-- EMP ���̺��� ename�� salary�� ��KING: 1 Year salary = 60000�� �������� ���
select ename || ': 1�� ���� = ' || sal * 12 Monthly from emp;

select job from emp;
-- distinct�� �ߺ��� �ִ� ��� �� ���� ���
select distinct job from emp;

-------------------------------------------------------------------------------------------
--1. EMP ���̺��� ���� ��ȸ
--2. EMP ���̺��� ��� ������ ��ȸ
--3. EMP ���̺��� �ߺ����� �ʴ� deptno�� ���
--4. EMP ���̺��� ename�� job�� �����Ͽ� ���
--5. DEPT ���̺��� deptno�� loc�� �����Ͽ� ���
--6. EMP ���̺��� job�� sal�� �����Ͽ� ���
--7. ������̺��� �������� ����(�޿� * 12) ������������ ����Ͽ� �����, �޿�, ���� ���
--8. xx�� ������ xxx�̰� �޿��� xxx�����Դϴ�.

--1. EMP ���̺��� ���� ��ȸ
desc emp;

--2. EMP ���̺��� ��� ������ ��ȸ
select * from emp;

--3. EMP ���̺��� �ߺ����� �ʴ� deptno�� ���
select distinct deptno from emp;

--4. EMP ���̺��� ename�� job�� �����Ͽ� ���
select ename ||'�� ������ '|| job || '�Դϴ�' from emp;
select ename||'('||job||')' from emp;

--5. DEPT ���̺��� deptno�� loc�� �����Ͽ� ���
select '�μ��ڵ� ' ||deptno ||'�� ��ġ�� '|| loc || '�Դϴ�' from dept;
select deptno||'('||loc||')' from dept;

--6. EMP ���̺��� job�� sal�� �����Ͽ� ���
select  job ||'�� �޿��� '|| sal || '�Դϴ�' from emp;
select job||'('||sal||')' from emp;

--7. ������̺��� �������� ����(�޿� * 12) ������������ ����Ͽ� �����, �޿�, ���� ���
select empno, sal, sal*12 "����" from emp;

--8. xx�� ������ xxx�̰� �޿��� xxx�����Դϴ�.
select ename||'�� ������ '|| job ||'�̰� �޿��� ' || sal ||'�����Դϴ�' from emp; 
