select ename, sal from emp where sal >= 2000 and sal <= 3000;
-- 컬럼명 between A and B : A보다 크거나 같고 B보다 작거나 같다
select ename, sal from emp where sal between 2000 and 3000;
--select ename, sal from emp where sal between 3000 and 2000; 작은 값을 앞에 써야함.

-- =는 제외
select ename, sal from emp where sal not between 2000 and 3000;
select ename, sal from emp where sal < 2000 or sal > 3000;

-- 이름이 K나 S로 시작하는 사람 : S보다 SC가 크다.  S < SC  앞에 한 글자씩 비교해서 같으면 다음 글자
select ename from emp where ename between 'K' and 'SZZ';

-- 10번 또는 20번에 근무하는 사람
select ename, deptno from emp where deptno = 10 or deptno = 20;
select ename, deptno from emp where deptno in (10, 20); -- 괄호 안에 개수 제한이 없어 여러 수를 작성할 수 있다.
-- 10번 또는 20번에 근무하지 않는 사람
select ename, deptno from emp where deptno not in (10, 20); 
----------------------------------------------------------------------------------------------------------------------
--1. 급여가 1500 ~ 3000인 사람의 사번, 이름, 입사일, 급여
--2. 급여가 2000 ~ 3500이고 comm이 null이 아닌 사람 이름, 급여, 입사일, comm
--3. 급여가 2000 ~ 4000 사이가 아니거나 comm이 null인 사람의 이름 급여, comm
--4. 업무가 SALESMAN이거나 CLERK이거나 ANALYST인 사람의 사번, 이름, 업무
--5. 부서가 10이거나 30번인 사람의 사번, 이름, 부서코드
--6. 업무가 MANAGER도 아니고 CLERK도 아닌 사람의 사번, 이름, 업무
--7. 81년도에 입사한 사람의 사번, 이름, 입사일
--8. 이름이 D와 T사이의 문자로 시작하는 사람의 이름
--9. 급여가 1000~3000인 사람의 이름, 급여, 커미션, 연봉(=(급여+comm)*12 comm이 null이면 0) 별칭
--10. 이름(업무)은 급여가 xxx이고 연봉은 xxx이다(연봉 계산은 9번 참고)

--1. 급여가 1500 ~ 3000인 사람의 사번, 이름, 입사일, 급여
select empno, ename, hiredate, sal from emp where sal between 1500 and 3000;

--2. 급여가 2000 ~ 2500이고 comm이 null이 아닌 사람 이름, 급여, 입사일, comm
select ename, sal, hiredate, comm from emp where sal between 2000 and 3500 and comm is not null;

--3. 급여가 2000 ~ 4000 사이가 아니거나 comm이 null인 사람의 이름, 급여, comm
select ename, sal, comm from emp where sal not between 2000 and 4000 or comm is null;

--4. 업무가 SALESMAN이거나 CLERK이거나 ANALYST인 사람의 사번, 이름, 업무
select empno, ename, job from emp where job in ('SALESMAN','CLERK','ANALYST');

--5. 부서가 10이거나 30번인 사람의 사번, 이름, 부서코드
select empno, ename, deptno from emp where deptno in (10, 30);

--6. 업무가 MANAGER도 아니고 CLERK도 아닌 사람의 사번, 이름, 업무
select empno, ename, job from emp where job != 'MANAGER' and job != 'CLERK';
select empno, ename, job from emp where job not in ('MANAGER','CLERK');

--7. 81년도에 입사한 사람의 사번, 이름, 입사일
select empno, ename, hiredate from emp where hiredate between '81/01/01' and '81/12/31';

--8. 이름이 D와 T사이의 문자로 시작하는 사람의 이름
select ename from emp where ename between 'D' and 'TZZ';

--9. 급여가 1000~3000인 사람의 이름, 급여, 커미션, 연봉(=(급여+comm)*12 comm이 null이면 0) 별칭
select ename, sal, comm, (sal+nvl(comm,0))*12 연봉 from emp where sal between 1000 and 3000;

--10. 이름(업무)은 급여가 xxx이고 연봉은 xxx이다(연봉 계산은 9번 참고)
select ename||'('||job||')'||'은  급여가 ' || sal || '이고 연봉은 ' || (sal+nvl(comm,0))*12 || '이다' from emp;
----------------------------------------------------------------------------------------------------------------------

-- 81로 시작하고 나머지는 모두(%)
select empno, ename, hiredate from emp where hiredate like '81%';

select ename from emp where ename like 'S%';

-- %(모두) T % (모두) 글자 수 제한 없음
select ename from emp where ename like '%T%';
-- R로 끝나는 사람
select ename from emp where ename like '%R';

-- 언더바(_)는 아무 글자나 관계없지만 글자수 한개
-- A앞 한글자 즉 두 번째 글자가 A, A 뒤에는 모두 (글자 수 제한 없이 아무 글자 가능)
select ename from emp where ename like '_A%';
select ename from emp where ename like '__R%';

select * from emp;
-- 사번이 7369인 사람의 이름을 SMI%TH로 변경
update emp set ename='SMI%TH' where empno =7369;
-- %가 포함된 이름 \뒤에 있는 건 문자로 인식
-- %나 _가 포함된 문자를 검색힐 때는 escape 문자를 활용
-- % 모두로 생각 , 문자 한글자 + % 사용하면 %는 문자로 인식, escape는 실제 검색할 때는 문자 한글자는 제외
select ename from emp where ename like '%\%%' escape '\'; -- 주로 사용
select ename from emp where ename like '%K%%' escape 'K';

select ename from emp where ename not like '%\%%' escape '\';
----------------------------------------------------------------------------------------------------------------------
--1. 이름이 R로 포함된 사람의 이름
--2. 이름이 S로 끝나는 사람의 이름
--3. 81년도 입사하고 업무가 MANAGER인 사람의 이름과 업무
--4. 이름 두번째 글자가 L인 사람의 이름
--5. 이름 끝에서 두번 째 글자가 R인 사람의 이름
--6. %가 이름에 포함된 사람의 이름
--7. 이름에 TT가 연속에 붙어 있는 사람의 이름
--8. 이름에 L이 두개인 사람의 이름
--9. 부서코드가 3으로 시작하거나 급여가 2500 ~ 3000인 사람의 이름, 급여, 부서코드
--10. 이름의 끝에서 3번째 글자가 N인 사람의 이름
--11. 이름이 S로 시작하지 않는 사람의 이름


--1. 이름이 R로 포함된 사람의 이름
select ename from emp where ename like '%R%';

--2. 이름이 S로 끝나는 사람의 이름
select ename from emp where ename like '%S';

--3. 81년도 입사하고 업무가 MANAGER인 사람의 이름과 업무
select ename, job from emp where hiredate like '81%' and job = 'MANAGER';

--4. 이름 두번째 글자가 L인 사람의 이름
select ename from emp where ename like '_L%';

--5. 이름 끝에서 두번 째 글자가 R인 사람의 이름
select ename from emp where ename like '%R_';

--6. %가 이름에 포함된 사람의 이름
select ename from emp where ename like '%\%%' escape '\';

--7. 이름에 TT가 연속에 붙어 있는 사람의 이름
select ename from emp where ename like '%TT%';

--8. 이름에 L이 두개인 사람의 이름
select ename from emp where ename like '%L%L%';

--9. 부서코드가 3으로 시작하거나 급여가 2500 ~ 3000인 사람의 이름, 급여, 부서코드
select ename, sal, deptno from emp where deptno like '3%' or sal between 2500 and 3000;

--10. 이름의 끝에서 3번째 글자가 N인 사람의 이름
select ename from emp where ename like '%N__';

--11. 이름이 S로 시작하지 않는 사람의 이름
select ename from emp where ename not like 'S%';

----------------------------------------------------------------------------------------------------------------------
--!!! 주의사항 !!!
-- 셋의 결과 차이점 살펴보기, and 연산이 우선순위가 먼저이므로 첫번째 코드는  job ='MANAGER' and sal >= 2000 먼저 실행됨
-- and가 우선순위 먼저 (not > and > or)

-- and를 먼저 실행, 매니저이면서 급여가 2000이상이거나 salesman인 것을 찾기
select empno, ename, job, sal from emp where job='SALESMAN' or job ='MANAGER' and sal >= 2000;
select empno, ename, job, sal from emp where job='SALESMAN' or (job ='MANAGER' and sal >= 2000);
-- 업무가 salesman이거나 manager 중에서 급여가 2000이상인 것
select empno, ename, job, sal from emp where (job='SALESMAN' or job ='MANAGER') and sal >= 2000;
------------------------------------------------------------------------------------------------------------------------

select * from emp;
select * from emp order by sal desc;

-- select 컬럼,....from 테이블명 where 조건 order by 컬럼명(순서, 식, 별칭); 작은 순(asc 생략), 큰 순서(desc)
select ename 이름, sal from emp order by sal;
select ename 이름, sal from emp order by 이름 desc;
select ename 이름, sal from emp order by 이름 desc;

select ename 이름, sal from emp order by 2 desc;
select ename, sal, comm, sal+nvl(comm,0) from emp order by sal+nvl(comm,0);

-- 부서코드 작은 순으로 정렬, 부서코드가 같으면 급여가 작은 순으로 정렬
select ename, sal, deptno from emp order by deptno, sal;
select ename, sal, deptno from emp order by deptno, sal desc;
select ename, sal, deptno from emp order by deptno desc, sal;
select ename, sal, deptno from emp order by deptno desc, sal desc;

--! 주의사항 ! : oracle에서 null은 큰 수로 인식한다.
select ename, sal, comm from emp order by comm;
select ename, sal, comm from emp order by comm desc;
------------------------------------------------------------------------------------------------------------------------
--1. 사번, 이름, 급여 급여 큰 순으로
--2. 이름, 업무, 급여, 입사일 업무별(작은 순), 급여 작은 순
--3. 이름, 부서코드, 업무, 입사일, 급여  [부서별, 업무별, 급여 큰순]
--4. 이름, 부서코드, 업무, 입사일, 급여  [81년에 입사한 사람 업무, 입사일 순
--5. 이름, 급여, comm, 연봉((급여+comm_*12, comm이 null이면 0) 연봉 큰 순
--6. 이름, 급여, comm [comm 큰 순]
--7. 이름, 급여, 부서코드, 입사일 급여가 1500 ~ 3500 사이인데 입사일 순


--1. 사번, 이름, 급여 급여 큰 순으로
select empno, ename, sal from emp order by sal desc; -- 3 desc도 가능

--2. 이름, 업무, 급여, 입사일 업무별(작은 순), 급여 작은 순
select ename, job, sal, hiredate from emp order by job, sal;

--3. 이름, 부서코드, 업무, 입사일, 급여  [부서별, 업무별, 급여 큰순]
select ename, deptno, job, hiredate, sal from emp order by deptno, job, sal desc;
select ename, deptno, job, hiredate, sal from emp order by 2,3,5 desc;

--4. 이름, 부서코드, 업무, 입사일, 급여  [81년에 입사한 사람 업무, 입사일 순
select ename, deptno, job, hiredate, sal from emp where hiredate like '81%' order by job, hiredate; -- order by 3,4도 가능

--5. 이름, 급여, comm, 연봉((급여+comm_*12, comm이 null이면 0) 연봉 큰 순
select ename, sal, comm, (sal+nvl(comm,0)) * 12 연봉 from emp order by 연봉 desc;

--6. 이름, 급여, comm [comm 큰 순]
select ename, sal, comm from emp order by comm desc;

--7. 이름, 급여, 부서코드, 입사일 급여가 1500 ~ 3500 사이인데 입사일 순
select ename, sal, deptno, hiredate from emp where sal between 1500 and 3500 order by hiredate;

------------------------------------------------------------------------------------------------------------------------
--1. EMP 테이블에서 sal이 3000이상인 사원의 empno, ename, job, sal을 출력하는 SELECT 문장을 작성
--2. EMP 테이블에서 empno가 7788인 사원의 ename과 deptno를 출력하는 SELECT 문장
--3. EMP 테이블에서 hiredate가 1981년 2월 20과 1981년 5월 1일 사이에 입사한 사원의
--ename,job,hiredate을 출력하는 SELECT 문장을 작성(단 hiredate 순으로 출력)
--4. EMP 테이블에서 deptno가 10,20인 사원의 모든 정보를 출력하는 SELECT 문장을 작성(단 ename순으로 정렬)
--5. EMP 테이블에서 sal이 1500이상이고 deptno가 10,30인 사원의 ename과 sal를 출력하는 SELECT 문장을 작성
--   (단 HEADING을 employee과 Monthly Salary로 출력)
--6. EMP 테이블에서 hiredate가 1982년인 사원의 모든 정보를 출력하는 SELECT 문을 작성



--1. EMP 테이블에서 sal이 3000이상인 사원의 empno, ename, job, sal을 출력하는 SELECT 문장을 작성
select empno, ename, job, sal from emp where sal >= 3000;

--2. EMP 테이블에서 empno가 7788인 사원의 ename과 deptno를 출력하는 SELECT 문장
select ename, deptno from emp where empno = 7788;

--3. EMP 테이블에서 hiredate가 1981년 2월 20과 1981년 5월 1일 사이에 입사한 사원의
--ename,job,hiredate을 출력하는 SELECT 문장을 작성(단 hiredate 순으로 출력)
select ename, job, hiredate from emp where hiredate between '81/02/20' and '81/05/01' order by hiredate;

--4. EMP 테이블에서 deptno가 10,20인 사원의 모든 정보를 출력하는 SELECT 문장을 작성(단 ename순으로 정렬)
select * from emp where deptno in (10,20) order by ename;

--5. EMP 테이블에서 sal이 1500이상이고 deptno가 10,30인 사원의 ename과 sal를 출력하는 SELECT 문장을 작성
--   (단 HEADING을 employee과 Monthly Salary로 출력)
select ename as "employee", sal as "Monthly Salary" from emp where sal >= 1500 and deptno in (10,30);
select ename employee, sal "Monthly Salary" from emp where sal >= 1500 and deptno in (10,30);

--6. EMP 테이블에서 hiredate가 1982년인 사원의 모든 정보를 출력하는 SELECT 문을 작성
select * from emp where hiredate like '82%';

------------------------------------------------------------------------------------------------------------------------
--1. EMP 테이블에서 COMM에 NULL이 아닌 사원의 모든 정보를 출력하는 SELECT 문을 작성
--2. EMP 테이블에서 comm이 sal보다 10%많은 모든 사원에 대하여 ename,sal, 보너스를 출력하는 SELECT 문을 작성
--3. EMP 테이블에서 job이 CLERK이거나 ANALYST이고 sal이 1000,3000,5000이 아닌 모든 사원의 정보를 출력하는 SELECT 문을 작성
--4. EMP 테이블에서 ename에 L이 두 자가 있고 deptno가 30이거나 또는 mgr이7782인 사원의 모든 정보를 출력하는 SELECT 문을 작성하여라.


--1. EMP 테이블에서 COMM에 NULL이 아닌 사원의 모든 정보를 출력하는 SELECT 문을 작성
select * from emp where comm is not null;

--2. EMP 테이블에서 comm이 sal보다 10% 많은 모든 사원에 대하여 ename,sal, 보너스를 출력하는 SELECT 문을 작성
select ename, sal, comm from emp where comm > sal * 1.1;

--3. EMP 테이블에서 job이 CLERK이거나 ANALYST이고 sal이 1000,3000,5000이 아닌 모든 사원의 정보를 출력하는 SELECT 문을 작성
select * from emp where job in ('CLERK','ANALYST') and sal not in (1000,3000,5000);

--4. EMP 테이블에서 ename에 L이 두 자가 있고 deptno가 30이거나 또는 mgr이 7782인 사원의 모든 정보를 출력하는 SELECT 문을 작성하여라.
select * from emp where ename like '%L%L%' and (deptno = 30 or mgr = 7782);

------------------------------------------------------------------------------------------------------------------------
--1. 사원 테이블에서 입사일이 81년도인 직원의 사번,사원명, 입사일, 업무, 급여
--2. 사원 테이블에서 입사일이 81년이고 업무가 'SALESMAN'이 아닌 직원의 사번, 사원명, 입사일, 업무, 급여.
--3. 사원 테이블의 사번, 사원명, 입사일, 업무, 급여를 급여가 높은 순으로 정렬하고, 급여가 같으면 입사일이 빠른 사원으로 정렬
--4. 사원 테이블에서 사원명의 세 번째 알파벳이 'N'인 사원의 사번, 사원명을 검색
--5. 사원 테이블에서 연봉(SAL*12)이 35000 이상인 사번, 사원명, 연봉을 검색



--1. 사원 테이블에서 입사일이 81년도인 직원의 사번,사원명, 입사일, 업무, 급여
select empno, ename, hiredate, job, sal from emp where hiredate like '81%';

--2. 사원 테이블에서 입사일이 81년이고 업무가 'SALESMAN'이 아닌 직원의 사번, 사원명, 입사일, 업무, 급여
select empno, ename, hiredate, job, sal from emp where hiredate like '81%' and job != 'SALESMAN';

--3. 사원 테이블의 사번, 사원명, 입사일, 업무, 급여를 급여가 높은 순으로 정렬하고, 급여가 같으면 입사일이 빠른 사원으로 정렬
select empno, ename, hiredate, job, sal from emp order by sal desc, hiredate;

--4. 사원 테이블에서 사원명의 세 번째 알파벳이 'N'인 사원의 사번, 사원명을 검색
select empno, ename from emp where ename like '__N%';

--5. 사원 테이블에서 연봉(SAL*12)이 35000 이상인 사번, 사원명, 연봉을 검색
-- !!!! 참고: where 문장에서는 별칭을 사용하지 못한다. order by절에는 별칭 사용 가능 !!!!
select empno, ename, sal*12 연봉 from emp where sal*12 >= 35000; 







