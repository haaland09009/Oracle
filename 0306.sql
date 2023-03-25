-- *는 모든 칼럼
select * from emp;
-- 문자는 작은 따옴표(')로 감싼다, 대소문자 구별함
select ename,job,sal from emp where job = "ANALYST";

select * from emp where deptno = 10 and job = 'MANAGER';
select * from emp where deptno = 10 or job = 'MANAGER';

-- '아니다'는 기호
select * from emp where job != 'MANAGER';
select * from emp where job ^= 'MANAGER';
select * from emp where job <> 'MANAGER';
select * from emp where not job = 'MANAGER';
-------------------------------------------------------------------------
-- emp table 구조 
-- scott가 사용할 수 있는 table 조회 
-- 급여가 2000이상인 직원 
-- 급여가 2000이상이면서 업무가 MANAGER인 사람
-- 급여가 1500미만이거나 업무가 ANALYST인 사람 
-- 10번 부서가 아닌 사람의 이름, 업무, 부서코드 
-- 업무가 MANAGER이거나 SALESMAN인 사람의 이름,업무,부서코드
-- 업무가 SALESMAN이 아니거나 급여가 2000이상인 사람의 이름,업무,급여 
-- 보너스가 300인 사람의 이름, 업무, 급여, 보너스, 부서코드, 입사일
-- 82/01/01 이후에 입사한 사람의 사번, 이름, 업무, 입사일 ,부서코드

-- emp table 구조
desc emp; 

--  scott가 사용할 수 있는 table 조회
select * from tab;

-- 급여가 2000이상인 직원
select * from emp where sal >= 2000;

-- 급여가 2000이상이면서 업무가 MANAGER인 사람
select * from emp where sal >= 2000 and job = 'MANAGER';

-- 급여가 1500미만이거나 업무가 ANALYST인 사람
select * from emp where sal < 1500 and job = 'ANALYST';

-- 10번부가 아닌 사람의 이름, 업무, 부서코드
select ename, job, deptno from emp where deptno != 10;

-- 업무가 MANAGER이거나 SALESMAN인 사람의 이름,업무,부서코드
select ename, job, deptno from emp where job = 'MANAGER' or job = 'SALESMAN';

--  업무가 SALESMAN이 아니거나 급여가 2000이상인 사람의 이름,업무,급여
select ename, job, sal from emp where job != 'SALESMAN' or sal >= 2000;

-- 보너스가 300인 사람의 이름, 업무, 급여, 보너스, 부서코드, 입사일
select ename, job, sal, comm, deptno, hiredate from emp where comm = 300;

-- 82/01/01 이후에 입사한 사람의 사번, 이름, 업무, 입사일 ,부서코드
select empno, ename, job, hiredate, deptno from emp where hiredate >= '82/01/01';
-----------------------------------------------------------------------------------------

select * from emp;
select ename, sal, sal + 1000, sal * 2 from emp; -- 식 쓰는 것도 가능
-- java에서 null은 값이 없다는 뜻이다. 변수 == 값이 가능하다.
-- !!! DB에서는 null이 알 수 없다는 뜻이다. 사용할 수 없다. 적용할 수 없다. 즉 = 으로 비교할 수 없고 is 또는 is not으로 비교한다. !!!
select ename, job, sal, comm from emp where comm = null; -- 테이블이 안 찍히는 현상 발견
select ename, job, sal, comm from emp where comm is null; 
select ename, job, sal, comm from emp where comm != null; 
select ename, job, sal, comm from emp where comm is not null; 

-------------------------------------------------------------------------------------------
-- comm이 null인 사람의 사번, 이름, 급여, COMM
-- comm이 null 아닌 사람의 사번, 이름, 급여, comm, 급여 + comm
-- 업무가 MANAGER이거나 comm이 null인 사람의 이름, 업무, 급여, comm
-- comm이 null이 아닌 사람 중에서 부서코드가 30번인 사람의 이름, 업무, 급여
-- 입사일이 82년인 사람의 이름, 업무, 입사일


-- comm이 null인 사람의 사번, 이름, 급여, COMM
select empno, ename, sal, comm from emp where comm is null;

-- comm이 null 아닌 사람의 사번, 이름, 급여, comm, 급여 + comm
select empno, ename, sal, comm, sal + comm from emp where comm is not null;

-- 업무가 MANAGER이거나 comm이 null인 사람의 이름, 업무, 급여, comm
select ename, job, sal, comm from emp where job = 'MANAGER' or comm is null;

-- comm이 null이 아닌 사람 중에서 부서코드가 30번인 사람의 이름, 업무, 급여
select ename, job, sal from emp where comm is not null and deptno = 30;

-- 입사일이 82년인 사람의 이름, 업무, 입사일
select ename, job, hiredate from emp where hiredate >= '82/01/01' and hiredate <= '82/12/31';

-------------------------------------------------------------------------------------------

-- null 어떻게 값으로 처리할 것인가?
select ename, sal, comm, sal + comm from emp;
-- nvl, nvl2는 오라클만 된다.
-- nvl (null value logic) : 값이 null이면 어떻게 처리할 것인가? - 오라클만 해당된다. 다른 도구에서는 안 됨.
select ename, sal, comm, sal + nvl(comm, 0), sal + nvl(comm, 100) from emp;

-- nvl2      nvl(comm, 0) -> comm이 null이면 0으로   
--           nvl2(comm, comm+sal, sal) -> comm이 값이 있으면 (null이 아니면) sal + comm을 하고, null이면 sal을 출력
--           coalesce(sal+comm, sal) -> coalesce 앞에서부터 null이 아닐 때까지 다음 항 실행 -> 오라클뿐만 아니라 다른 곳에서도 가능
select ename, sal, comm, sal + nvl(comm, 0), nvl2(comm, comm+sal, sal), coalesce(sal+comm, sal) from emp;

-- 별칭 -> as, 큰따옴표와 as는 생략 가능, 단어가 한 칸 떨어질 때는 큰따옴표로 감싸야 한다.
select ename as "이름" , sal "급여", comm, sal + nvl(comm, 0) 급여와보너스합, 
nvl2(comm, comm+sal, sal) "급여와 보너스합", coalesce(sal+comm, sal) 합계 from emp;

-------------------------------------------------------------------------------------------
-- 이름, 급여, 보너스 ,급여 + 보너스 (단, 보너스가 null이면 0으로) nvl, nvl2, coalesce 사용하여 처리
-- 이름, 급여, 보너스, 연봉 (연봉은 (급여 + 보너스) *12 단, 보너스가 null이면 0으로 
-- 81년도에 입사한 사람 중에서 업무가 MANAGER인 사람
-- comm이 null인 사람의 급여+comm 별칭으로 급여와 보너스합으로 표시
-- comm이 null이 아니고 급여가 1500 이상인 사람의 이름, 급여, 보너스, 연봉 (연봉은 (급여+보너스)*12, 단 보너스가 null이면 0으로)
-- 부서코드가 10번이거나 업무가 MANAGER인 사람의 이름, 급여, 부서코드 / 컬럼명은 한글로 출력
-- 급여가 1500 이하거나 업무가 CLERK인 사람의 이름, 급여, 보너스, 급여 + 보너스 (보너스가 null이면 0) 컬럼명은 실급여로 표시

-- 이름, 급여, 보너스 ,급여 + 보너스 (단, 보너스가 null이면 0으로) nvl, nvl2, coalesce 사용하여 처리
select ename, sal, comm ,sal+nvl(comm, 0), nvl2(comm, sal+comm, sal), coalesce(sal+comm, sal) from emp;

-- 이름, 급여, 보너스, 연봉 (연봉은 (급여 + 보너스) *12 단, 보너스가 null이면 0으로 
select ename, sal, comm, (sal+nvl(comm, 0)) * 12 연봉 from emp;

-- 81년도에 입사한 사람 중에서 업무가 MANAGER인 사람
select * from emp where hiredate >= '81/01/01' and hiredate <= '81/12/31' and job='MANAGER';

-- comm이 null인 사람의 급여+comm 별칭으로 급여와 보너스합으로 표시
select ename, sal + nvl(comm, 0) "급여와 보너스합" from emp where comm is null;

-- comm이 null이 아니고 급여가 1500 이상인 사람의 이름, 급여, 보너스, 연봉 (연봉은 (급여+보너스)*12, 단 보너스가 null이면 0으로)
select ename, sal, comm, (sal+nvl(comm,0))*12 from emp where comm is not null and sal >= 1500;

-- 부서코드가 10번이거나 업무가 MANAGER인 사람의 이름, 급여, 부서코드 / 컬럼명은 한글로 출력
select ename as "이름", sal 급여, deptno 부서코드 from emp where deptno = 10 or job = 'MANAGER';

-- 급여가 1500 이하거나 업무가 CLERK인 사람의 이름, 급여, 보너스, 급여 + 보너스 (보너스가 null이면 0) 컬럼명은 실급여로 표시
select ename, sal, comm, sal+nvl(comm,0) 실급여 from emp where sal <= 1500 or job = 'CLERK';

-------------------------------------------------------------------------------------------
-- oracle에서 concat는 두개 항목만 가능 
select concat(ename,sal) from emp;
select ename||'('||sal||')' from emp;
select ename||'의 급여는 '|| sal||'이다' from emp;
-- EMP 테이블에서 ename과 salary을 “KING: 1 Year salary = 60000” 형식으로 출력
select ename || ': 1년 연봉 = ' || sal * 12 Monthly from emp;

select job from emp;
-- distinct는 중복이 있는 경우 한 번만 출력
select distinct job from emp;

-------------------------------------------------------------------------------------------
--1. EMP 테이블의 구조 조회
--2. EMP 테이블의 모든 내용을 조회
--3. EMP 테이블에서 중복되지 않는 deptno를 출력
--4. EMP 테이블의 ename과 job를 연결하여 출력
--5. DEPT 테이블의 deptno과 loc를 연결하여 출력
--6. EMP 테이블의 job과 sal를 연결하여 출력
--7. 사원테이블에서 직원들의 연봉(급여 * 12) “연봉”으로 계산하여 사원명, 급여, 연봉 출력
--8. xx의 업무는 xxx이고 급여는 xxx만원입니다.

--1. EMP 테이블의 구조 조회
desc emp;

--2. EMP 테이블의 모든 내용을 조회
select * from emp;

--3. EMP 테이블에서 중복되지 않는 deptno를 출력
select distinct deptno from emp;

--4. EMP 테이블의 ename과 job를 연결하여 출력
select ename ||'의 업무는 '|| job || '입니다' from emp;
select ename||'('||job||')' from emp;

--5. DEPT 테이블의 deptno과 loc를 연결하여 출력
select '부서코드 ' ||deptno ||'의 위치는 '|| loc || '입니다' from dept;
select deptno||'('||loc||')' from dept;

--6. EMP 테이블의 job과 sal를 연결하여 출력
select  job ||'의 급여는 '|| sal || '입니다' from emp;
select job||'('||sal||')' from emp;

--7. 사원테이블에서 직원들의 연봉(급여 * 12) “연봉”으로 계산하여 사원명, 급여, 연봉 출력
select empno, sal, sal*12 "연봉" from emp;

--8. xx의 업무는 xxx이고 급여는 xxx만원입니다.
select ename||'의 업무는 '|| job ||'이고 급여는 ' || sal ||'만원입니다' from emp; 
