
-- deptno 10번 회계팀, 20번 연구소, 30번 영업팀, 기타 운영팀
select ename, job, deptno, case deptno when 10 then '회계팀' when 20 then '연구소' when 30 then '영업팀'
 else '운영팀' end 부서명 from emp;
 
 -- 위와 똑같은 결과 출력
select ename, job, deptno, decode(deptno, 10,'회계팀',20,'연구소',30,'영업팀','운영팀') 부서명 from emp;
 
 -- 중첩함수
select deptno, dname, rpad(rtrim(dname, 'G'),10,'*') from dept;

select ename, sal, hiredate, extract(year from hiredate), extract(month from hiredate),
extract(day from hiredate) from emp;

-- 2월에 입사한 사람
select * from emp where extract(month from hiredate) = 02;
select * from emp where to_char(hiredate, 'mm') = 02;
-------------------------------------------------------------------------------------------------------------

--1. 현재 날짜를 출력하고 열 레이블은 Current Date로 출력하는 SELECT 문장을 기술하시오.
--2. EMP 테이블에서 현재 급여에 15%가 증가된 급여를 사원번호,이름,업무,급여,증가된 급여(New Salary),증가액(Increase)를
--출력하는 SELECT 문장을 기술하시오.
--3. EMP 테이블에서 이름,입사일,입사일로부터 6개월 후 돌아오는 월요일 구하여 출력하는 SELECT 문장을 기술하시오.
--4. EMP 테이블에서 이름,입사일, 입사일로부터 현재까지의 월수,급여, 입사일부터 현재까지의 급여의 총계를 출력하는 SELECT 문장을 기술하시오.
--5. EMP 테이블에서 모든 사원의 이름과 급여(15자리로 출력 좌측의 빈곳은 “*”로 대치)를 출력하는 SELECT 문장을 기술하시오.
--6. EMP 테이블에서 모든 사원의 정보를 이름,업무,입사일,입사한 요일을 출력하는 SELECT 문장을 기술하시오.
--7. EMP 테이블에서 이름의 길이가 6자 이상인 사원의 정보를 이름,이름의 글자수,업무를 출력하는 SELECT 문장을 기술하시오.
--8. EMP 테이블에서 모든 사원의 정보를 이름,업무,급여,보너스,급여+보너스를 출력하는 SELECT 문장을 기술하시오


--1. 현재 날짜를 출력하고 열 레이블은 Current Date로 출력하는 SELECT 문장을 기술하시오.
select sysdate "Current Date" from dual;

--2. EMP 테이블에서 현재 급여에 15%가 증가된 급여를 사원번호,이름,업무,급여,증가된 급여(New Salary),증가액(Increase)를
--출력하는 SELECT 문장을 기술하시오.
select empno, ename, job, sal, sal*1.15 "New Salary", sal*0.15 Increase from emp;

--3. EMP 테이블에서 이름,입사일,입사일로부터 6개월 후 돌아오는 월요일 구하여 출력하는 SELECT 문장을 기술하시오.
select ename, hiredate, next_day(add_months(hiredate, 6), '월') from emp;

--4. EMP 테이블에서 이름,입사일, 입사일로부터 현재까지의 월수,급여, 입사일부터 현재까지의 급여의 총계를 출력하는 SELECT 문장을 기술하시오.
select ename, hiredate, round(months_between(sysdate, hiredate)) 월수, sal, 
sal * round(months_between(sysdate, hiredate)) 급여총계 from emp;

--5. EMP 테이블에서 모든 사원의 이름과 급여(15자리로 출력 좌측의 빈곳은 “*”로 대치)를 출력하는 SELECT 문장을 기술하시오.
select ename, sal, lpad(sal, 15, '#') from emp;

--6. EMP 테이블에서 모든 사원의 정보를 이름,업무,입사일,입사한 요일을 출력하는 SELECT 문장을 기술하시오.
select ename, job, hiredate, to_char(hiredate, 'day') from emp;

--7. EMP 테이블에서 이름의 길이가 6자 이상인 사원의 정보를 이름,이름의 글자수,업무를 출력하는 SELECT 문장을 기술하시오.
select ename, length(ename), job from emp where length(ename) >= 6;

--8. EMP 테이블에서 모든 사원의 정보를 이름,업무,급여,보너스,급여+보너스를 출력하는 SELECT 문장을 기술하시오
select ename, job, sal, comm, nvl(sal+comm, 0) from emp;

--1. 사원 테이블의 사원명에서 2번째 문자부터 3개의 문자를 추출하시오.
--2. 사원 테이블에서 입사일이 12월인 사원의 사번, 사원명, 입사일을 검색하시오.
--3. 사번, 이름, 급여(10자리 왼쪽에 *)
--4. 사번, 이름, 입사일 년4-월-일
--6. 사원 테이블에서 급여에 따라 사번, 이름, 급여, 등급을 검색하는 SQL문장을 작성 (case, decode) 
--급여 등급
--0 ~ 999 E    1000 ~ 1999 D    2000 ~ 2999 C   3000 ~ 3999 B   4000 이상 A
----7. EMP 테이블에서 다음의 결과가 출력되도록 작성하시오.
--Sal의 값이 3배가 되도록 출력
--Dream Salary
--------------------------------------------------------------

--KING earns $5,000.00 monthly but wants $15,000.00
--BLAKE earns $2,850.00 monthly but wants $8,550.00
--CLARK earns $2,450.00 monthly but wants $7,350.00

--5. 사원 테이블에서 급여에 따라 사번, 이름, 급여, 등급을 검색하는 SQL 문장을 작성하시오. (Hint : CASE 함수 사용, decode)
--0 ~ 1000 E    1001 ~ 2000 D    2001 ~ 3000 C   3100 ~ 4000 B   4001 ~ 5000 A





--1. 사원 테이블의 사원명에서 2번째 문자부터 3개의 문자를 추출하시오.
select ename, substr(ename,2,3) from emp;

--2. 사원 테이블에서 입사일이 12월인 사원의 사번, 사원명, 입사일을 검색하시오.
select empno, ename, hiredate from emp where substr(hiredate,4,2) = 12;
select empno, ename, hiredate from emp where to_char(hiredate, 'mm') = 12;

--3. 사번, 이름, 급여(10자리 왼쪽에 *)
select empno, ename, sal, lpad(sal, 10, '#') from emp;

--4. 사번, 이름, 입사일 년4-월-일
select empno, ename, to_char(hiredate, 'yyyy-mm-dd') from emp;

--6. 사원 테이블에서 급여에 따라 사번, 이름, 급여, 등급을 검색하는 SQL문장을 작성 (case, decode) 
--급여 등급
--0 ~ 999 E    1000 ~ 1999 D    2000 ~ 2999 C   3000 ~ 3999 B   4000 이상 A
select empno, ename, sal, case trunc(sal/1000) when 0 then 'E' when 1 then 'D' when 2 then 'C'
when 3 then 'B' else 'A' end 등급 from emp;
-- trunc :소수점 이하를 버림
select empno, ename, sal, decode(trunc(sal/1000),0,'E',1,'D',2,'C',3,'B','A') 등급 from emp;

select empno, ename, sal, case when sal between 0 and 999 then 'E' when sal between 1000 and 1999 then 'D' 
when sal between 2000 and 2999 then 'C' when sal between 3000 and 3999 then 'B' else 'A' end 등급 from emp;

----7. EMP 테이블에서 다음의 결과가 출력되도록 작성하시오.
--Sal의 값이 3배가 되도록 출력
--Dream Salary
--------------------------------------------------------------
--KING earns $5,000.00 monthly but wants $15,000.00
--BLAKE earns $2,850.00 monthly but wants $8,550.00
--CLARK earns $2,450.00 monthly but wants $7,350.00

select ename ||' earns' || to_char(sal, '$9,999.00') || ' monthly but wants ' || to_char(sal*3, '$99,999.00') 
"Dream Salary" from emp;


--5. 사원 테이블에서 급여에 따라 사번, 이름, 급여, 등급을 검색하는 SQL 문장을 작성하시오. (Hint : CASE 함수 사용, decode)
--0 ~ 1000 E    1001 ~ 2000 D    2001 ~ 3000 C   3100 ~ 4000 B   4001 ~ 5000 A
select empno, ename, sal, case trunc((sal-1)/1000) when 0 then 'E' when 1 then 'D' when 2 then 'C'
when 3 then 'B' else 'A' end 등급 from emp;

select empno, ename, sal, decode(trunc((sal-1)/1000),0,'E',1,'D',2,'C',3,'B','A') 등급 from emp;
--------------------------------------------------------------
                         -- king부터 시작             king사번  상대방 관리자 사번
select ename from emp start with mgr is null connect by prior empno = mgr;
-- top -> down left -> right
select lpad(ename, length(ename)+(level*3)-3, ' ') 이름 from emp start with mgr is null connect by prior empno = mgr;
select lpad(ename, length(ename)+(level*2)-2, ' ') 이름 from emp start with mgr is null connect by prior empno = mgr;
select lpad(ename, length(ename)+(level*3)-3, ' ') 이름 from emp start with ename = 'KING' connect by prior empno = mgr;

--- adams 기준으로 직계를 보여줌
select lpad(ename, length(ename)+(level*3)-3, ' ') 이름 from emp start with ename='ADAMS' connect by prior mgr = empno;

-- FORD line 없애기
select lpad(ename, length(ename)+(level*3)-3, ' ') 이름 from emp start with ename='KING' connect by prior empno = mgr
and ename != 'FORD';

-- FORD만 없애기
select lpad(ename, length(ename)+(level*3)-3, ' ') 이름 from emp where ename != 'FORD' start with ename='KING' connect by prior empno = mgr;

--------------------------------------------------------------------
--- 조인 면접에서 많이 물어봄
select * from emp;
select empno, ename, job, dname, loc from emp, dept where emp.deptno = dept.deptno;
--select empno, ename, job, deptno, dname, loc from emp, dept where emp.deptno = dept.deptno; 에러 발생
select emp.empno, emp.ename, emp.job, emp.deptno, dept.dname, dept.loc from emp, dept where emp.deptno = dept.deptno; 
-- e, d 테이블 별칭 table alias -> alias
select e.empno, e.ename, e.job, e.deptno, d.dname, d.loc from emp e, dept d where e.deptno = d.deptno; 
-- 한쪽 테이블에만 존재하는 칼럼은 테이블명 생략 가능
select empno, ename, job, e.deptno, dname, loc from emp e, dept d where e.deptno = d.deptno; 

-- 카티션 프로덕트 , cross join   총 경우의 수 출력 -- 14 x 4 = 56
select empno, ename, job, e.deptno, dname, loc from emp e, dept d;  
--------------------------------------------------------------------
--1. 사번, 이름, 업무, 입사일, 부서명
--2. 이름, 업무, 입사일, 부서명, 근무지 81년 입사만
--3. 이름, 업무, 입사일, 부서코드, 부서명, comm이 null
--4. 이름, 업무, 부서코드, 부서명,근무지, 근무지가 DALLAS
--5. 이름, 업무, 부서명, 근무지 업무가 manager이거나 clerk인 사람
--6. 이름, 업무, 부서명, 급여, comm, 연봉(=(급여+comm)*12 comm이 null이면 0) 연봉 큰 순
--7. 사번, 이름, 업무, 부서코드, 부서명, 급여  급여가 1000 ~ 3000 사이 부서명 순, 급여 큰 순
--8. 사번, 이름, 급여, 커미션, 연봉(comm이 null이면 0), 부서코드, 부서명, 근무지, 부서코드 순, 급여작은 순
--9. 사번, 이름, 업무, 급여, 부서명, 근무지  부셔명이 reserach인 경우 급여 큰 순


desc emp;
desc dept;

--1. 사번, 이름, 업무, 입사일, 부서명
select empno, ename, job, hiredate, dname from emp e, dept d where e.deptno = d.deptno;

--2. 이름, 업무, 입사일, 부서명, 근무지 81년 입사만
select ename, job, hiredate, dname, loc from emp e, dept d where e.deptno = d.deptno and to_char(hiredate, 'yy') = 81;

--3. 이름, 업무, 입사일, 부서코드, 부서명, comm이 null
select ename, job, hiredate, e.deptno, dname from emp e, dept d where e.deptno = d.deptno and comm is null;

--4. 이름, 업무, 부서코드, 부서명, 근무지, 근무지가 DALLAS
select ename, job, e.deptno, dname, loc from emp e, dept d where e.deptno = d.deptno and loc = 'DALLAS';

--5. 이름, 업무, 부서명, 근무지 업무가 manager이거나 clerk인 사람
select ename, job, dname, loc from emp e, dept d where e.deptno = d.deptno and lower(job) in ('manager','clerk');

--6. 이름, 업무, 부서명, 급여, comm, 연봉(=(급여+comm)*12 comm이 null이면 0) 연봉 큰 순
select ename, job, dname, sal, comm, (sal+nvl(comm, 0))*12 연봉 from emp e, dept d where e.deptno = d.deptno order by 연봉 desc;

--7. 사번, 이름, 업무, 부서코드, 부서명, 급여  급여가 1000 ~ 3000 사이 부서명 순, 급여 큰 순
select empno, ename, job, e.deptno, dname, sal from emp e, dept d where e.deptno = d.deptno and sal between 1000 and 3000 
order by dname, sal desc;

--8. 사번, 이름, 급여, 커미션, 연봉(comm이 null이면 0), 부서코드, 부서명, 근무지, 부서코드 순, 급여작은 순
select empno, ename, sal, comm, (sal+nvl(comm, 0))*12 연봉, e.deptno, dname, loc from emp e, dept d where e.deptno = d.deptno
order by e.deptno, sal;

--9. 사번, 이름, 업무, 급여, 부서명, 근무지  부셔명이 reserach인 경우 급여 큰 순
select empno, ename, job, sal, dname, loc from emp e, dept d where e.deptno = d.deptno and dname = 'research' order by sal desc;

