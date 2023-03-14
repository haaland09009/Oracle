-- 가로 합계
select deptno, sum(decode(job,'CLERK',sal)) CLERK,
sum(decode(job,'MANAGER',sal)) MANAGER, 
sum(decode(job,'PRESIDENT',sal)) PRESIDENT,
sum(decode(job,'ANALYST',sal)) ANALYST,
sum(decode(job,'SALESMAN',sal)) SALESMAN, 
sum(sal) 합계 from emp group by rollup(deptno) order by deptno;

-- rollup과 cube는 위 코드는 같은 결과가 나왔으나 다른 것임.
select deptno, sum(decode(job,'CLERK',sal)) CLERK,
sum(decode(job,'MANAGER',sal)) MANAGER, 
sum(decode(job,'PRESIDENT',sal)) PRESIDENT,
sum(decode(job,'ANALYST',sal)) ANALYST,
sum(decode(job,'SALESMAN',sal)) SALESMAN, 
sum(sal) 합계 from emp group by CUBE(deptno) order by deptno;

select deptno, sum(sal) from emp group by deptno order by deptno;
select deptno, sum(sal) from emp group by rollup(deptno) order by deptno;
select deptno, sum(sal) from emp group by cube(deptno) order by deptno;

select deptno,job,sum(sal) from emp group by deptno,job order by deptno;
select deptno, job,sum(sal) from emp group by rollup(deptno,job) order by deptno;
select deptno, job,sum(sal) from emp group by cube(deptno,job) order by deptno;

-- GROUPING() 함수: 많이 사용하지 않음
select grouping(deptno), deptno, sum(sal) from emp group by rollup(deptno) order by deptno;

-- 서브 쿼리
-- 회사에서 제일 급여가 많은 사람의 이름과 급여
select ename, max(sal) from emp group by ename; --올바른 코드가 아님. 제대로 된 결과가 나오지 않음.
select ename, sal from emp;


-- 회사에서 제일 급여가 많은 사람의 이름과 급여
select max(sal) from emp;
select ename, sal from emp where sal = 5000;
-- 위의 코드는 두 문장으로 되어 있다. -> 한 문장으로 만들 필요가 있다.
            -- main query                -- sub query
select ename, sal from emp where sal = (select max(sal) from emp); -- 괄호 속에 코드를 넣으면 그 코드를 먼저 실행 -> 서브 쿼리

-- scott의 부서명
select dname from dept where deptno = (select deptno from emp where ename = 'SCOTT');

-------------------------------------------------------------------------------------------------------------
--1. 급여가 제일 적은 사람의 이름과 급여
--2. 가장 빨리 입사한 사람의 이름, 입사일, 급여, 급여등급
--3. 가장 최근에 입사한 사람의 이름, 급여, 급여등급, 부서명
--4. NEW YORK에 근무하는 사람의 모든 이름, 업무, 입사일, 부서코드
--5. ALLEN과 같은 업무를 수행하는 사람의 이름, 급여, 업무, COMM
--6. 회사 평균 급여보다 많이 받는 사람의 이름, 급여, 부서코드
--7. 회사 평균보다 적게 받는 사람의 이름, 급여, 부서명 부서명순
--8. RESEARCH 부서에 근무하는 사람의 이름, 급여, 업무, 급여등급, 부서명
--9. 81년에 입사한 사람 중에서 회사 급여 평균보다 급여를 많이 받는 사람의 이름, 급여, 부서명, 급여등급, 부서명순 정렬

--1. 급여가 제일 적은 사람의 이름과 급여
select ename, sal from emp where sal = (select min(sal) from emp);

--2. 가장 빨리 입사한 사람의 이름, 입사일, 급여, 급여등급
select ename, hiredate, sal, grade from emp, salgrade where sal between losal and hisal and
hiredate = (select min(hiredate) from emp);

--3. 가장 최근에 입사한 사람의 이름, 급여, 급여등급, 부서명
select ename, sal, grade, dname from emp e, dept d, salgrade where e.deptno = d.deptno and 
e.sal between losal and hisal and hiredate = (select max(hiredate) from emp);

--4. NEW YORK에 근무하는 사람의 모든 이름, 업무, 입사일, 부서코드
select ename, job, hiredate, d.deptno from emp e, dept d where e.deptno = d.deptno and loc = 'NEW YORK';
select ename, job, hiredate, deptno from emp where deptno = (select deptno from dept where loc = 'NEW YORK'); -- 정석 풀이

--5. ALLEN과 같은 업무를 수행하는 사람의 이름, 급여, 업무, COMM
select ename, sal, job, comm from emp where job = (select job from emp where ename = 'ALLEN');

--6. 회사 평균 급여보다 많이 받는 사람의 이름, 급여, 부서코드
select ename, sal, deptno from emp where sal > (select avg(sal) from emp);

--7. 회사 평균보다 적게 받는 사람의 이름, 급여, 부서명 부서명순
select ename, sal, dname from emp e, dept d where e.deptno = d.deptno and sal < (select avg(sal) from emp) order by dname;

--8. RESEARCH 부서에 근무하는 사람의 이름, 급여, 업무, 급여등급, 부서명
select ename, sal, job, grade, dname from emp e, dept d, salgrade where e.deptno = d.deptno 
and e.sal between losal and hisal and dname = 'RESEARCH';

--9. 81년에 입사한 사람 중에서 회사 급여 평균보다 급여를 많이 받는 사람의 이름, 급여, 부서명, 급여등급, 부서명순 정렬
select ename, e.sal, dname, grade from emp e, dept d, salgrade where e.deptno = d.deptno and e.sal between losal and hisal
and to_char(hiredate, 'yy') = '81' and sal > (select avg(sal) from emp) order by dname;

-------------------------------------------------------------------------------------------------------------
--1. 사원 테이블에서 BLAKE보다 급여가 많은 사원들의 사번, 이름, 급여
select empno, ename, sal from emp where sal > (select sal from emp where ename = 'BLAKE');

--2. 사원 테이블에서 MILLER보다 늦게 입사한 사원의 사번, 이름, 입사일
select empno, ename, hiredate from emp where hiredate > (select hiredate from emp where ename = 'MILLER');

--3. 사원 테이블에서 사원 전체 평균 급여보다 급여가 많은 사원들의 사번, 이름, 급여
select empno, ename, sal from emp where sal > (select avg(sal) from emp);

--4. 사원 테이블에서 CLERK과 같은 부서이며, 사번이 7698인 직원의 급여보다 많은 급여를 받는 사원들의 사번, 이름, 급여
select empno, ename, sal from emp where deptno = (select deptno from emp where ename ='CLERK') 
and sal > (select sal from emp where empno = '7698');

--5. 사원 테이블에서 부서별 최대 급여를 받는 사원들의 사번, 이름, 부서코드, 급여 (어려움)
select empno, ename, deptno, sal from emp where sal in (select max(sal) from emp group by deptno);
select empno, ename, deptno, sal from emp where sal = any(select max(sal) from emp group by deptno);
select empno, ename, deptno, sal from emp where sal = some(select max(sal) from emp group by deptno);
-------------------------------------------------------------------------------------------------------------
-- 07.SubQuery.pdf 12페이지 연습문제
--1. EMP 테이블에서 ename이 SCOTT인 데이터와 같은 부서(deptno)에서 근무하는 사원의 이름(ename)과 부서 번호(deptno)를 출력하는 SQL 문을 작성해 보시오.
select ename, deptno from emp where deptno = (select deptno from emp where ename = 'SCOTT');

--2. EMP 테이블에서 ename이 SCOTT와 데이터와 동일한 직급(JOB)을 가진 사원의 모든 컬럼을 출력하는 SQL 문을 작성해 보시오.
select * from emp where job = (select job from emp where ename = 'SCOTT');

--3. EMP 테이블에서 ename이 SCOTT인 데이터의 급여(SAL)와 동일하거나 더 많이 받는 사원명(ename)과 급여(sal)를 출력하시오.
select ename, sal from emp where sal >= (select sal from emp where ename = 'SCOTT') ;

--4. EMP 테이블에서 DEPT 테이블의 LOC가 DALLAS인 사원의 이름(ename), 부서 번호(deptno)를 출력하시오.
select ename, deptno from emp where deptno = (select deptno from dept where loc = 'DALLAS');
select ename, e.deptno from emp e, dept d where e.deptno = d.deptno and loc = 'DALLAS';

--5. EMP 테이블에서 DEPT 테이블의 dname이 SALES(영업부)인 부서에서 근무하는 사원의 이름(ename)과 급여(sal)를 출력하시오.
select ename, sal from emp where deptno = (select deptno from dept where dname = 'SALES');
SELECT ename, sal from emp e, dept d where e.deptno = d.deptno and dname = 'SALES';

--6. EMP 테이블에서 직속상관(mgr)의 이름이 KING인 사원의 이름(ename)과 급여(sal)를 출력하시오. 
select ename, sal from emp where mgr = (select empno from emp where ename = 'KING');
select e1.ename, e1.sal from emp e1, emp e2 where e1.mgr = e2.empno and e2.ename = 'KING'; 

-------------------------------------------------------------------------------------------------------------
select deptno, min(sal) from emp group by deptno;
-- !!! WHERE절뿐만 아니라 HAVING절에도 서브쿼리 사용 가능, 하지만 ORDER BY 절에는 서브쿼리를 사용할 수 없다. !!!
select deptno, min(sal) from emp group by deptno 
having min(sal) > (select min(sal) from emp where deptno = 20);

--select ename, sal from emp where sal = (select min(sal) from emp group by deptno); -- 값이 여러개이기 때문에 에러 발생

-------------------------------------------------------------------------------------------------------------
--1. 부서별로 입사일이 가장 빠른 사람의 이름과 입사일
--2. 업무별로 가장 급여를 많이 받는 사람의 이름과 급여
--3. 부서별로 급여가 가장 적은 사람의 이름, 업무, 급여, 부서명
--4. 업무별로 입사가 가장 빠른 사람의 이름, 업무, 입사일, 급여, 급여등급, 부서명

--1. 부서별로 입사일이 가장 빠른 사람의 이름과 입사일
select ename, hiredate from emp where hiredate in (select min(hiredate) from emp group by deptno);

--2. 업무별로 가장 급여를 많이 받는 사람의 이름과 급여
select ename, job, sal from emp where sal in (select max(sal) from emp group by job);

--3. 부서별로 급여가 가장 적은 사람의 이름, 업무, 급여, 부서명
select ename, job, sal, dname from emp e, dept d where e.deptno = d.deptno and 
sal in (select min(sal) from emp group by deptno);

----4. 업무별로 입사가 가장 빠른 사람의 이름, 업무, 입사일, 급여, 급여등급, 부서명 (job과 hiredate를 묶어서)
select ename, job, hiredate, sal, grade, dname from emp e, dept d, salgrade where e.deptno = d.deptno
and e.sal between losal and hisal and (job, hiredate) in (select job, min(hiredate) from emp group by job);

-- in 대신에 any, some으로 해도 된다
-------------------------------------------------------------------------------------------------------------

select ename, sal from emp where sal > (select min(sal) from emp where job = 'SALESMAN')
and job != 'SALESMAN';


select deptno, round(avg(sal)) from emp group by deptno order by deptno;

-- All
-- deptno avg(sal)
--10	2917
--20	2175
--30	1567

--1. 모든 부서의 평균급여보다 많이 받는 사람의 이름과 급여 -> 2917보다 많이 받는 사람
select ename, sal from emp where sal > all(select avg(sal) from emp group by deptno); -- 2917보다 많이 받는 사람
--2. 어느 부서나 평균보다도 급여를 많이 받는 사람의 이름과 급여 -> 1567보다 많이 받는 사람
select ename, sal from emp where sal > any(select avg(sal) from emp group by deptno); -- 1567보다 많은 사람

-- 위에 코드 수정 -> 권장하는 코드 (그룹함수 중첩, 오라클은 가능하지만 mysql에서는 안 됨)
select ename, sal from emp where sal > (select max(avg(sal)) from emp group by deptno); -- 2917보다 많이 받는 사람
select ename, sal from emp where sal > (select min(avg(sal)) from emp group by deptno); -- 2917보다 많이 받는 사람

-- 쌍 비교
select empno, sal, deptno from emp where (sal, deptno) in (select sal, deptno from emp where deptno = 30 
and comm is not null);

-- 나눠서 비교
--select empno, sal, deptno from emp where sal in (select sal from emp where deptno = 30 
--and comm is not null) and deptno in (select deptno from emp where deptno = 30 and comm is not null);

-- 쌍으로 비교한 것과 나눠서 비교한 것은 결과가 다름 (주의) -> 차이 원리 이해하기 
select empno, job, deptno from emp where (job, deptno) in (select job, deptno from emp where empno in (7369, 7499));
s
select empno, job, deptno from emp where job in (select job from emp where empno in (7369, 7499))
and deptno in (select deptno from emp where empno in (7369, 7499));

---------------
select empno, job, deptno from emp where empno in (7369, 7499);

--!! 주의 사항 !!
--1. parewise 비교 : 두개 컬럼 이상 같이 일치
--2. nonparewise 비교: 두개 컬럼 따로 따로 일치

-------------------------------------------------------------------------------------------------------------
--07.SubQuery.pdf 30페이지 연습문제
-- emp 테이블에서 부서별로 가장 급여를 많이 받는 사원의 사원 번호(empno), 사원이름(ename), 급여(sal), 부서번호(deptno)를 출력하시오.(IN 연산자 이용)
select empno, ename, sal, deptno from emp where sal in (select max(sal) from emp group by deptno);
select empno, ename, sal, deptno from emp where (deptno, sal) in (select deptno, max(sal) from emp group by deptno); -- 권장

-- emp 테이블에서 직급(JOB)이 MANAGER인 사람이 속한 부서의 부서 번호(deptno)와 부서명(dname)과 지역(loc)을 출력하시오.
select e.deptno, dname, loc from emp e, dept d where e.deptno = d.deptno and job = 'MANAGER';
select deptno, dname, loc from dept where deptno in (select deptno from emp where job='MANAGER') order by deptno;

