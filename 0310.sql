select * from emp;
select * from salgrade;

-- non equi join �񵿵����� between, in
select empno, ename, sal, grade from emp, salgrade where sal between losal and hisal;
select * from dept;
select ename, job, sal, dname, loc from emp e, dept d where e.deptno = d.deptno;

-- outer join : �������� ���� �����
-- outer join: �� �� �̻��� ���̺��� ���ʿ��� �����ϴ� �����͵� ����ϰ� ���� �� ����Ѵ�. ������ �ʿ��� +�Ѵ�. ����Ŭ������ + ����
select ename, job, sal, dname, loc from emp e, dept d where e.deptno(+) = d.deptno;
-- ���� ���� ���̺��� ���� ���� left, ���߿� ���� ���̺��� ���� ���� right (mySQL)
select ename, job, sal, dname, loc from emp e right outer join dept d on e.deptno(+) = d.deptno;
-- ���� ���̺��� ������ �����͸� ���� ���� �� / ������ ������, �������� ������ �� �� (mySQL)
select ename, job, sal, dname, loc from emp e full outer join dept d on e.deptno(+) = d.deptno;

------------------------------------------------------------------------------------------------------------
desc emp;
desc dept;
--1. ���, �̸�, ����, �μ���, �ٹ��� �μ����
--2. �̸�, ����, �Ի���, �޿�, �μ��ڵ�, �μ��� �μ��ڵ� ��  �μ��ڵ尡 ������ �޿� ū ��
--3. ���, �̸�, ����, �޿�, �޿����  �޿���� ��
--4. ���, �̸�, ����, �޿�, �޿����, �μ���
--5. �̸�, ����, �Ի���, �޿�, �μ��ڵ�, �μ���, �ٹ��� �������� �μ� ����
--6. �̸�, ����, �Ի���, �޿�, �μ���, �ٹ��� �޿��� 1500~3000���� �μ����
--7. �̸�, ����, �޿�, ���� (= (�޿�+comm) * 12 comm�� null�̸� 0), �޿����, �μ���, �ٹ���
--8. �̸�, ����, �Ի���, �μ���, �ٹ��� 81�⿡ �Ի��� ��� �Ի��� ��
--9. �̸�, ����, �Ի���, �μ��ڵ�, �μ���, �ٹ���(�������� �μ� ����) �ٹ��� ��, �ٹ����� ������ �޿� ��

--1. ���, �̸�, ����, �μ���, �ٹ��� �μ����
select empno, ename, job, dname, loc from emp e, dept d where e.deptno = d.deptno order by dname;

--2. �̸�, ����, �Ի���, �޿�, �μ��ڵ�, �μ��� �μ��ڵ� ��  �μ��ڵ尡 ������ �޿� ū ��
select ename, job, hiredate, sal, d.deptno, dname from emp e, dept d where e.deptno = d.deptno order by d.deptno, sal desc;

--3. ���, �̸�, ����, �޿�, �޿����  �޿���� ��
select empno, ename, job, sal, grade from emp, salgrade where sal between losal and hisal order by grade; 

--4. ���, �̸�, ����, �޿�, �޿����, �μ���
select empno, ename, job, sal, grade, dname from emp e, dept d, salgrade where e.deptno = d.deptno and
e.sal between losal and hisal ;

--5. �̸�, ����, �Ի���, �޿�, �μ��ڵ�, �μ���, �ٹ��� �������� �μ� ���� (����� �� �����ַ��� d.deptno�� �ۼ��� ��)
select ename, job, hiredate, sal, d.deptno, dname, loc from emp e, dept d where e.deptno(+) = d.deptno;

--6. �̸�, ����, �Ի���, �޿�, �μ���, �ٹ��� �޿��� 1500~3000���� �μ����
select ename, job, hiredate, sal, dname, loc from emp e, dept d where e.deptno = d.deptno 
and sal between 1500 and 3000 order by dname;

--7. �̸�, ����, �޿�, ���� (= (�޿�+comm) * 12 comm�� null�̸� 0), �޿����, �μ���, �ٹ���
select ename, job, sal, (sal+nvl(comm,0))*12 ����, grade, dname, loc from emp e, dept d, salgrade 
where e.deptno = d.deptno and sal between losal and hisal;

--8. �̸�, ����, �Ի���, �μ���, �ٹ��� 81�⿡ �Ի��� ��� �Ի��� ��
select ename, job, hiredate, dname, loc from emp e, dept d where e.deptno = d.deptno and
to_char(hiredate, 'yy') = 81 order by hiredate;

--9. �̸�, ����, �Ի���, �μ��ڵ�, �μ���, �ٹ���(�������� �μ� ����) �ٹ��� ��, �ٹ����� ������ �޿� ��
select ename, job, hiredate, d.deptno, dname, loc from emp e, dept d where e.deptno(+) = d.deptno order by loc, sal;
------------------------------------------------------------------------------------------------------------
--6. �̸�, ����, �Ի���, �޿�, �μ���, �ٹ��� �޿��� 1500~3000���� �μ����  �ٽú���

-- ������ ���� �μ��� �޿��� �����Ƿ� �޿� 1500 ~ 3000 ���� ���ǰ� ������ ���� �μ��� ���� �������� �ʴ´�.
--select ename, job, hiredate, sal, grade, dname, loc from emp e, dept d, salgrade where e.deptno(+) = d.deptno 
--and sal between 1500 and 3000 and sal between losal and hisal;

-- !!!  ���̺� 3���� �����Ϸ��� ������ 2�� �־�� �Ѵ�. ���̺� 4���� �����Ϸ��� ������ 3�� �־�� �Ѵ�. !!!  ---

-- !!!
-- ����� ���� : ���� ���̺� ������ �θ� �ش��ϴ� PK(empno)�� �ڽĿ� �ش��ϴ� FK(mgr)�� ���� �ִ� ����
-- self join : ����, �����ڸ� ���� ���

-- self join  (oracle �ǽ� ���̺�.docx ����)
select w.ename ����, m.ename ������ from emp w, emp m where w.mgr = m.empno; -- ������ ��µ��� �ʴ´�.

-- !!! ������� ���, �����ϴ� �ڵ� !!!     +�� ���� ���� ���� ���� �ʿ� ǥ��, ���� �ִ� +�� �� �ٸ�. ������ �����ڰ� ���� -> �����ڵ� ǥ��
select w.ename ����, m.ename ������ from emp w, emp m where w.mgr = m.empno(+); 

select distinct mgr from emp;
select distinct empno from emp;
--select w.ename ����, m.ename ������ from emp w, emp m where w.mgr(+) = m.empno; �߸��� �ڵ�
select w.ename ����, m.ename ������ from emp m full outer join emp w on w.mgr = m.empno; -- ���� x
------------------------------------------------------------------------------------------------------------
--1. xxx�� ���� xxx�Դϴ�.
--2. emp ���̺��� manager�� 'KING'�� ������� �̸�(ename)�� ����(job)�� ����Ͻÿ�.
--3. �̸�, ���, �Ի���, �μ���, �����ڸ�
--4. �̸�, ����, �Ի���, �޿�, �μ���, �����ڸ�, ������ ���� ���� ����
--5. �̸�, �޿�, �޿����, �μ���, �����ڸ�, ������ ���� ���� ����
--6. �̸�, ����, �޿�, �޿����, �μ���, �ٹ���, �����ڸ� �޿��� ������ salesman, manager�� ���
--7. �̸�, ����, �޿�, �޿����, ����(=(�޿�+comm)*12, comm�� null�̸� 0), �μ���, �����ڸ�
--8. �̸�, �޿�, �޿����, �����ڸ� (������ ���� ���� ����), �μ����, �޿� ū ��


--1. xxx�� ���� xxx�Դϴ�.
select w.ename ||'�� ���� '|| m.ename || '�Դϴ�' from emp w, emp m where w.mgr = m.empno;

--2. emp ���̺��� manager�� 'KING'�� ������� �̸�(ename)�� ����(job)�� ����Ͻÿ�.
select w.ename, w.job from emp w, emp m where w.mgr = m.empno and m.ename = 'KING';

--3. �̸�, ���, �Ի���, �μ���, �����ڸ�
select w.ename ����, w.empno, w.hiredate, dname, m.ename ������ from emp w, emp m, dept d where w.mgr = m.empno
and w.deptno = d.deptno; 

--4. �̸�, ����, �Ի���, �޿�, �μ���, �����ڸ�, ������ ���� ���� ����
select w.ename ����, w.job, w.hiredate, w.sal, dname, m.ename ������ from emp w, emp m, dept d  where w.mgr = m.empno(+)
and w.deptno = d.deptno;

--5. �̸�, �޿�, �޿����, �μ���, �����ڸ�, ������ ���� ���� ����
select w.ename ����, w.sal, grade, dname, m.ename ������ from emp w, emp m, dept d, salgrade where w.deptno = d.deptno 
and w.sal between losal and hisal and w.mgr = m.empno(+);

--6. �̸�, ����, �޿�, �޿����, �μ���, �ٹ���, �����ڸ�  ������ salesman, manager�� ���
select w.ename ����, w.job, w.sal, grade, dname, loc, m.ename ������ from emp w, emp m, dept d, salgrade where w.deptno = d.deptno 
and w.mgr = m.empno and w.sal between losal and hisal and lower(w.job) in ('salesman', 'manager');

--7. �̸�, ����, �޿�, �޿����, ����(=(�޿�+comm)*12, comm�� null�̸� 0), �μ���, �����ڸ�
select w.ename ����, w.job, w.sal, grade, (w.sal+nvl(w.comm,0))*12 ����, dname, m.ename ������ from emp w, emp m, dept d, salgrade 
where w.deptno = d.deptno and w.sal between losal and hisal and w.mgr = m.empno;

--8. �̸�, �޿�, �޿����, �����ڸ� (������ ���� ���� ����), �μ����, �޿� ū ��
select w.ename ����, w.sal, grade, m.ename ������ from emp w, emp m, salgrade, dept d where w.deptno = d.deptno 
and w.sal between losal and hisal and w.mgr = m.empno(+) order by dname, w.sal desc;
------------------------------------------------------------------------------------------------------------
create table a(val char(1) primary key);
insert into a values('A');
insert into a values('B');
insert into a values('C');
insert into a values('D');
insert into a values('E');
select * from a;

create table b(num number(1) primary key, val char(1));
insert into b values(1, 'C');
insert into b values(2, 'D');
insert into b values(3, 'E');
insert into b values(4, 'F');
insert into b values(5, 'G');
select * from b;

-- union : ������, �ߺ��� �����ʹ� 1ȸ ���� : ��µǴ� ������ ���� ����(�÷�)�� ��ġ�ؾ���
select val from a union
select val from b;
-- union : ������, �ߺ��� �����ʹ� 1ȸ ����
select val from a union select val from b;
-- �ߺ��� �� ����, ���� �ȵ�
select val from a union all select val from b;

select 0,val from a union select num, val from b;
select null,val from a union select num, val from b;

-- intersect ��������, ������
select val from a intersect select val from b;
-- minus ������
select val from a minus select val from b;
select val from b minus select val from a;

-- ���� ���̺� �������� ����ϴ� �÷��� �� �� ����
select ename, sal, dname from emp natural join dept;
select ename, sal, dname from emp join dept using(deptno);

------------------------------------------------------------------------------------------------------------
--1. EMP ���̺��� ��� ����� ���� �̸�,�μ���ȣ,�μ����� ����ϴ� SELECT ������ �ۼ��Ͽ���.
--2. EMP ���̺��� NEW YORK���� �ٹ��ϰ� �ִ� ����� ���Ͽ� �̸�,����,�޿�,�μ����� ����ϴ� SELECT ������ �ۼ��Ͽ���.
--3. EMP ���̺��� ���ʽ��� �޴� ����� ���Ͽ� �̸�,�μ���,��ġ�� ����ϴ� SELECT ������ �ۼ��Ͽ���.
--4. EMP ���̺��� �̸� �� L�ڰ� �ִ� ����� ���Ͽ� �̸�,����,�μ���,��ġ�� ����ϴ� SELECT ������ �ۼ��Ͽ���.
--5. ���, �����, �μ��ڵ�, �μ����� �˻��϶�. ������������ �������� ����
--6. ���, �����, �޿�, �μ����� �˻��϶�. �� �޿��� 2000�̻��� ����� ���Ͽ� �޿��� �������� ������������ �����Ͻÿ�
--7. ���, �����, ����, �޿�, �μ����� �˻��Ͻÿ�. �� ������ MANAGER�̸� �޿��� 2500�̻��� ����� ���Ͽ� ����� �������� ������������ �����Ͻÿ�.
--8. ���, �����, ����, �޿�, ����� �˻��Ͻÿ�. ����� �޿��� ���Ѱ��� ���Ѱ� ������ ���Եǰ� �޿����� ������������ �����Ͻÿ�
--9. ������̺��� �����, ����� �����ڸ��� �˻��Ͻÿ�
--10. �����, �����ڸ�, �������� �����ڸ��� �˻��Ͻÿ�
--11. ���� ������� ���� �����ڰ� ���� ��� ����� �̸��� ����� ��µǵ��� �����Ͻÿ�


--1. EMP ���̺��� ��� ����� ���� �̸�,�μ���ȣ,�μ����� ����ϴ� SELECT ������ �ۼ��Ͽ���.
select ename, e.deptno, dname from emp e, dept d where e.deptno = d.deptno;

--2. EMP ���̺��� NEW YORK���� �ٹ��ϰ� �ִ� ����� ���Ͽ� �̸�,����,�޿�,�μ����� ����ϴ� SELECT ������ �ۼ��Ͽ���.
select ename, job, sal, dname from emp e, dept d where e.deptno = d.deptno and loc = 'NEW YORK';

--3. EMP ���̺��� ���ʽ��� �޴� ����� ���Ͽ� �̸�,�μ���,��ġ�� ����ϴ� SELECT ������ �ۼ��Ͽ���.
select ename, dname, loc from emp e, dept d where e.deptno = d.deptno and comm is not null;

--4. EMP ���̺��� �̸� �� L�ڰ� �ִ� ����� ���Ͽ� �̸�,����,�μ���,��ġ�� ����ϴ� SELECT ������ �ۼ��Ͽ���.
select ename, job, dname, loc from emp e, dept d where e.deptno = d.deptno and ename like '%L%';

--5. ���, �����, �μ��ڵ�, �μ����� �˻��϶�. ������������ �������� ����
select empno, ename, e.deptno, dname from emp e, dept d where e.deptno = d.deptno order by ename;

--6. ���, �����, �޿�, �μ����� �˻��϶�. �� �޿��� 2000�̻��� ����� ���Ͽ� �޿��� �������� ������������ �����Ͻÿ�
select empno, ename, sal, dname from emp e, dept d where e.deptno = d.deptno and sal >= 2000 order by sal desc;

--7. ���, �����, ����, �޿�, �μ����� �˻��Ͻÿ�. ��s ������ MANAGER�̸� �޿��� 2500�̻��� ����� ���Ͽ� ����� �������� ������������ �����Ͻÿ�.
select empno, ename, job, sal, dname from emp e, dept d where e.deptno = d.deptno and lower(job) = 'manager' and sal >= 2500
order by empno;

--8. ���, �����, ����, �޿�, ����� �˻��Ͻÿ�. ����� �޿��� ���Ѱ��� ���Ѱ� ������ ���Եǰ� �޿����� ������������ �����Ͻÿ�
select empno, ename, job, sal, grade from emp, salgrade where sal between losal and hisal order by sal desc;

--9. ������̺��� �����, ����� �����ڸ��� �˻��Ͻÿ�
select w.ename ���, m.ename ������ from emp w, emp m where w.mgr = m.empno; 

--10. �����, �����ڸ�, �������� �����ڸ��� �˻��Ͻÿ�
select w.ename ��� , m.ename ������, h.ename �������ǰ����� from emp w, emp m, emp h where w.mgr = m.empno and m.mgr = h.empno;

--11. ���� ������� ���� �����ڰ� ���� ��� ����� �̸��� ����� ��µǵ��� �����Ͻÿ�
select w.ename ��� , m.ename ������, h.ename �������ǰ����� from emp w, emp m, emp h where w.mgr = m.empno(+) and m.mgr = h.empno(+);




