-- �ּ�, * �� ���, emp ���̺��� �����͸� ��� �����ش�.
select * from emp;
select * from salgrade;
-- dept ���̺� ������ ��� ���
select * from dept;
select sum(sal) from emp;
select * from tab;
-- desc ���̺�� : ���̺��� ������ �����ش�.
--   number(2) : ���� �� �ڸ�, varchar2(14): ���� 14�ڸ� [variable character] - ����Ŭ�� varchar2�� ���, char(14): ���� 14�ڸ�
desc dept;
-- not null: �ݵ�� ���� �־�� �Ѵ�.
-- number(7,2) : ���ڰ� 7�ڸ��� �����Ǿ� ������ 2�ڸ��� �Ҽ��� ����
desc emp;
-- select �÷�,... from ���̺��;
select empno, ename, sal from emp;
-- where : table�κ��� �����͸� �����ϴ� ����
select empno, ename, sal from emp where sal >= 2500;
select empno, job, ename, sal from emp where deptno = 20;
-- ���ڸ� ������ ���� ���� ����ǥ('), ���� ��ҹ��� ����
select ename, job, sal from emp where job = 'MANAGER';
-- >, >=, <, <= , ���� = , ���� �ʴ� != , ^=, <>


--1. salgrade ��� ������
--2. scott�� ����� ���̺�
--3. dept ���̺� ����
--4. emp ���̺��� 1) ���, �̸�, ����, �޿� 2) �̸�, ����, �޿�, �μ��ڵ� 20�� �μ��� ��� 3) �̸�,����,�޿�,�μ��ڵ� 10�μ��� �ƴ� ��츸 ���
--                4) �̸�,����,�޿�,�μ��ڵ� ������ ANALYST�� ��츸 ���    5) " �޿��� 2000�̸��� ���
--                  6) �̸�, ����, �Ի��� 82�� 1�� 1�� ���Ŀ� �Ի��� ���
select * from salgrade;
select * from tab;
desc dept;
--desc emp;
select empno, ename, job, sal from emp;
select ename, job, sal, deptno from emp where deptno = 20;
select ename, job, sal, deptno from emp where deptno != 10;
select ename, job, sal, deptno from emp where job = 'ANALYST';
select ename, job, sal, deptno from emp where sal < 2000;
select ename, job,hiredate from emp where hiredate >= '82/01/01';
--desc emp;