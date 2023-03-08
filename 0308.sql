select ename, lower(ename), upper(ename), initcap(ename) from emp;
-- ������ MANAGER�̰ų� SALESMAN �� ���� ������ �ӿ��� �빮������ �ҹ������� �� �� => �ҹ��ڷ� �ٲ������
select * from emp where lower(job) in ('manager','salesman');
select ename, substr(ename,2,3) from emp; -- ���ǻ���: �ε����� �ƴ϶� ���ڿ� ����
select ename, substr(ename,2,3), substr(ename,-4,2) from emp; -- substr(ename, ������ġ, ���ڱ���)
-- dual�� dummy table�μ� ������ �� ��  / length: ���� ��
select length('oracle'), length('����Ŭ') from dual;
-- lengthb �����ϴ� byte ����
select lengthb('oracle'), lengthb('����Ŭ') from dual;

-- 2���� �Ի��� ���
--select ename, hiredate from emp where hiredate like '%02%'; -- 2�Ͽ� �Ի��� ����� ���� ������ ������ �ȵ�. �߸��� �ڵ���.
select ename, hiredate from emp where substr(hiredate,4,2) = 02;

----------------------------------------------------------------------------------------
--EMP ���̺��� Hiredate�� �⵵�� 1987�� ����� ��� ������ ����Ͻÿ� (�� substr �Լ��� �̿��ؼ� where���� ����ÿ�)
--? EMP ���̺��� ename�� E�� ������ ����� ��� ������ ����Ͻÿ�. (�� substr �Լ��� �̿��ؼ� where���� ����ÿ�

--EMP ���̺��� Hiredate�� �⵵�� 1987�� ����� ��� ������ ����Ͻÿ� (�� substr �Լ��� �̿��ؼ� where���� ����ÿ�)
select * from emp where substr(hiredate, 1,2) = 87;
--? EMP ���̺��� ename�� E�� ������ ����� ��� ������ ����Ͻÿ�. (�� substr �Լ��� �̿��ؼ� where���� ����ÿ�)
select * from emp where substr(lower(ename), -1,1) = 'e';
select * from emp where substr(ename, -1,1) = 'E';
----------------------------------------------------------------------------------------

select substr('welcome oracle',2,3), substr('ȯ���մϴ� ����Ŭ',2,3) from dual;
select substrb('welcome oracle',2,3), substrb('����Ŭ',2,3) from dual;

-- instr(�÷�, ����, ����, ����) ��ġ�� �ش��ϴ� ������ ���
select ename, instr(ename,'L') e_null, instr(ename,'L',1,1) e_11, instr(ename,'L',1,2) e_12, 
instr(ename,'L',4,1) e_41, instr(ename,'L',4,2) e_42 from emp order by ename;

-- lpad, rpad: ���ڸ� ���߰� ���� ��
select ename, lpad(ename,'7','@'), rpad(ename,7,'#') from emp;
select ename, lpad(ename,'7',' '), rpad(ename,7,' ') from emp;

-- Ư�� �ܾ ������ ���� �� 
select ename, ltrim(ename, 'A'), rtrim(ename, 'S'), trim('S' from ename) from emp;

-- translate : ���� �ѱ��ھ� ���� / replace: �ܾ� ������ ����
select empno, ename, translate(ename,'ABCDEFG','0123456') from emp; 
select ename, job, replace(job,'MAN','PERSON') from emp; 
----------------------------------------------------------------------------------------
--1. job�� ����,�ҹ���,ù���ڸ� �빮��,�빮�ڷ� ��� ���� ����
--2. ������ CLERK�̰ų� MANAGER�� ����� �̸�, ���� lower�Լ� ���
--3. 81�⵵�� �Ի��� ����� �̸�,����,�Ի��� substr �̿�
--4. �̸�,���� S����, ���� S����, ���� S ����
--5. �޿��� 5�ڷ� ����ϴ� 5�ڰ� �ƴ� ��� ���ʿ� # �߰�
--6. �̸�,�ι�°���� 3����, ����(=(�޿�+comm)*12) comm�� null�̸� 0) ���� ū �� ����
--7. �̸�,���� �������� MAN�� �ΰ����� �����Ͽ� ���
--8. �̸�,�޿� �޿� 0123456789 => �����̻��...�� �����Ͽ� ���
--9. �̸�, �̸��� ���ڼ�  ���ڼ��� ū������  ����


--1. job�� ����,�ҹ���,ù���ڸ� �빮��,�빮�ڷ� ��� ���� ����
select job, lower(job), initcap(job), upper(job) from emp order by job;

--2. ������ CLERK�̰ų� MANAGER�� ����� �̸�, ���� lower�Լ� ���
select ename, job from emp where lower(job) in ('clerk','manager');

--3. 81�⵵�� �Ի��� ����� �̸�,����,�Ի��� substr �̿�
select ename, job, hiredate from emp where substr(hiredate,1,2) = 81;

--4. �̸�,���� S����, ���� S����, ���� S ����
select ename, ltrim(ename,'S'), rtrim(ename,'S'), trim('S' from ename) from emp;

--5. �޿��� 5�ڷ� ����ϴ� 5�ڰ� �ƴ� ��� ���ʿ� # �߰�
select sal, lpad(sal,'5','#') from emp;

--6. �̸�,�ι�°���� 3����, ����(=(�޿�+comm)*12) comm�� null�̸� 0) ���� ū �� ����
select ename, substr(ename,2,3), (sal+nvl(comm,0))*12 ���� from emp order by ���� desc;

--7. �̸�,���� �������� MAN�� �ΰ����� �����Ͽ� ���
select ename, job, replace(job,'MAN','�ΰ�') from emp;

--8. �̸�,�޿� �޿� 0123456789 => �����̻��...�� �����Ͽ� ���
select ename, sal, translate(sal, '0123456789', '�����̻�����ĥ�ȱ�') from emp;

--9. �̸�, �̸��� ���ڼ�  ���ڼ��� ū������  ����
select ename, length(ename) from emp order by length(ename) desc;
----------------------------------------------------------------------------------------
select abs(10), abs(-10) from dual;

-- ����� ��� trunc�� floor�� ���� ���
select ename, sal/3, round(sal/3), trunc(sal/3), ceil(sal/3), floor(sal/3) from emp;
-- ������ ��� trunc�� ceil�� ���� ���
select ename, -sal/3, round(-sal/3), trunc(-sal/3), ceil(-sal/3), floor(-sal/3) from emp;
select ename, sal, mod(sal,30) from emp; -- mod�� ������
select ename, sal, power(sal,2) from emp;
select power(2,3),power(3,3) from dual;
select sqrt(10), sqrt(4), sqrt(2) from dual;
-- sign ��� 1, ���� -1, 0�� 0
select sign(100), sign(-100) from dual;
select chr(65), chr(48), chr(97) from dual;
select ename, sal/3, round(sal/3, 2), trunc(sal/3, 1), round(sal/3, -2), trunc(sal/3, -1) from emp; -- -2�� 100����, -1�� 10�������� �ݿø�
----------------------------------------------------------------------------------------
--1. �̸�, �޿�/7, �ݿø�, ����, ceil, floor
--2. �̸�, -�޿�/7, �ݿø�, ����, ceil, floor
--3. �̸�, �޿�/7, �ݿø�, �Ҽ��� 1, �Ҽ��� 2, 10����, 100����
--4. �̸�, �޿�/7, ����, �Ҽ��� 1, �Ҽ��� 2, 10����, 100����
--5. �̸�, �޿�, �޿�/8�� ������, �޿�/7�� ������
--6. 2�� 10��, ��Ʈ 3, �ƽ�Ű 66�� �ش��ϴ� ����


--1. �̸�, �޿�/7, �ݿø�, ����, ceil, floor
select ename, sal/7, round(sal/7), trunc(sal/7), ceil(sal/7), floor(sal/7) from emp;

--2. �̸�, -�޿�/7, �ݿø�, ����, ceil, floor
select ename, -sal/7, round(-sal/7), trunc(-sal/7), ceil(-sal/7), floor(-sal/7) from emp;

--3. �̸�, �޿�/7, �ݿø�, �Ҽ��� 1, �Ҽ��� 2, 10����, 100����
select ename, sal/7, round(sal/7), round(sal/7, 1), round(sal/7, 2), round(sal/7, -1), round(sal/7, -2) from emp;

--4. �̸�, �޿�/7, ����, �Ҽ��� 1, �Ҽ��� 2, 10����, 100����
select ename, sal/7, trunc(sal/7), trunc(sal/7, 1), trunc(sal/7, 2), trunc(sal/7, -1), trunc(sal/7, -2) from emp;

--5. �̸�, �޿�, �޿�/8�� ������, �޿�/7�� ������
select ename, sal, mod(sal/8), mod(sal/7) from emp;

--6. 2�� 10��, ��Ʈ 3, �ƽ�Ű 66�� �ش��ϴ� ����
select power(2,10), sqrt(3), chr(66) from dual;
----------------------------------------------------------------------------------------
-- months_between, add_months, next_day �˰��ֱ�
select sysdate from dual;
select ename, sysdate, hiredate, round(sysdate-hiredate) �ٹ���, round((sysdate-hiredate)/7) �ٹ���,
round((sysdate-hiredate)/30) �ٹ���, round(months_between(sysdate, hiredate)) �ٹ��� from emp; -- �ٹ��� �� �� months_betweeon ����Ѵ�.
-- months_between : 31��,����,���� ��� ������ش�.
-- ���� ��¥ ������ ���� ����
select ename, hiredate, add_months(hiredate, 2), next_day(hiredate, '��') from emp;

select ename, hiredate, to_char(hiredate, 'yy/mm/dd hh:mi:ss'), to_char(hiredate, '(dy) yyyy/mm/dd'),
to_char(hiredate, '(day) yyyy-mm-dd (am) hh:mi:ss'), to_char(hiredate, 'yy"��" mm"��" dd"��" hh"��" mi"��" ss"��"') from emp;

select ename, sal, to_char(sal, '00000'), to_char(sal, '99999'), to_char(sal, '9,999'),
to_char(sal, '9,999.99'), to_char(sal, 'L9,999'), to_char(sal, '$9,999') from emp;


-- ���� => ����, ���� => ��¥
select 76 - to_number('45') from dual;
select round(sysdate - to_date(19980115, 'yyyy/mm/dd')) from dual;
select round(sysdate - to_date(980115, 'rr/mm/dd')) from dual; 
-- yy�� ����ϸ� ���� ���� 20
-- rr: 0 ~ 49�� 20 �� ����
--    50 ~ 99�� 19 �� ����

----------------------------------------------------------------------------------------
--1. �̸�, �Ի���, �ٹ���, �ٹ���, �޿�, ���ݱ��� ���� �ѱ޿�(����)
--2. �̸�, �Ի���, �Ի� �� �δ� ��
--3. �̸�, �Ի��� (���� 3�ڸ�) �⵵4-��-�� (����/����) ��:��:��
--4. �̸�, �޿�, ù���� �ĸ�, ��ȭǥ��
--5. ������ ��ƿ� �ð� �Ҽ������� �ݿø�


--1. �̸�, �Ի���, �ٹ���, �ٹ���, �޿�, ���ݱ��� ���� �ѱ޿�(����)
select ename, hiredate,round(sysdate-hiredate) �ٹ���, round(months_between(sysdate, hiredate)) �ٹ���,
sal, trunc(sal*round(months_between(sysdate, hiredate))) �ѱ޿� from emp;

--2. �̸�, �Ի���, �Ի� �� �δ� ��
select ename, hiredate, add_months(hiredate, 2) from emp;

--3. �̸�, �Ի��� (���� 3�ڸ�) �⵵4-��-�� (����/����) ��:��:��
select ename, to_char(hiredate, '(day) yyyy-mm-dd (am) hh:mi:ss') from emp;

--4. �̸�, �޿�, ù���� �ĸ�, ��ȭǥ�� (��ȭ �빮�� L)
select ename,  to_char(sal, 'L99,999') from emp;

--5. ������ ��ƿ� �ð� �Ҽ������� �ݿø�
select round(sysdate - to_date('91/07/20', 'rr/mm/dd')) from dual;

-- case when��
select empno, ename, sal, job, case lower(job) when 'analyst' then sal*1.1 
                                               when 'clerk' then sal*1.2
                                               when 'manager' then sal*1.3 
                                               when 'president' then sal*1.4 
                                               when 'salesman' then sal*1.5 
                                               else sal end �ݿ��λ�� from emp; -- end�� case�� ����

-- decode�� ����Ŭ�� ����
select empno, ename, sal, job, decode(lower(job),'analyst',sal*1.1 
                                                 ,'clerk',sal*1.2
                                                 ,'manager',sal*1.3 
                                                ,'president',sal*1.4 
                                                ,'salesman',sal*1.5 
                                                ,sal) �ݿ��λ�� from emp; 
                                                
                                                
----------------------------------------------------------------------------------------
-- ���,�μ��ڵ�,�μ��� : �μ��ڵ� 10�̸� ȸ���� 20�̸� ������ 30�̸� ������ �ƴϸ� ���
select empno, deptno, job, decode(deptno, '10','ȸ����','20','������','30','������','���') �μ��� from emp;

