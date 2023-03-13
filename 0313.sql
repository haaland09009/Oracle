-- 그룹 함수 종류 : MAX, MIN, SUM, AVG, COUNT
select sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp;
select sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp where deptno = 10;
select sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp where deptno = 20;
select sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp where deptno = 30;
-- ! 그룹함수와 같이 사용하는 칼럼은 반드시 group by에 있어야 한다. !
select deptno, sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp group by deptno;
--select deptno, sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp; 에러 발생

-- group by: 데이터가 같은 거끼리 뭉치는 것
select deptno, job, sum(sal), avg(sal), max(sal), min(sal), count(sal) from emp group by deptno, job order by deptno, job;
select deptno, job, sum(sal), avg(sal), max(sal), min(sal), count(*) from emp group by deptno, job order by deptno, job;

select sum(sal), avg(sal), sum(sal)/count(*) from emp;

-- !! 혼동 주의 !! -- 
-- sum(comm)/ count(comm) :  커미션을 받는 사람만, comm이 null인 사람은 제외
-- sum(comm)/count(*), sum(nvl(comm,0))/count(*) : comm을 안 받는 사람까지 합계
-- 가능한 data에서는 null이 없는 것이 좋다
select sum(comm), avg(comm),sum(comm)/count(comm), sum(comm)/count(*), sum(nvl(comm,0))/count(*), avg(nvl(comm,0)) from emp;
------------------------------------------------------------------------------------------------------------------------------
--1. 부서별 급여합계, 급여 평균
--2. 업무별 최대 급여, 최소 급여
--3. 업무가 manager이거나 analyst인 사람의 급여합계, 급여평균
--4. 부서명, 급여합계, 최대 급여
--5. 부서명, 근무지, 급여합계, 인원수 부서명순
--6. 부서명, 최대급여, 최소급여, 인원수 comm이 null이 아닌 사람
--7. 업무별 최대급여, 최소급여, 인원수 업무별 정렬
--8. 부서명, 업무명, 최대급여, 최소급여, 인원수 부서명순, 업무별 순 정렬
--9. 전직원 급여합계, 최대급여, 최소급여, 인원수


--1. 부서별 급여합계, 급여 평균
select deptno, sum(sal), avg(nvl(sal,0)), avg(sal) from emp group by deptno;

--2. 업무별 최대 급여, 최소 급여
select job, max(sal), min(sal) from emp group by job;

--3. 업무가 manager이거나 analyst인 사람의 급여합계, 급여평균
select job, sum(sal), avg(sal) from emp where lower(job) in ('manager','analyst') group by job;
select sum(sal), avg(sal) from emp where lower(job) in ('manager','analyst');

desc dept;
desc emp;

--4. 부서명, 급여합계, 최대 급여
select dname, sum(sal), max(sal) from emp e, dept d where e.deptno = d.deptno group by dname;

--5. 부서명, 근무지, 급여합계, 인원수 부서명순
select dname, loc, sum(sal), count(*) from emp e, dept d where e.deptno = d.deptno group by dname, loc order by dname;

--6. 부서명, 최대급여, 최소급여, 인원수 comm이 null이 아닌 사람
select dname, max(sal), min(sal), count(*) from emp e, dept d where e.deptno = d.deptno and comm is not null group by dname;

--7. 업무별 최대급여, 최소급여, 인원수 업무별 정렬
select job, max(sal), min(sal), count(*) from emp group by job order by job;

--8. 부서명, 업무명, 최대급여, 최소급여, 인원수 부서명순, 업무별 순 정렬
select dname, job, max(sal), min(sal), count(*) from emp e, dept d where e.deptno = d.deptno group by dname, job 
order by dname, job; 

-- count(*) : ex) 해당 컬럼에서 급여를 안 받는 사람까지 센다.

--9. 전직원 급여합계, 최대급여, 최소급여, 인원수
select sum(sal), max(sal), min(sal), count(*) from emp;
------------------------------------------------------------------------------------------------------------------------------

-- select 컬럼,... from table명,... where 조건(테이블로부터 추출) group by 컬럼/식 having 조건(그룹함수에 대한 조건) order by 컬럼/순서/별칭/식;
-- group by에는 순서 별칭을 쓸 수 없다.

-- 부서별 인원수가 4명 이상인 부서의 최대급여, 급여합계, 인원수
select deptno, max(sal), sum(sal), count(*) from emp where count(*) >= 4 group by deptno;  -- 에러 발생
-- 왜 에러가 발생할까?
-- where는 테이블로부터 데이터를 추출하는 조건 : 테이블로부터 추출할 때 check -> 다 꺼내봐야 알 수 있는데 아직 안꺼냈으므로
-- 어떻게 해결할 수 있는지?
-- !!! having은 그룹함수에 대한 조건 (where 절: 그룹에 대한 조건, having: 그룹함수에 대한 조건) !!!
--- ! 그룹에 대한 조건은 where절에 작성하면 안된다 !
select deptno, max(sal), sum(sal), count(*) from emp group by deptno having count(*) >= 4; 

-- 중첩함수 : 함수를 2개 이상 겹쳐 사용 (oracle만 중첩함수 밑과 같이 사용가능)
select max(max(sal)), min(min(sal)), min(min(sal)), max(min(sal))  from emp group by deptno;
------------------------------------------------------------------------------------------------------------------------------
--1. 부서별, 급여합계, 최대급여, 최대급여가 2900 이상
select deptno, sum(sal), max(sal) from emp group by deptno having max(sal) >= 2900;

--2. 업무별, 급여합계, 최대급여, 인원수가 3명 이상인 업무
select job, sum(sal), max(sal), count(*) from emp group by job having count(*) >= 3;

--3. 업무별 최대급여 중 가장 많은 급여와 가장 적은 급여
select max(max(sal)), min(max(sal)) from emp group by job;

--4. 부서별 급여합계 중에 최소급여, 최대급여, 최대인원
select min(sum(sal)), max(sum(sal)), max(count(*)) from emp group by deptno;

--5. 부서명, 급여합계 급여합계가 9000이상인 부서
select dname, sum(sal) from emp e, dept d where e.deptno = d.deptno group by dname having sum(sal) >= 9000;

--6. 부서명, 평균급여(소숫점 1자리 반올림) 평균 급여가 2000 이상인 부서 부서명순 정렬
select dname, round(avg(sal), 1) from emp e, dept d where e.deptno = d.deptno group by dname having avg(sal)>= 2000 order by dname;
------------------------------------------------------------------------------------------------------------------------------
--1. EMP 테이블에서 인원수,최대 급여,최소 급여,급여의 합을 계산하여 출력하는 SELECT 문장을 작성하여라.
--2. EMP 테이블에서 각 업무별로 최대 급여,최소 급여,급여의 합을 출력하는 SELECT 문장을 작성하여라.
--3. EMP 테이블에서 업무별 인원수를 구하여 출력하는 SELECT 문장을 작성하여라.
--4. EMP 테이블에서 최고 급여와 최소 급여의 차이는 얼마인가 출력하는 SELECT 문장을 작성하여라.
--5. EMP 테이블에서 아래의 결과를 출력하는 SELECT 문장을 작성하여라

--1. EMP 테이블에서 인원수,최대 급여,최소 급여,급여의 합을 계산하여 출력하는 SELECT 문장을 작성하여라.
select count(*), max(sal), min(sal), sum(sal) from emp;

--2. EMP 테이블에서 각 업무별로 최대 급여,최소 급여,급여의 합을 출력하는 SELECT 문장을 작성하여라.
select job, max(sal), min(sal), sum(sal) from emp group by job;

--3. EMP 테이블에서 업무별 인원수를 구하여 출력하는 SELECT 문장을 작성하여라.
select job, count(*) from emp group by job;

--4. EMP 테이블에서 최고 급여와 최소 급여의 차이는 얼마인가 출력하는 SELECT 문장을 작성하여라.
select max(sal) - min(sal)급여차이 from emp;

--5. EMP 테이블에서 아래의 결과를 출력하는 SELECT 문장을 작성하여라 (집계함수와 groupby.pdf 29페이지 연습문제 5번)
SELECT to_char(hiredate, 'yy') "H_YEAR", COUNT(*), MIN(SAL), MAX(SAL), AVG(SAL), SUM(SAL) FROM EMP
GROUP BY to_char(hiredate, 'yy')ORDER BY to_char(hiredate, 'yy') ;

--6
select sum(count(*)) TOTAL, sum(decode(to_char(hiredate, 'yy'), 80, count(*))) "1980",
sum(decode(to_char(hiredate, 'yy'), 81, count(*))) "1981", sum(decode(to_char(hiredate, 'yy'), 82, count(*))) "1982",
sum(decode(to_char(hiredate, 'yy'), 83, count(*))) "1983" from emp group by hiredate;

--7
select job, sum(decode(deptno, 10, sal)) "Deptno 10", sum(decode(deptno, 20, sal)) "Deptno 20", 
sum(decode(deptno, 30, sal)) "Deptno 30", sum(sal) Total from emp group by job order by job;
------------------------------------------------------------------------------------------------------------------------------

select deptno, job, sum(sal) from emp group by deptno, job order by deptno, job;
select deptno, job, sal from emp order by deptno, job;

-- 위의 코드를 피벗 테이블로 보기 쉽게 바꾸는 것이 목표
select deptno, sum(decode(job,'CLERK',sal)) CLERK, sum(decode(job,'MANAGER',sal)) MANAGER, 
sum(decode(job,'PRESIDENT',sal)) PRESIDENT, sum(decode(job,'ANALYST',sal)) ANALYST, sum(decode(job,'SALESMAN',sal)) SALESMAN 
from emp group by deptno order by deptno;

-- 세로 합계
select deptno, sum(decode(job,'CLERK',sal)) CLERK, sum(decode(job,'MANAGER',sal)) MANAGER, 
sum(decode(job,'PRESIDENT',sal)) PRESIDENT, sum(decode(job,'ANALYST',sal)) ANALYST, sum(decode(job,'SALESMAN',sal)) SALESMAN, 
sum(sal)합계 from emp group by deptno order by deptno;
-- 가로 합계
select deptno, sum(decode(job,'CLERK',sal)) CLERK, sum(decode(job,'MANAGER',sal)) MANAGER, 
sum(decode(job,'PRESIDENT',sal)) PRESIDENT, sum(decode(job,'ANALYST',sal)) ANALYST, sum(decode(job,'SALESMAN',sal)) SALESMAN, 
sum(sal) 합계 from emp group by rollup(deptno) order by deptno;

------------------------------------------------------------------------------------------------------------------------------
--(집계함수와 groupby.pdf 35페이지)
--1. 사원테이블에서 최대급여, 최소급여, 전체 급여합, 평균을 구하시오
--2. 사원테이블에서 부서별 인원수를 구하시오
--3. 사원테이블에서 부서별 인원수가 6명 이상인 부서코드를 구하시오
--4. 사원테이블에서 다음과 같은 결과가 나오게 하시오
--5. 사원테이블에서 급여가 높은 순서대로 등수를 부여하여 다음과 같은 결과가 나오게 하시오.  힌트 self join, group by, count사용

--1. 사원테이블에서 최대급여, 최소급여, 전체 급여합, 평균을 구하시오
select max(sal), min(sal), sum(sal), avg(sal) from emp;

--2. 사원테이블에서 부서별 인원수를 구하시오
select deptno, count(*) 인원수 from emp group by deptno;

--3. 사원테이블에서 부서별 인원수가 6명 이상인 부서코드를 구하시오
select deptno, count(*) from emp group by deptno having count(*) >= 6;

--4. 사원테이블에서 다음과 같은 결과가 나오게 하시오
select dname,  sum(decode(job,'CLERK',sal)) CLERK, sum(decode(job,'MANAGER',sal)) MANAGER,
sum(decode(job,'PRESIDENT',sal)) PRESIDENT, sum(decode(job,'ANALYST',sal)) ANALYST, sum(decode(job,'SALESMAN',sal)) SALESMAN
from emp e, dept d where e.deptno = d.deptno group by dname order by dname;

--5. 사원테이블에서 급여가 높은 순서대로 등수를 부여하여 다음과 같은 결과가 나오게 하시오.  힌트 self join, group by, count사용
select e1.ename, count(e2.sal) + 1 등수 from emp e1, emp e2 where e1.sal < e2.sal(+) group by e1.ename order by 등수;

select ename, rank() over (order by sal desc) 등수 from emp;
