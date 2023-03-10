select * from emp;
select * from salgrade;

-- non equi join 비동등조인 between, in
select empno, ename, sal, grade from emp, salgrade where sal between losal and hisal;
select * from dept;
select ename, job, sal, dname, loc from emp e, dept d where e.deptno = d.deptno;

-- outer join : 면접에서 많이 물어본다
-- outer join: 두 개 이상의 테이블에서 한쪽에만 존재하는 데이터도 출력하고 싶을 때 사용한다. 부족한 쪽에다 +한다. 오라클에서만 + 가능
select ename, job, sal, dname, loc from emp e, dept d where e.deptno(+) = d.deptno;
-- 먼저 쓰는 테이블이 많을 때는 left, 나중에 쓰는 테이블이 많을 때는 right (mySQL)
select ename, job, sal, dname, loc from emp e right outer join dept d on e.deptno(+) = d.deptno;
-- 양쪽 테이블에서 부족한 데이터를 보고 싶을 때 / 왼쪽이 많은지, 오른쪽이 많은지 모를 때 (mySQL)
select ename, job, sal, dname, loc from emp e full outer join dept d on e.deptno(+) = d.deptno;

------------------------------------------------------------------------------------------------------------
desc emp;
desc dept;
--1. 사번, 이름, 업무, 부서명, 근무지 부서명순
--2. 이름, 업무, 입사일, 급여, 부서코드, 부서명 부서코드 순  부서코드가 같으면 급여 큰 순
--3. 사번, 이름, 업무, 급여, 급여등급  급여등급 순
--4. 사번, 이름, 업무, 급여, 급여등급, 부서명
--5. 이름, 업무, 입사일, 급여, 부서코드, 부서명, 근무지 직원없는 부서 포함
--6. 이름, 업무, 입사일, 급여, 부서명, 근무지 급여가 1500~3000사이 부서명순
--7. 이름, 업무, 급여, 연봉 (= (급여+comm) * 12 comm이 null이면 0), 급여등급, 부서명, 근무지
--8. 이름, 업무, 입사일, 부서명, 근무지 81년에 입사한 사람 입사일 순
--9. 이름, 업무, 입사일, 부서코드, 부서명, 근무지(직원없는 부서 포함) 근무지 순, 근무지가 같으면 급여 순

--1. 사번, 이름, 업무, 부서명, 근무지 부서명순
select empno, ename, job, dname, loc from emp e, dept d where e.deptno = d.deptno order by dname;

--2. 이름, 업무, 입사일, 급여, 부서코드, 부서명 부서코드 순  부서코드가 같으면 급여 큰 순
select ename, job, hiredate, sal, d.deptno, dname from emp e, dept d where e.deptno = d.deptno order by d.deptno, sal desc;

--3. 사번, 이름, 업무, 급여, 급여등급  급여등급 순
select empno, ename, job, sal, grade from emp, salgrade where sal between losal and hisal order by grade; 

--4. 사번, 이름, 업무, 급여, 급여등급, 부서명
select empno, ename, job, sal, grade, dname from emp e, dept d, salgrade where e.deptno = d.deptno and
e.sal between losal and hisal ;

--5. 이름, 업무, 입사일, 급여, 부서코드, 부서명, 근무지 직원없는 부서 포함 (결과를 다 보여주려고 d.deptno로 작성한 것)
select ename, job, hiredate, sal, d.deptno, dname, loc from emp e, dept d where e.deptno(+) = d.deptno;

--6. 이름, 업무, 입사일, 급여, 부서명, 근무지 급여가 1500~3000사이 부서명순
select ename, job, hiredate, sal, dname, loc from emp e, dept d where e.deptno = d.deptno 
and sal between 1500 and 3000 order by dname;

--7. 이름, 업무, 급여, 연봉 (= (급여+comm) * 12 comm이 null이면 0), 급여등급, 부서명, 근무지
select ename, job, sal, (sal+nvl(comm,0))*12 연봉, grade, dname, loc from emp e, dept d, salgrade 
where e.deptno = d.deptno and sal between losal and hisal;

--8. 이름, 업무, 입사일, 부서명, 근무지 81년에 입사한 사람 입사일 순
select ename, job, hiredate, dname, loc from emp e, dept d where e.deptno = d.deptno and
to_char(hiredate, 'yy') = 81 order by hiredate;

--9. 이름, 업무, 입사일, 부서코드, 부서명, 근무지(직원없는 부서 포함) 근무지 순, 근무지가 같으면 급여 순
select ename, job, hiredate, d.deptno, dname, loc from emp e, dept d where e.deptno(+) = d.deptno order by loc, sal;
------------------------------------------------------------------------------------------------------------
--6. 이름, 업무, 입사일, 급여, 부서명, 근무지 급여가 1500~3000사이 부서명순  다시보기

-- 직원이 없는 부서는 급여가 없으므로 급여 1500 ~ 3000 사이 조건과 직원이 없는 부서는 같이 존재하지 않는다.
--select ename, job, hiredate, sal, grade, dname, loc from emp e, dept d, salgrade where e.deptno(+) = d.deptno 
--and sal between 1500 and 3000 and sal between losal and hisal;

-- !!!  테이블 3개를 조인하려면 조건이 2개 있어야 한다. 테이블 4개를 조인하려면 조건이 3개 있어야 한다. !!!  ---

-- !!!
-- 재귀적 관계 : 같은 테이블 내에서 부모에 해당하는 PK(empno)와 자식에 해당하는 FK(mgr)가 같이 있는 관계
-- self join : 직원, 관리자를 같이 출력

-- self join  (oracle 실습 테이블.docx 참고)
select w.ename 직원, m.ename 관리자 from emp w, emp m where w.mgr = m.empno; -- 사장은 출력되지 않는다.

-- !!! 사장까지 출력, 권장하는 코드 !!!     +는 보고 싶은 값이 없는 쪽에 표시, 위에 있는 +랑 좀 다름. 사장은 관리자가 없음 -> 관리자도 표시
select w.ename 직원, m.ename 관리자 from emp w, emp m where w.mgr = m.empno(+); 

select distinct mgr from emp;
select distinct empno from emp;
--select w.ename 직원, m.ename 관리자 from emp w, emp m where w.mgr(+) = m.empno; 잘못된 코드
select w.ename 직원, m.ename 관리자 from emp m full outer join emp w on w.mgr = m.empno; -- 권장 x
------------------------------------------------------------------------------------------------------------
--1. xxx의 상사는 xxx입니다.
--2. emp 테이블에서 manager가 'KING'인 사원들의 이름(ename)과 직급(job)을 출력하시오.
--3. 이름, 사번, 입사일, 부서명, 관리자명
--4. 이름, 업무, 입사일, 급여, 부서명, 관리자명, 관리자 없는 직원 포함
--5. 이름, 급여, 급여등급, 부서명, 관리자명, 관리자 없는 직원 포함
--6. 이름, 업무, 급여, 급여등급, 부서명, 근무지, 관리자명 급여가 업무가 salesman, manager인 경우
--7. 이름, 업무, 급여, 급여등급, 연봉(=(급여+comm)*12, comm이 null이면 0), 부서명, 관리자명
--8. 이름, 급여, 급여등급, 관리자명 (관리자 없는 직원 포함), 부서명순, 급여 큰 순


--1. xxx의 상사는 xxx입니다.
select w.ename ||'의 상사는 '|| m.ename || '입니다' from emp w, emp m where w.mgr = m.empno;

--2. emp 테이블에서 manager가 'KING'인 사원들의 이름(ename)과 직급(job)을 출력하시오.
select w.ename, w.job from emp w, emp m where w.mgr = m.empno and m.ename = 'KING';

--3. 이름, 사번, 입사일, 부서명, 관리자명
select w.ename 직원, w.empno, w.hiredate, dname, m.ename 관리자 from emp w, emp m, dept d where w.mgr = m.empno
and w.deptno = d.deptno; 

--4. 이름, 업무, 입사일, 급여, 부서명, 관리자명, 관리자 없는 직원 포함
select w.ename 직원, w.job, w.hiredate, w.sal, dname, m.ename 관리자 from emp w, emp m, dept d  where w.mgr = m.empno(+)
and w.deptno = d.deptno;

--5. 이름, 급여, 급여등급, 부서명, 관리자명, 관리자 없는 직원 포함
select w.ename 직원, w.sal, grade, dname, m.ename 관리자 from emp w, emp m, dept d, salgrade where w.deptno = d.deptno 
and w.sal between losal and hisal and w.mgr = m.empno(+);

--6. 이름, 업무, 급여, 급여등급, 부서명, 근무지, 관리자명  업무가 salesman, manager인 경우
select w.ename 직원, w.job, w.sal, grade, dname, loc, m.ename 관리자 from emp w, emp m, dept d, salgrade where w.deptno = d.deptno 
and w.mgr = m.empno and w.sal between losal and hisal and lower(w.job) in ('salesman', 'manager');

--7. 이름, 업무, 급여, 급여등급, 연봉(=(급여+comm)*12, comm이 null이면 0), 부서명, 관리자명
select w.ename 직원, w.job, w.sal, grade, (w.sal+nvl(w.comm,0))*12 연봉, dname, m.ename 관리자 from emp w, emp m, dept d, salgrade 
where w.deptno = d.deptno and w.sal between losal and hisal and w.mgr = m.empno;

--8. 이름, 급여, 급여등급, 관리자명 (관리자 없는 직원 포함), 부서명순, 급여 큰 순
select w.ename 직원, w.sal, grade, m.ename 관리자 from emp w, emp m, salgrade, dept d where w.deptno = d.deptno 
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

-- union : 합집합, 중복된 데이터는 1회 정렬 : 출력되는 데이터 형과 개수(컬럼)가 일치해야함
select val from a union
select val from b;
-- union : 합집합, 중복된 데이터는 1회 정렬
select val from a union select val from b;
-- 중복된 것 포함, 정렬 안됨
select val from a union all select val from b;

select 0,val from a union select num, val from b;
select null,val from a union select num, val from b;

-- intersect 공통집합, 교집합
select val from a intersect select val from b;
-- minus 차집합
select val from a minus select val from b;
select val from b minus select val from a;

-- 양쪽 테이블에 공통으로 사용하는 컬럼이 한 개 존재
select ename, sal, dname from emp natural join dept;
select ename, sal, dname from emp join dept using(deptno);

------------------------------------------------------------------------------------------------------------
--1. EMP 테이블에서 모든 사원에 대한 이름,부서번호,부서명을 출력하는 SELECT 문장을 작성하여라.
--2. EMP 테이블에서 NEW YORK에서 근무하고 있는 사원에 대하여 이름,업무,급여,부서명을 출력하는 SELECT 문장을 작성하여라.
--3. EMP 테이블에서 보너스를 받는 사원에 대하여 이름,부서명,위치를 출력하는 SELECT 문장을 작성하여라.
--4. EMP 테이블에서 이름 중 L자가 있는 사원에 대하여 이름,업무,부서명,위치를 출력하는 SELECT 문장을 작성하여라.
--5. 사번, 사원명, 부서코드, 부서명을 검색하라. 사원명기준으로 오름차순 정렬
--6. 사번, 사원명, 급여, 부서명을 검색하라. 단 급여가 2000이상인 사원에 대하여 급여를 기준으로 내림차순으로 정렬하시오
--7. 사번, 사원명, 업무, 급여, 부서명을 검색하시오. 단 업무가 MANAGER이며 급여가 2500이상인 사원에 대하여 사번을 기준으로 오름차순으로 정렬하시오.
--8. 사번, 사원명, 업무, 급여, 등급을 검색하시오. 등급은 급여가 하한값과 상한값 범위에 포함되고 급여기준 내림차순으로 정렬하시오
--9. 사원테이블에서 사원명, 사원의 관리자명을 검색하시오
--10. 사원명, 관리자명, 관리자의 관리자명을 검색하시오
--11. 위의 결과에서 상위 관리자가 없는 모든 사원의 이름도 사원명에 출력되도록 수정하시오


--1. EMP 테이블에서 모든 사원에 대한 이름,부서번호,부서명을 출력하는 SELECT 문장을 작성하여라.
select ename, e.deptno, dname from emp e, dept d where e.deptno = d.deptno;

--2. EMP 테이블에서 NEW YORK에서 근무하고 있는 사원에 대하여 이름,업무,급여,부서명을 출력하는 SELECT 문장을 작성하여라.
select ename, job, sal, dname from emp e, dept d where e.deptno = d.deptno and loc = 'NEW YORK';

--3. EMP 테이블에서 보너스를 받는 사원에 대하여 이름,부서명,위치를 출력하는 SELECT 문장을 작성하여라.
select ename, dname, loc from emp e, dept d where e.deptno = d.deptno and comm is not null;

--4. EMP 테이블에서 이름 중 L자가 있는 사원에 대하여 이름,업무,부서명,위치를 출력하는 SELECT 문장을 작성하여라.
select ename, job, dname, loc from emp e, dept d where e.deptno = d.deptno and ename like '%L%';

--5. 사번, 사원명, 부서코드, 부서명을 검색하라. 사원명기준으로 오름차순 정렬
select empno, ename, e.deptno, dname from emp e, dept d where e.deptno = d.deptno order by ename;

--6. 사번, 사원명, 급여, 부서명을 검색하라. 단 급여가 2000이상인 사원에 대하여 급여를 기준으로 내림차순으로 정렬하시오
select empno, ename, sal, dname from emp e, dept d where e.deptno = d.deptno and sal >= 2000 order by sal desc;

--7. 사번, 사원명, 업무, 급여, 부서명을 검색하시오. 단s 업무가 MANAGER이며 급여가 2500이상인 사원에 대하여 사번을 기준으로 오름차순으로 정렬하시오.
select empno, ename, job, sal, dname from emp e, dept d where e.deptno = d.deptno and lower(job) = 'manager' and sal >= 2500
order by empno;

--8. 사번, 사원명, 업무, 급여, 등급을 검색하시오. 등급은 급여가 하한값과 상한값 범위에 포함되고 급여기준 내림차순으로 정렬하시오
select empno, ename, job, sal, grade from emp, salgrade where sal between losal and hisal order by sal desc;

--9. 사원테이블에서 사원명, 사원의 관리자명을 검색하시오
select w.ename 사원, m.ename 관리자 from emp w, emp m where w.mgr = m.empno; 

--10. 사원명, 관리자명, 관리자의 관리자명을 검색하시오
select w.ename 사원 , m.ename 관리자, h.ename 관리자의관리자 from emp w, emp m, emp h where w.mgr = m.empno and m.mgr = h.empno;

--11. 위의 결과에서 상위 관리자가 없는 모든 사원의 이름도 사원명에 출력되도록 수정하시오
select w.ename 사원 , m.ename 관리자, h.ename 관리자의관리자 from emp w, emp m, emp h where w.mgr = m.empno(+) and m.mgr = h.empno(+);




