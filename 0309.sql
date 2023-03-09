-- deptno 10�� ȸ����, 20�� ������, 30�� ������, ��Ÿ ���
select ename, job, deptno, case deptno when 10 then 'ȸ����' when 20 then '������' when 30 then '������'
 else '���' end �μ��� from emp;
 -- ���� �Ȱ��� ��� ���
select ename, job, deptno, decode(deptno, 10,'ȸ����',20,'������',30,'������','���') �μ��� from emp;
 
 -- ��ø�Լ�
select deptno, dname, rpad(rtrim(dname, 'G'),10,'*') from dept;

select ename, sal, hiredate, extract(year from hiredate), extract(month from hiredate),
extract(day from hiredate) from emp;

-- 2���� �Ի��� ���
select * from emp where extract(month from hiredate) = 02;
select * from emp where to_char(hiredate, 'mm') = 02;
-------------------------------------------------------------------------------------------------------------
--1. ���� ��¥�� ����ϰ� �� ���̺��� Current Date�� ����ϴ� SELECT ������ ����Ͻÿ�.
--2. EMP ���̺��� ���� �޿��� 15%�� ������ �޿��� �����ȣ,�̸�,����,�޿�,������ �޿�(New Salary),������(Increase)��
--����ϴ� SELECT ������ ����Ͻÿ�.
--3. EMP ���̺��� �̸�,�Ի���,�Ի��Ϸκ��� 6���� �� ���ƿ��� ������ ���Ͽ� ����ϴ� SELECT ������ ����Ͻÿ�.
--4. EMP ���̺��� �̸�,�Ի���, �Ի��Ϸκ��� ��������� ����,�޿�, �Ի��Ϻ��� ��������� �޿��� �Ѱ踦 ����ϴ� SELECT ������ ����Ͻÿ�.
--5. EMP ���̺��� ��� ����� �̸��� �޿�(15�ڸ��� ��� ������ ����� ��*���� ��ġ)�� ����ϴ� SELECT ������ ����Ͻÿ�.
--6. EMP ���̺��� ��� ����� ������ �̸�,����,�Ի���,�Ի��� ������ ����ϴ� SELECT ������ ����Ͻÿ�.
--7. EMP ���̺��� �̸��� ���̰� 6�� �̻��� ����� ������ �̸�,�̸��� ���ڼ�,������ ����ϴ� SELECT ������ ����Ͻÿ�.
--8. EMP ���̺��� ��� ����� ������ �̸�,����,�޿�,���ʽ�,�޿�+���ʽ��� ����ϴ� SELECT ������ ����Ͻÿ�


--1. ���� ��¥�� ����ϰ� �� ���̺��� Current Date�� ����ϴ� SELECT ������ ����Ͻÿ�.
select sysdate "Current Date" from dual;

--2. EMP ���̺��� ���� �޿��� 15%�� ������ �޿��� �����ȣ,�̸�,����,�޿�,������ �޿�(New Salary),������(Increase)��
--����ϴ� SELECT ������ ����Ͻÿ�.
select empno, ename, job, sal, sal*1.15 "New Salary", sal*0.15 Increase from emp;

--3. EMP ���̺��� �̸�,�Ի���,�Ի��Ϸκ��� 6���� �� ���ƿ��� ������ ���Ͽ� ����ϴ� SELECT ������ ����Ͻÿ�.
select ename, hiredate, next_day(add_months(hiredate, 6), '��') from emp;

--4. EMP ���̺��� �̸�,�Ի���, �Ի��Ϸκ��� ��������� ����,�޿�, �Ի��Ϻ��� ��������� �޿��� �Ѱ踦 ����ϴ� SELECT ������ ����Ͻÿ�.
select ename, hiredate, round(months_between(sysdate, hiredate)) ����, sal, 
sal * round(months_between(sysdate, hiredate)) �޿��Ѱ� from emp;

--5. EMP ���̺��� ��� ����� �̸��� �޿�(15�ڸ��� ��� ������ ����� ��*���� ��ġ)�� ����ϴ� SELECT ������ ����Ͻÿ�.
select ename, sal, lpad(sal, 15, '#') from emp;

--6. EMP ���̺��� ��� ����� ������ �̸�,����,�Ի���,�Ի��� ������ ����ϴ� SELECT ������ ����Ͻÿ�.
select ename, job, hiredate, to_char(hiredate, 'day') from emp;

--7. EMP ���̺��� �̸��� ���̰� 6�� �̻��� ����� ������ �̸�,�̸��� ���ڼ�,������ ����ϴ� SELECT ������ ����Ͻÿ�.
select ename, length(ename), job from emp where length(ename) >= 6;

--8. EMP ���̺��� ��� ����� ������ �̸�,����,�޿�,���ʽ�,�޿�+���ʽ��� ����ϴ� SELECT ������ ����Ͻÿ�
select ename, job, sal, comm, nvl(sal+comm, 0) from emp;

--1. ��� ���̺��� ������� 2��° ���ں��� 3���� ���ڸ� �����Ͻÿ�.
--2. ��� ���̺��� �Ի����� 12���� ����� ���, �����, �Ի����� �˻��Ͻÿ�.
--3. ���, �̸�, �޿�(10�ڸ� ���ʿ� *)
--4. ���, �̸�, �Ի��� ��4-��-��
--6. ��� ���̺��� �޿��� ���� ���, �̸�, �޿�, ����� �˻��ϴ� SQL������ �ۼ� (case, decode) 
--�޿� ���
--0 ~ 999 E    1000 ~ 1999 D    2000 ~ 2999 C   3000 ~ 3999 B   4000 �̻� A
----7. EMP ���̺��� ������ ����� ��µǵ��� �ۼ��Ͻÿ�.
--Sal�� ���� 3�谡 �ǵ��� ���
--Dream Salary
--------------------------------------------------------------
--KING earns $5,000.00 monthly but wants $15,000.00
--BLAKE earns $2,850.00 monthly but wants $8,550.00
--CLARK earns $2,450.00 monthly but wants $7,350.00

--5. ��� ���̺��� �޿��� ���� ���, �̸�, �޿�, ����� �˻��ϴ� SQL ������ �ۼ��Ͻÿ�. (Hint : CASE �Լ� ���, decode)
--0 ~ 1000 E    1001 ~ 2000 D    2001 ~ 3000 C   3100 ~ 4000 B   4001 ~ 5000 A





--1. ��� ���̺��� ������� 2��° ���ں��� 3���� ���ڸ� �����Ͻÿ�.
select ename, substr(ename,2,3) from emp;

--2. ��� ���̺��� �Ի����� 12���� ����� ���, �����, �Ի����� �˻��Ͻÿ�.
select empno, ename, hiredate from emp where substr(hiredate,4,2) = 12;
select empno, ename, hiredate from emp where to_char(hiredate, 'mm') = 12;

--3. ���, �̸�, �޿�(10�ڸ� ���ʿ� *)
select empno, ename, sal, lpad(sal, 10, '#') from emp;

--4. ���, �̸�, �Ի��� ��4-��-��
select empno, ename, to_char(hiredate, 'yyyy-mm-dd') from emp;

--6. ��� ���̺��� �޿��� ���� ���, �̸�, �޿�, ����� �˻��ϴ� SQL������ �ۼ� (case, decode) 
--�޿� ���
--0 ~ 999 E    1000 ~ 1999 D    2000 ~ 2999 C   3000 ~ 3999 B   4000 �̻� A
select empno, ename, sal, case trunc(sal/1000) when 0 then 'E' when 1 then 'D' when 2 then 'C'
when 3 then 'B' else 'A' end ��� from emp;
-- trunc :�Ҽ��� ���ϸ� ����
select empno, ename, sal, decode(trunc(sal/1000),0,'E',1,'D',2,'C',3,'B','A') ��� from emp;

select empno, ename, sal, case when sal between 0 and 999 then 'E' when sal between 1000 and 1999 then 'D' 
when sal between 2000 and 2999 then 'C' when sal between 3000 and 3999 then 'B' else 'A' end ��� from emp;

----7. EMP ���̺��� ������ ����� ��µǵ��� �ۼ��Ͻÿ�.
--Sal�� ���� 3�谡 �ǵ��� ���
--Dream Salary
--------------------------------------------------------------
--KING earns $5,000.00 monthly but wants $15,000.00
--BLAKE earns $2,850.00 monthly but wants $8,550.00
--CLARK earns $2,450.00 monthly but wants $7,350.00

select ename ||' earns' || to_char(sal, '$9,999.00') || ' monthly but wants ' || to_char(sal*3, '$99,999.00') 
"Dream Salary" from emp;


--5. ��� ���̺��� �޿��� ���� ���, �̸�, �޿�, ����� �˻��ϴ� SQL ������ �ۼ��Ͻÿ�. (Hint : CASE �Լ� ���, decode)
--0 ~ 1000 E    1001 ~ 2000 D    2001 ~ 3000 C   3100 ~ 4000 B   4001 ~ 5000 A
select empno, ename, sal, case trunc((sal-1)/1000) when 0 then 'E' when 1 then 'D' when 2 then 'C'
when 3 then 'B' else 'A' end ��� from emp;

select empno, ename, sal, decode(trunc((sal-1)/1000),0,'E',1,'D',2,'C',3,'B','A') ��� from emp;
--------------------------------------------------------------
                         -- king���� ����             king���  ���� ������ ���
select ename from emp start with mgr is null connect by prior empno = mgr;
-- top -> down left -> right
select lpad(ename, length(ename)+(level*3)-3, ' ') �̸� from emp start with mgr is null connect by prior empno = mgr;
select lpad(ename, length(ename)+(level*2)-2, ' ') �̸� from emp start with mgr is null connect by prior empno = mgr;
select lpad(ename, length(ename)+(level*3)-3, ' ') �̸� from emp start with ename = 'KING' connect by prior empno = mgr;

--- adams �������� ���踦 ������
select lpad(ename, length(ename)+(level*3)-3, ' ') �̸� from emp start with ename='ADAMS' connect by prior mgr = empno;

-- FORD line ���ֱ�
select lpad(ename, length(ename)+(level*3)-3, ' ') �̸� from emp start with ename='KING' connect by prior empno = mgr
and ename != 'FORD';

-- FORD�� ���ֱ�
select lpad(ename, length(ename)+(level*3)-3, ' ') �̸� from emp where ename != 'FORD' start with ename='KING' connect by prior empno = mgr;

--------------------------------------------------------------------
--- ���� �������� ���� ���
select * from emp;
select empno, ename, job, dname, loc from emp, dept where emp.deptno = dept.deptno;
--select empno, ename, job, deptno, dname, loc from emp, dept where emp.deptno = dept.deptno; ���� �߻�
select emp.empno, emp.ename, emp.job, emp.deptno, dept.dname, dept.loc from emp, dept where emp.deptno = dept.deptno; 
-- e, d ���̺� ��Ī table alias -> alias
select e.empno, e.ename, e.job, e.deptno, d.dname, d.loc from emp e, dept d where e.deptno = d.deptno; 
-- ���� ���̺��� �����ϴ� Į���� ���̺�� ���� ����
select empno, ename, job, e.deptno, dname, loc from emp e, dept d where e.deptno = d.deptno; 

-- īƼ�� ���δ�Ʈ , cross join   �� ����� �� ��� -- 14 x 4 = 56
select empno, ename, job, e.deptno, dname, loc from emp e, dept d;  
--------------------------------------------------------------------
--1. ���, �̸�, ����, �Ի���, �μ���
--2. �̸�, ����, �Ի���, �μ���, �ٹ��� 81�� �Ի縸
--3. �̸�, ����, �Ի���, �μ��ڵ�, �μ���, comm�� null
--4. �̸�, ����, �μ��ڵ�, �μ���,�ٹ���, �ٹ����� DALLAS
--5. �̸�, ����, �μ���, �ٹ��� ������ manager�̰ų� clerk�� ���
--6. �̸�, ����, �μ���, �޿�, comm, ����(=(�޿�+comm)*12 comm�� null�̸� 0) ���� ū ��
--7. ���, �̸�, ����, �μ��ڵ�, �μ���, �޿�  �޿��� 1000 ~ 3000 ���� �μ��� ��, �޿� ū ��
--8. ���, �̸�, �޿�, Ŀ�̼�, ����(comm�� null�̸� 0), �μ��ڵ�, �μ���, �ٹ���, �μ��ڵ� ��, �޿����� ��
--9. ���, �̸�, ����, �޿�, �μ���, �ٹ���  �μŸ��� reserach�� ��� �޿� ū ��


desc emp;
desc dept;

--1. ���, �̸�, ����, �Ի���, �μ���
select empno, ename, job, hiredate, dname from emp e, dept d where e.deptno = d.deptno;

--2. �̸�, ����, �Ի���, �μ���, �ٹ��� 81�� �Ի縸
select ename, job, hiredate, dname, loc from emp e, dept d where e.deptno = d.deptno and to_char(hiredate, 'yy') = 81;

--3. �̸�, ����, �Ի���, �μ��ڵ�, �μ���, comm�� null
select ename, job, hiredate, e.deptno, dname from emp e, dept d where e.deptno = d.deptno and comm is null;

--4. �̸�, ����, �μ��ڵ�, �μ���, �ٹ���, �ٹ����� DALLAS
select ename, job, e.deptno, dname, loc from emp e, dept d where e.deptno = d.deptno and loc = 'DALLAS';

--5. �̸�, ����, �μ���, �ٹ��� ������ manager�̰ų� clerk�� ���
select ename, job, dname, loc from emp e, dept d where e.deptno = d.deptno and lower(job) in ('manager','clerk');

--6. �̸�, ����, �μ���, �޿�, comm, ����(=(�޿�+comm)*12 comm�� null�̸� 0) ���� ū ��
select ename, job, dname, sal, comm, (sal+nvl(comm, 0))*12 ���� from emp e, dept d where e.deptno = d.deptno order by ���� desc;

--7. ���, �̸�, ����, �μ��ڵ�, �μ���, �޿�  �޿��� 1000 ~ 3000 ���� �μ��� ��, �޿� ū ��
select empno, ename, job, e.deptno, dname, sal from emp e, dept d where e.deptno = d.deptno and sal between 1000 and 3000 
order by dname, sal desc;

--8. ���, �̸�, �޿�, Ŀ�̼�, ����(comm�� null�̸� 0), �μ��ڵ�, �μ���, �ٹ���, �μ��ڵ� ��, �޿����� ��
select empno, ename, sal, comm, (sal+nvl(comm, 0))*12 ����, e.deptno, dname, loc from emp e, dept d where e.deptno = d.deptno
order by e.deptno, sal;

--9. ���, �̸�, ����, �޿�, �μ���, �ٹ���  �μŸ��� reserach�� ��� �޿� ū ��
select empno, ename, job, sal, dname, loc from emp e, dept d where e.deptno = d.deptno and dname = 'research' order by sal desc;

