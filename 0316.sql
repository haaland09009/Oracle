select * from emp e where exists (select * from emp where e.empno = mgr);

create table emp01 as select * from emp where 1 = 0;
desc emp01;

drop table emp01;

CREATE TABLE EMP01( 
EMPNO NUMBER(4), 
ENAME VARCHAR2(20), 
SAL NUMBER(7, 2));

select * from emp01;

alter table emp01 add(job varchar2(20));
alter table emp01 drop(job);

create table dept02 (
    deptno number(2) primary key,
    dname varchar2(14),
    loc varchar2(13));
    
select * from dept02;    
alter table dept02 add(dmgr varchar(20));
alter table dept02 drop(dmgr);
drop table emp01;

-- 참조 무결성 제약조건: 자식이 있는 데이터는 삭제할 수 없다.
-- restrict default : 자식이 있는 데이터는 삭제할 수 없다.
-- set null: 부모 데이터를 지우면 자식의 fk의 값을 null로 변경
-- 
create table emp01 as select * from emp;
select * from emp01;
-- truncate로 데이터를 지우면 복구가 안된다.
truncate table emp01;
-----------------------------------------------------------------------------
-- dept 테이블을 이용하여 dept01 테이블 생성
-- dept01 테이블 비우기
-- dept 테이블 삭제

create table dept01 as select * from dept;
select * from dept01;
truncate table dept01;
drop table dept01;

create table dept01 as select * from dept;
alter table dept01 rename to buseo;
alter table buseo rename to dept01;

drop table dept01;

-------------------------------------------------------------
--08.CreateTable.pdf 38 페이지
create table juso (
    no number(3),
    name varchar2(10),
    addr varchar2(20),
    email varchar2(5));

alter table juso add(phone varchar2(10));

alter table juso modify(email varchar2(20));

alter table juso drop(addr);

select * from juso;

drop table juso;
-------------------------------------------------------------
--08.CreateTable.pdf 39p
--1. EMP 테이블의 SAL, COMM을 제외한 모든 COLUMN과 행을 포함하는 EMP_DEMO 테이블을 생성하는 SQL문을 작성하여라.
--2. EMP 테이블과 DEPT 테이블을 이용하여 아래의 내용을 포함하는 테이블(EMP_DEPT)을 생성하여라.
--EMPNO ENAME JOB DNAME LOC
--------- ---------- --------- -------------- ------------
--7839 KING PRESIDENT ACCOUNTING NEW YORK
--7698 BLAKE MANAGER SALES CHICAGO
--. . . . . . . . . .
--3. EMP 테이블과 SALGRADE 테이블을 이용하여 아래의 내용을 포함하는 테이블 (EMP_GRADE)을 생성하여라.
--EMPNO ENAME JOB SAL COMM GRADE
----------- ---------- --------- --------- --------- ---------
--7839 KING PRESIDENT 5000 5
--7698 BLAKE MANAGER 2850 4
--7782 CLARK MANAGER 2450 4
--7566 JONES MANAGER 2975 4
--. . . . . . . . . .
--4. 3번에서 생성한 테이블에 SAL의 정밀도를 정수 부분을 12자리 소수 이하 4자리로 변경하는 SQL 문을 작성하여라.
--5. 2번과 3번에서 생성한 테이블을 모두 삭제하는 SQL문을 작성하여라


-------------------------------------------------------------
desc emp;
drop table emp_demo;
--1. EMP 테이블의 SAL, COMM을 제외한 모든 COLUMN과 행을 포함하는 EMP_DEMO 테이블을 생성하는 SQL문을 작성하여라.
create table emp_demo as select empno, ename, job, mgr, hiredate, deptno from emp;  

--2. EMP 테이블과 DEPT 테이블을 이용하여 아래의 내용을 포함하는 테이블(EMP_DEPT)을 생성하여라.
--EMPNO ENAME JOB DNAME LOC
--------- ---------- --------- -------------- ------------
--7839 KING PRESIDENT ACCOUNTING NEW YORK
--7698 BLAKE MANAGER SALES CHICAGO
--. . . . . . . . . .
create table emp_dept as select empno, ename, job, dname, loc from emp e, dept d
where e.deptno = d.deptno;
     
    
--3. EMP 테이블과 SALGRADE 테이블을 이용하여 아래의 내용을 포함하는 테이블 (EMP_GRADE)을 생성하여라.
--EMPNO ENAME JOB SAL COMM GRADE
----------- ---------- --------- --------- --------- ---------
--7839 KING PRESIDENT 5000 5
--7698 BLAKE MANAGER 2850 4
--7782 CLARK MANAGER 2450 4
--7566 JONES MANAGER 2975 4
--. . . . . . . . . .
create table emp_grade as select empno, ename, job, sal, comm, grade 
from emp, salgrade where sal between losal and hisal;

--4. 3번에서 생성한 테이블에 SAL의 정밀도를 정수 부분을 12자리 소수 이하 4자리로 변경하는 SQL 문을 작성하여라.
alter table emp_grade modify(sal number(12,4));

--5. 2번과 3번에서 생성한 테이블을 모두 삭제하는 SQL문을 작성하여라
drop table emp_demo;
drop table emp_dept;
drop table emp_grade;
-------------------------------------------------------------
-- 입력
--1) insert into table명 (컬럼,...) values (값,...);
--   * 앞의 컬럼의 갯수와 뒤의 값의 갯수와 순서가 일치해야 한다
--2) insert into table명 values(값,....);
--   * 모든 컬럼에 해당하는 값이 있어야 한다.
--   * 값의 순서를 테이블 정의와 같아야 한다.
--3) sub query를 이용한 입력

drop table dept01;
create table dept01 as select * from dept where 1 = 0;
select * from dept01;
insert into dept01 (deptno, dname) values(10, '영업');
insert into dept01 (deptno, loc) values(20, '강남');
insert into dept01 values(30,'인사','대구');

insert into dept01 values(40,'홍보', null);

-------------------------------------------------------------
drop table emp01;
--emp01 사번, 이름, 업무, 급여
--1111 제니 
--1234 보검 인사 1000 컬럼
--2222 로제 회계 2000 values

create table emp01 as select empno, ename, job, sal from emp where 1 = 0;
select * from emp01;
insert into emp01 (empno, ename) values(1111, '제니');
insert into emp01 (empno, ename, job, sal) values (1234, '보검', '인사', 1000);
insert into emp01 values (2222, '로제', '회계' ,2000);
-------------------------------------------------------------
drop table emp01;
create table emp01 as select empno, ename, job, sal from emp where 1 = 0;
alter table emp01 add(hiredate date);
select * from emp01;

-- sysdate 오늘
insert into emp01 values(1111,'제니','홍보',1000,sysdate);
-- user는 로그인한 사용자
insert into emp01 values(1112,user,'홍보',1000,to_date('03/02/23', 'rr/mm/dd'));

-------------------------------------------------------------
--09.DML사용.pdf 15p
--1. 서브 쿼리문을 이용하여 다음과 같은 구조로 SAM01 테이블을 생성하시오. 존재할 경우 DROP TABLE로 삭제 후 생성하시오.
drop table sam01;
create table sam01 as select empno, ename, job, sal from emp where 1=0;

--2. SAM01 테이블에 다음과 같은 데이터를 추가하시오.
insert into sam01 values(1000,'APPLE','POLICE',10000);
insert into sam01 values(1010,'BANANA','NURSE',15000);
insert into sam01 values(1020,'ORANGE','DOCTOR',25000);
insert into sam01 values(1030, 'VERY', null, 10000);
insert into sam01 values(1040, 'CAT',null,2000);
--3. SAM01 테이블에 다음과 같이 NULL 값을 갖는 행을 추가하시오.
select * from sam01;
-------------------------------------------------------------
-- 이 부분 못들었음
select empno, ename, &a from emp;
select * from emp where sal >= &sal and lower(job) = '&job';
-- & a : 계속 물어봄, &aa: 고정됨 안물어봄
select empno, ename, &&aa from emp;
define aa
define aa = sal

accept department prompt '부서명 : '
select * from dept where dname = upper('&department');

select * from dept01;
truncate table dept01;

-- create할 때는 as가 있는데 insert할 때는 as가 없음
insert into dept01 select * from dept;
-------------------------------------------------------------
--SAM01 테이블에 서브 쿼리문을 사용하여 EMP 에 저장된 사원 중 deptno가 10번 사원의 정보를 추가하시오
select * from sam01;
insert into sam01 select empno, ename, job, sal
from emp where deptno = 10;

-------------------------------------------------------------
-- update
-- 1) update table명 set 컬럼 = 값, ... where 조건;
--      조건이 없으면 모든 데이터 수정
-- 2) sub query를 update 

select * from emp01;
update emp01 set sal = 1500;
update emp01 set sal = 2000 where ename = '제니';
update emp01 set ename='보검', sal = 2500, hiredate=sysdate where empno=1112;
-------------------------------------------------------------
--1) sam01 deptno 숫자2 컬럼추가
alter table sam01 add(deptno number(2));
desc sam01;
--2) 급여가 2000이상인 경우 급여 30% 인상
update sam01 set sal = sal*1.3 where sal >= 2000;
--3) 급여가 10000이상인 경우 급여 5000원 삭감
update sam01 set sal = sal - 5000 where sal >= 10000;
--4) 사번이 1030인 사람의 이름을 차은우, 급여를 10% 인상
select * from sam01;
update sam01 set ename = '차은우', sal = sal * 1.1 where deptno = 1030;

--5) job이 null인 사람의 job을 뮤직으로 변경
update sam01 set job = 'MUSIC' where job is null;
select * from sam01;


drop table sam01;
create table sam01 as select empno, ename, job, sal from emp where 1=0;

--2. SAM01 테이블에 다음과 같은 데이터를 추가하시오.
insert into sam01 values(1000,'APPLE','POLICE',10000);
insert into sam01 values(1010,'BANANA','NURSE',15000);
insert into sam01 values(1020,'ORANGE','DOCTOR',25000);
insert into sam01 values(1030, 'VERY', null, 10000);
insert into sam01 values(1040, 'CAT',null,2000);
alter table sam01 add(hiredate date);
select * from sam01;

insert into sam01 select empno, ename, job, sal, hiredate from emp where deptno = 10;
alter table sam01 add(deptno number(2));

update sam01 set sal = sal*1.3 where sal >= 2000;
update sam01 set sal = sal - 5000 where sal >= 10000;
update sam01 set ename = '차은우', sal = sal * 1.1 where deptno = 1030;
update sam01 set job = 'MUSIC' where job is null;
select * from sam01;

-- job 7900, sal = 7844 1020
update sam01 set sal = (select sal from emp where empno = 7844), job = (select job
from emp where empno=7900) where empno = 1020;
select * from sam01;

update sam01 set hiredate = sysdate where hiredate is null;
update sam01 set deptno = 20; -- 전부 다 20으로 바꿈
update sam01 set deptno = 10 where empno in (select empno from emp);

-------------------------------------------------------------
--1. 사번이 1000인 사람의 입사일을 scott와 같게 급여는 adams와 같게 변경
--2. dname varchar2(20) 추가
--3. dept 테이블을 참조하여 sam01의 dname을 채우시오
--4. 사번 1030 입사일을 21/05/05로 변경
--5. 사번 1010인 사람의 부서코드를 30으로 하고 부서명은 dept테이블 참조하여 30부서명으로 변경

--1. 사번이 1000인 사람의 입사일을 scott와 같게, 급여는 adams와 같게 변경
update sam01 set hiredate = (select hiredate from emp where ename = 'SCOTT'),
sal = (select sal from emp where ename = 'ADAMS') where empno = 1000;

--2. dname varchar2(20) 추가
alter table sam01 add(dname varchar2(20));

--3. dept 테이블을 참조하여 sam01의 dname을 채우시오 [상관관계 쿼리]
update sam01 s set dname = (select dname from dept where s.deptno = deptno);

--4. 사번 1030 입사일을 21/05/05로 변경
update sam01 set hiredate = to_date('21/05/05', 'rr/mm/dd') where empno = 1030;

--5. 사번 1010인 사람의 부서코드를 30으로 하고 부서명은 dept테이블 참조하여 30부서명으로 변경
update sam01 set deptno = 30, dname = (select dname from dept where deptno = 30)
where empno = 1010;



