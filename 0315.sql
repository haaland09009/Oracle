-- 회사 직원급여 평균보다 많이 받는 사람
select ename, sal from emp where sal > (select avg(sal) from emp);
select round(avg(sal)) from emp;

select deptno, round(avg(sal)) from emp group by deptno;
-- 회사평균 2017, 10번 2917, 20번 2175, 30번 1567

-- 본인의 부서 평균보다 많이 받는 사람
-- main query와 sub query의 데이터를 비교하여 처리하는 sql을 상관관계 query
select ename, sal from emp e1 where sal > (select avg(sal) from emp e2 where e1.deptno = e2.deptno);
-- sub query 내부의 별칭은 생략 가능
select ename, sal from emp e where sal > (select avg(sal) from emp where e.deptno = deptno);

-- main query 데이터 한건을 읽어서 그 데이터의 사번이 sub query의 테이블에 mgr에 없으면 출력
-- 밑에 직원이 있으면 (즉 관리자면) 출력
select empno, ename, sal from emp e where exists (select empno from emp where e.empno = mgr); -- 이해안감
select empno, ename, sal from emp e where not exists (select empno from emp where e.empno = mgr);
----------------------------------------------------------------------------------------------------------

--(모름)--  exists !!!!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!
select * from emp;
1. 자기 업무급여 평균보다 많이 받는 사람의 이름, 급여, 업무
select ename, sal, job from emp e where sal > (select avg(sal) from emp where e.job = job);

2. 자기 부서 평균보다 많이 받는 사람의 이름, 급여, 부서코드, 부서명
select ename, sal, e.deptno, dname from emp e, dept d where e.deptno = d.deptno 
and sal > (select avg(sal) from emp where e.deptno = deptno);

3. exists 사용하여 관리자 출력
select * from emp e where exists (select empno from emp where e.empno = mgr);

4. exists 사용하지 않고 관리자만 출력
select * from emp where empno in (select mgr from emp);

5. exists 사용하여 말단 직원 출력
select * from emp e where not exists (select empno from emp where e.empno = mgr);

6. exists 사용하지 않고 말단 직원 출력
select * from emp where empno not in (select mgr from emp where mgr is not null);

7. 회사 평균보다 급여를 많이 받는 사람 이름, 급여, 부서명, 급여등급, 부서명순, 급여큰순
select ename, sal, dname, grade from emp e, dept d, salgrade where e.deptno = d.deptno
and e.sal between losal and hisal and sal > (select avg(sal) from emp) order by dname, sal desc;

----------------------------------------------------------------------------------------------------------
--1. EMP 테이블에서 Blake와 같은 부서에 있는 모든 사원의 이름과 입사일자를 출력하는 SELECT문을 작성하시오.
--2. EMP 테이블에서 평균 급여 이상을 받는 모든 종업원에 대해서 종업원 번호와 이름을 출력하는 SELECT문을 작성하시오. 단 급여가 많은 순으로 출력하여라.
--3. EMP 테이블에서 이름에 “T”가 있는 사원이 근무하는 부서에서 근무하는 모든 종업원에 대해 사원 번호,이름,급여를 출력하는 SELECT문을 작성하시오. 
--단 사원번호 순으로 출력하여라.
--4. EMP 테이블에서 부서 위치가 Dallas인 모든 종업원에 대해 이름,업무,급여를 출력하는 SELECT문을 작성하시오.
--5. EMP 테이블에서 King에게 보고하는 모든 사원의 이름과 급여를 출력하는 SELECT문을 작성하시오.
--6. EMP 테이블에서 SALES부서 사원의 이름,업무를 출력하는 SELECT문을 작성하시오.
--7. EMP 테이블에서 월급이 부서 30의 최저 월급보다 높은 사원을 출력하는 SELECT문을 작성하시오.
--8. EMP 테이블에서 부서 10에서 부서 30의 사원과 같은 업무를 맡고 있는 사원의 이름과 업무를 출력하는 SELECT문을 작성하시오.
--9. EMP 테이블에서 FORD와 업무도 월급도 같은 사원의 모든 정보를 출력하는 SELECT문을 작성하시오


--1. EMP 테이블에서 Blake와 같은 부서에 있는 모든 사원의 이름과 입사일자를 출력하는 SELECT문을 작성하시오.
select ename, hiredate from emp where deptno = (select deptno from emp where ename = 'BLAKE');

--2. EMP 테이블에서 평균 급여 이상을 받는 모든 종업원에 대해서 종업원 번호와 이름을 출력하는 SELECT문을 작성하시오. 단 급여가 많은 순으로 출력하여라.
select empno, ename from emp where sal >= (select avg(sal) from emp) order by sal desc;

--3. EMP 테이블에서 이름에 “T”가 있는 사원이 근무하는 부서에서 근무하는 모든 종업원에 대해 사원 번호,이름,급여를 출력하는 SELECT문을 작성하시오.
--단 사원번호 순으로 출력하여라.
select empno, ename, sal from emp where deptno in (select deptno from emp where ename like '%T%') order by empno;

select * from dept;
--4. EMP 테이블에서 부서 위치가 Dallas인 모든 종업원에 대해 이름,업무,급여를 출력하는 SELECT문을 작성하시오.
select ename, job, sal from emp where deptno = (select deptno from dept where loc = 'DALLAS');

--5. EMP 테이블에서 King에게 보고하는 모든 사원의 이름과 급여를 출력하는 SELECT문을 작성하시오.
select ename, sal from emp where mgr in (select deptno from emp where ename ='KING');
-- select ename, sal from emp e where mgr = (select empno from emp where e.mgr = empno and mgr is null);
--select ename, sal from emp e where mgr in (select empno from emp where e.mgr = empno and ename = 'KING');

--6. EMP 테이블에서 SALES 부서 사원의 이름,업무를 출력하는 SELECT문을 작성하시오.
select ename, job from emp where deptno = (select deptno from dept where dname = 'SALES');

--7. EMP 테이블에서 월급이 부서 30의 최저 월급보다 높은 사원을 출력하는 SELECT문을 작성하시오.
select * from emp where sal > (select min(sal) from emp where deptno = 30);

--8. EMP 테이블에서 부서 10에서 부서 30의 사원과 같은 업무를 맡고 있는 사원의 이름과 업무를 출력하는 SELECT문을 작성하시오.
select ename, job from emp where deptno = 10 and job in (select job from emp where deptno = 30);

--(모름)-- --9. EMP 테이블에서 FORD와 업무도 월급도 같은 사원의 모든 정보를 출력하는 SELECT문을 작성하시오
select * from emp where (job, sal) = (select job, sal from emp where ename = 'FORD') and ename != 'FORD';
--select * from emp where job = (select job from emp where ename = 'FORD') and sal =(select sal from emp where ename = 'FORD');

----------------------------------------------------------------------------------------------------------
--10. EMP 테이블에서 업무가 JONES와 같거나 월급이 FORD이상인 사원의 정보를 이름,업무,부서번호,급여를 출력하는 SELECT문을 작성
--단 업무별, 월급이 많은 순으로 출력하여라.
select ename, job, deptno, sal from emp where job = (select job from emp where ename = 'JONES' ) or
sal >= (select sal from emp where ename = 'FORD') order by job, sal desc;

--11. EMP 테이블에서 SCOTT 또는 WARD와 월급이 같은 사원의 정보를 이름,업무,급여를 출력하는 SELECT문을 작성하시오.
select ename, job, sal from emp where sal in (select sal from emp where ename in('SCOTT', 'WARD'));

--12. EMP 테이블에서 CHICAGO에서 근무하는 사원과 같은 업무를 하는 사원의 이름,업무를 출력하는 SELECT문을 작성하시오.
select ename, job from emp where job in (select job from emp where deptno = (select deptno from dept where loc ='CHICAGO'));

--(모름)-- --13. EMP 테이블에서 부서별로 월급이 평균 월급보다 높은 사원을 부서번호,이름,급여를 출력하는 SELECT문을 작성하시오. 
select deptno, ename, sal from emp e where sal > (select avg(sal) from emp where e.deptno = deptno);

--(모름)-- --14. EMP 테이블에서 업무별로 월급이 평균 월급보다 낮은 사원을 부서번호,이름,급여를 출력하는 SELECT문을 작성하시오.
select deptno, ename, sal from emp e where sal < (select avg(sal) from emp where e.job = job);

--15. EMP 테이블에서 적어도 한명 이상으로부터 보고를 받을 수 있는 사원을 업무,이름,사원번호,부서번호를 출력하는 SELECT문을 작성하시오.
select job, ename, empno, deptno from emp e where exists (select * from emp where e.empno = mgr);
select job, ename, empno, deptno from emp e where empno in (select mgr from emp);


--16. EMP 테이블에서 말단 사원의 사원번호,이름,업무,부서번호를 출력하는 SELECT문을 작성하시오
select job, ename, empno, deptno from emp e where not exists (select * from emp where e.empno = mgr);
select job, ename, empno, deptno from emp e where empno not in (select mgr from emp where mgr is not null);
----------------------------------------------------------------------------------------------------------

-- DB명(schema).table명
create table emp_test (
    empid varchar2(5) primary key,
    firstname varchar2(10),
    LASTNAME varchar2(10),
    salary number(7)
    );

-- 테이블 삭제 (drop table table명;)
drop table a;
drop table emp_test;

--08.CreateTable.pdf 9페이지 연습문제
create table MY_DATA1 (
    id number(4) primary key not null,
    name varchar2(10),
    userid varchar2(30),
    salary number(10,2)
    );
    
drop table MY_DATA1;

-- 기존에 있는 테이블을 조합해서 만들 수 있다.
create table emp1 as select * from emp;
select * from emp1;
create table emp2 as select empno, ename, hiredate, sal from emp;
select * from emp2;
drop table emp1;

-- char(100) character 고정 1, 10, 100 = 100 byte 공간
-- varchar(100) variable character 변동 1byte, 10byte, 100byte 
-- 저장길이를 확인 2byte가 존재
-- => oracle에서 varchar를 개선해서 varchar2로 만들었음

-- number(7) 정수 7자리
-- number(10,2) 숫자가 총 10자리, 소숫점 이하 2자리
-- number 정수 38자리 (default)
    

create table emp01 (
     empno number(4),
     ename varchar(20),
     sal number(7,2));

drop table emp01;

CREATE TABLE DEPT01 (
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)); --= varchar  13자리
    
drop table dept01;
    
CREATE TABLE EMP03 
AS 
SELECT EMPNO, ENAME FROM EMP;

select * from emp03;

-- 08.CreateTable.pdf 연습문제 22p
create table emp04 
as 
select empno, ename, sal from emp;

select * from emp04;

create table emp05 as select * from emp where deptno = 10;
select * from emp05;

-- 테이블 구조만 복사 : where false가 되는 조건으로 작성
create table emp01 as select * from emp where 1 = 0;
-- 데이터는 없고 컬럼명만 데이터 유형만 복사
select * from emp01;
desc emp01;

drop table emp01;

create table dept02 as select * from dept where 1 = 0;
desc dept02;


create table emp01 (
    empno number(4) primary key,
    ename varchar2(20) default '아무개',
    sal number(5) default 1000
    );
    
desc emp01;
-- 입력
-- insert into table명 values(값,....); : 모든 컬럼의 데이터를 값에 채워야 한다.
-- insert into table명 (컬럼,....) values(값,....); : 컬럼에 있는 데이터만 입력
insert into emp01 values(1, '로제', 2000);
select * from emp01;
insert into emp01 (empno, ename) values(2, '제니');
insert into emp01 (empno, sal) values(3, 3000);

select * from emp01;
alter table emp01 add (job varchar2(20), hiredate date); -- 컬럼을 추가할때
select * from emp01;
alter table emp01 modify(job varchar2(15)); -- 컬럼을 변경할때
desc emp01;

drop table emp01;
drop table dept02;
--------------------------------------------------------------------
--08.CreateTable.pdf 30p 연습문제

--1. EMP01 테이블에 문자 타입의 직급(JOB) 칼럼을 추가
--2. DEPT02 테이블에 문자 타입의 부서장(DMGR) 칼럼을 추가
--3. emp01 테이블에서 직급(JOB) 칼럼을 최대 30글자까지 저장할 수 있게
--변경해 보도록 하자. 
--4. DEPT02 테이블의 부서장(DMGR) 칼럼을 숫자 타입으로 변경해 봅시다.

create table emp01 as select empno, ename, sal from emp where 1=0;
create table dept02 as select * from dept where 1 = 0;

--1. EMP01 테이블에 문자 타입의 직급(JOB) 칼럼을 추가
alter table emp01 add (job varchar2(20));
select * from emp01;
desc emp01;

--2. DEPT02 테이블에 문자 타입의 부서장(DMGR) 칼럼을 추가
alter table dept02 add (dmgr varchar2(20));
desc dept02;

--3. emp01 테이블에서 직급(JOB) 칼럼을 최대 30글자까지 저장할 수 있게
--변경해 보도록 하자. 
alter table emp01 modify (job varchar2(30));
desc emp01;

--4. DEPT02 테이블의 부서장(DMGR) 칼럼을 숫자 타입으로 변경해 봅시다.
alter table dept02 modify (dmgr number(20));
desc dept02;




alter table emp01 add (job varchar2(30));
