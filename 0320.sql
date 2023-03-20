create view emp_v1 as select empno, ename, job, deptno from emp where deptno = 10;
-- view : 실제 데이터는 없지만 select문을 실행하여 데이터를 가져와서 진짜 테이블처럼 사용
-- view : 실제 테이블은 없지만 있는 것처럼 사용
select * from emp_v1;
-- 아래 소스코드는 에러 발생
create view emp_v1 as select empno, ename, job, e.deptno, dname from emp e, dept d where e.deptno = d.deptno;


-- 뷰 생성
create or replace view emp_v1 as select empno, ename, job, e.deptno, dname from emp e, dept d where e.deptno = d.deptno;
select * from emp_v1;

-- 뷰를 삭제하는 방법
drop view emp_v1;
------------------------------------------------
create or replace view emp_v1 as select w.ename worker, m.ename manager from emp w, emp m
where w.mgr = m.empno;

select * from emp_v1;

-- 아래 소스코드는 에러 발생, !! 항상 컬럼 옆에 별칭을 꼭 써줘야함 !!
create or replace view emp_v1 as select w.ename, m.ename from emp w, emp m
where w.mgr = m.empno;
-- 아니면 뷰 뒤에 별칭을 사용한다.
create or replace view emp_v1(worker, manager) as select w.ename, m.ename from emp w, emp m
where w.mgr = m.empno;

select * from emp_v1;
------------------------------------------------
-- 뷰를 테이블처럼 사용 가능
select empno, ename, job, manager from emp, emp_v1 where ename = worker; -- worker는 위에서 설정한 ename
------------------------------------------------
CREATE OR REPLACE VIEW v_emp2 (사원번호, 이름, 부서번호) 
AS SELECT empno, ename, deptno FROM emp WHERE deptno=20;

select * from v_emp2;
-- 뷰를 사용하면 마치 테이블처럼 사용 가능
------------------------------------------------
--11.View,Sequence,Index.pdf 10p

-- 아래 소스코드는 에러 발생 sal*12라는 컬럼은 emp에 존재하지 않으므로
create or replace view v_emp2 as select empno, ename, sal*12 from emp;
-- join 등으로 같은 컬럼명일 때는 별칭을 사용하거나 view 뒤에 컬럼명을 써서 서로 다르게 변경해야 한다.
-- 아래 코드와 같이식으로 만들어진 컬럼도 별칭을 지정해주어야 한다.
create or replace view v_emp2 as select empno, ename, sal*12 year_sal from emp;
select * from v_emp2;
------------------------------------------------
-- 부서별 급여합계, 평균급여(반올림)를 부서코드, 급여합계, 평균급여를 가진 emp_v2를 만들기
create or replace view emp_v2 as select deptno, sum(sal) 급여합계, round(avg(sal)) 평균급여
from emp group by deptno order by deptno;
-- 함수가 들어있는 것은 컬럼으로 사용할 수 없기 때문에 별칭을 사용해줘야 한다.
select * from emp_v2;

-- !  함수가 포함된 컬럼도 반드시 별칭을 사용하여 컬럼명을 변경해야 한다.  !
create or replace view emp_v2 (deptno, sum_sal, avg_sal) 
as select deptno, sum(sal), round(avg(sal)) from emp group by deptno order by deptno;

select * from emp_v2;

-- 본인 부서 평균보다 급여를 많이 받는 사람의 이름, 급여, 부서코드, 부서급여 평균
-- avg_sal은 위에 emp_v2 뷰에서 설정한 컬럼명이다
select ename, sal, e.deptno, avg_sal from emp e, emp_v2 v where e.deptno = v.deptno;
------------------------------------------------

select * from emp03; -- 나중에 로제 컬럼 추가해야함. 0317
create or replace view v_emp03 as select * from emp03;
select * from v_emp03;

-- 뷰를 수정했더니 원본 데이터도 수정되었다. -> 같은 조건일 때
delete from v_emp03 where empno = 1111;
select * from emp03;
insert into v_emp03 values(1234,'제시',5000); -- 가능


-- 뷰 수정에는 제한이 있다. 강의자료 12p 참고
 -- !! VIEW가 다음을 포함 한다면 행을 제거할 수 없습니다. !!
    -- 그룹 함수
    -- GROUP BY절
    -- DISTINCT키워드
    
select * from emp_v2;
delete from emp_v2 where deptno = 10; -- 데이터가 수정되지 않는다. 왜?
insert into emp_v2 values(40, 4000, 2500); -- 에러 발생
------------------------------------------------
-- 14p 
-- check option : where 조건에 맞지 않는 데이터는 입력,수정,삭제할 수 없다.
create or replace view view_chk30 as select empno, ename, sal, comm, deptno
from emp where deptno = 30 with check option;
-- 부서코드 30인 데이터만 들어갈 수 있다.

update view_chk30 set deptno = 20; -- 에러 발생
------------------------------------------------
-- read only 16p 참고
 CREATE OR REPLACE VIEW v_Read_Only AS
SELECT empno, ename, deptno FROM emp WHERE deptno = 10 WITH READ ONLY;
-- 단순히 읽기 만 할 수 있고 데이터는 입력하지 못한다.
------------------------------------------------
-- !! 중요 !! 인라인 뷰 : 뷰를 저장하지 않고 한번만 사용하는 경우
-- 부서평균 급여보다 많이 받는 사람
select empno, ename, sal, deptno from emp e 
where sal > (select round(avg(sal)) from emp where e.deptno = deptno);

-- 에러 발생, 그룹 함수와 쓰이는 컬럼은 group by에도 써줘야함.
select empno, ename, sal, deptno, avg(sal) from emp e 
where sal > (select round(avg(sal)) from emp where e.deptno = deptno); 

-- 컬럼에 평균급여도 포함하여 출력하고 싶을 때
select * from emp_v2;

select empno, ename, sal, e.deptno, avg_sal from emp e, emp_v2 v
where e.deptno = v.deptno;

-- emp_v2 만약 view가 없을 때? 
-- from 뒤에 sub query를 사용하여 테이블처럼 사용하는 것을 인라인 뷰라고 한다.
-- 인라인 뷰는 뷰에 등록이 되지 않는다. 한 번만 사용 가능
select empno, ename, sal, e.deptno, avg_sal from emp e,
(select deptno, round(avg(sal)) avg_sal from emp group by deptno) v
where e.deptno = v.deptno;
------------------------------------------------
--1. 사번,이름,업무,입사일,부서코드를 가진 view emp_v1 생성
--2. 사번,이름,업무,급여,연봉(=(급여+comm)*12 단 comm이 null이면 0)을 가진 emp_v2
--3. 사번,이름,업무,급여,사수를 가진 emp_v3
--4. 사번,이름,업무,부서코드,부서명,근무지를 가진 emp_dept_v1
--5. 부서코드,최대급여,최소급여,급여합계를 가진 emp_v4
--6. 자기업무 평균보다 많이 받는 사람의 이름,업무,급여,업무평균급여를 in_line view를 사용하여 작성


--1. 사번,이름,업무,입사일,부서코드를 가진 view emp_v1 생성
create or replace view emp_v1 as select empno,ename,job,hiredate,deptno from emp;
select * from emp_v1;

--2. 사번,이름,업무,급여,연봉(=(급여+comm)*12 단 comm이 null이면 0)을 가진 emp_v2
create or replace view emp_v2 as select empno,ename,job,sal,(sal+nvl(comm,0))*12 year_sal
from emp;
select * from emp_v2;

--3. 사번,이름,업무,급여,사수를 가진 emp_v3
create or replace view emp_v3 as select w.empno,w.ename worker,w.job,w.sal,m.ename manager from emp w, emp m
where w.mgr = m.empno;
select * from emp_v3;

--4. 사번,이름,업무,부서코드,부서명,근무지를 가진 emp_dept_v1
create or replace view emp_dept_v1 as select empno,ename,job,e.deptno,dname,loc from emp e, dept d
where e.deptno = d.deptno;
select * from emp_dept_v1;

--5. 부서코드,최대급여,최소급여,급여합계를 가진 emp_v4
--1)
create or replace view emp_v4(deptno,max_sal,min_sal,sum_sal)
as select deptno,max(sal),min(sal),sum(sal) from emp group by deptno;
select * from emp_v4;
--2)
create or replace view emp_v4
as select deptno,max(sal) max,min(sal) min,sum(sal) sum from emp group by deptno;

--6. 자기업무 평균보다 많이 받는 사람의 이름,업무,급여,업무평균급여를 in_line view를 사용하여 작성
select ename,e.job,sal,avg_job from emp e,(select job,round(avg(sal)) avg_job from emp
group by job) a where e.job = a.job and e.sal > avg_job;
------------------------------------------------
select rownum, ename, sal from emp;
-- rownum 테이블로부터 데이터를 추출하는 순서

-- 처음 테이블에 출력했을 때의 rownum 정보를 그대로 가지고 있다.
select rownum, ename, sal from emp order by sal desc;

-- 인라인 뷰, 괄호 안에 있는 코드는 테이블로 취급
select rownum, ename, sal from (select ename, sal from emp order by sal desc);
-- rn은 이전 rownum
select rownum, rn, ename, sal from (select rownum rn, ename, sal from emp order by sal desc);
------------------------------------------------
-- topN 엄청 중요 !!!!

-- topN 급여를 많이 받는 순서로 5명
select rownum, rn, ename, sal from (select rownum rn, ename, sal from emp order by sal desc)
where rownum <= 5;

-- topN 급여 6 ~ 10번째까지 출력
-- rownum: 테이블을 가져오는 순서이므로 아래 코드는 출력되지 않는다.
select rownum, rn, ename, sal from (select rownum rn, ename, sal from emp order by sal desc)
where rownum between 6 and 10; -- 출력되지 않는다.
-- 끄집어내는순간 rownum은 바뀐다.

-- topN 급여 6 ~ 10번째까지 출력
select * from (select rownum rn, ename, sal from 
(select rownum rn, ename, sal from emp order by sal desc))
where rn between 6 and 10;

-- topN 급여 6 ~ 10번째까지 출력
select rownum, ename, sal from (select rownum rn, a.* from 
(select ename, sal from emp order by sal desc) a)
where rn between 6 and 10;

select rownum, rn, ename, sal from (select rownum rn, a.* from 
(select ename, sal from emp order by sal desc) a)
where rn between 6 and 10;
------------------------------------------------
--37p
--1. EMP 테이블에서 사원 번호(empno), 이름(ename), 업무(job)를 포함하는 EMP_VIEW VIEW를 생성하여라.
--2. 1번에서 생성한 VIEW를 이용하여 10번 부서의 자료만 조회하여라.
--3. EMP 테이블과 인라인 뷰를 사용하여 급여를 많이 받는 순서대로 3명만 출력하는 뷰(SAL_TOP5_VIEW)를 작성하시오.


--1. EMP 테이블에서 사원 번호(empno), 이름(ename), 업무(job)를 포함하는 EMP_VIEW VIEW를 생성하여라.
create view EMP_VIEW as select empno, ename, job from emp;
select * from EMP_VIEW;

--2. 1번에서 생성한 VIEW를 이용하여 10번 부서의 자료만 조회하여라.
select * from emp_view v, emp e where v.empno = e.empno and e.deptno = 10;

--3. EMP 테이블과 인라인 뷰를 사용하여 급여를 많이 받는 순서대로 3명만 출력하는 뷰(SAL_TOP3_VIEW)를 작성하시오.
select * from (select * from emp order by sal desc) where rownum <= 3;
------------------------------------------------
-- rank() 
select empno, ename, sal, rank() over(order by sal desc) rank from emp;

-- where : table로부터 데이터를 추출하는 조건 
select empno, ename, sal, rank() over(order by sal desc) rank from emp
where rank <= 5; -- 에러 발생

-- 'rank'라는 컬럼이 생겼으므로 출력 가능
select * from (select empno, ename, sal, rank() over(order by sal desc) rank from emp)
where rank <= 5;

-- 급여 6 ~ 10
select * from (select empno, ename, sal, rank() over(order by sal desc) rank from emp)
where rank between 6 and 10;

-- 2등이 2명, 10등이 2명 출력
select empno, ename, sal, rank() over(order by sal desc) rank from emp;

-- dense_rank() 함수 
select empno, ename, sal, rank() over(order by sal desc) rank,
dense_rank() over(order by sal desc) dense from emp;

-- row_number() 함수 : 순서대로
select empno, ename, sal, rank() over(order by sal desc) rank,
dense_rank() over(order by sal desc) dense, 
row_number() over(order by sal desc) rn from emp;

-- partition by : 각 부서에서 몇 등인지?
select empno, ename, sal, rank() over(order by sal desc) rank,
dense_rank() over(order by sal desc) dense, 
row_number() over(order by sal desc) rn,
deptno, rank() over(partition by deptno order by sal desc) part from emp;

select empno, ename, sal, rank() over(partition by deptno order by sal desc) part, 
deptno from emp;

-----------------------------------
-- WITH 이거 별로 안씀
WITH summary as (SELECT dname, sum(sal) dept_total FROM emp, dept
WHERE emp.deptno = dept.deptno GROUP BY dname)
SELECT dname, dept_total FROM summary WHERE dept_total > (select sum(dept_total) * 1/3 from summary)
ORDER BY dept_total desc;
-----------------------------------
--p44
--1. EMP 테이블에서 사원 번호,이름,업무, 부서코드를 포함하는 EMP_VIEW VIEW를 생성하여라.
--2. 1번에서 생성한 VIEW를 이용하여 10번 부서의 자료만 조회하여라.
--3. EMP 테이블과 DEPT 테이블을 이용하여 이름,업무,급여,부서명,위치를 포함하는 EMP_DEPT_NAME이라는 VIEW를 생성하여라.


--1. EMP 테이블에서 사원 번호,이름,업무,부서코드를 포함하는 EMP_VIEW VIEW를 생성하여라.
create or replace view EMP_VIEW as select empno, ename, job, deptno from emp;
select * from EMP_VIEW;

--2. 1번에서 생성한 VIEW를 이용하여 10번 부서의 자료만 조회하여라.
select * from EMP_VIEW where deptno = 10;

--3. EMP 테이블과 DEPT 테이블을 이용하여 이름,업무,급여,부서명,위치를 포함하는 EMP_DEPT_NAME이라는 VIEW를 생성하여라.
create or replace view EMP_DEPT_NAME as select ename,job,sal,dname,loc from emp e, dept d
where e.deptno = d.deptno;
-----------------------------------
--p45
--1. 부서명, 사원명을 출력하는 dname_ename_view 생성
--2. 사원명, 사수명 worker_manager_view 생성
--3. 사번, 사원명, 입사일  입사일이 늦은 순으로 정렬 (최근 입사)
--4. 사번, 사원명, 입사일  입사일이 늦은 순 5명
--5. 사번, 사원명, 입사일  입사일이 늦은 순 6명 ~ 10명


--1. 부서명, 사원명을 출력하는 dname_ename_view 생성
create view dname_ename_view as select dname, ename from emp e, dept d
where e.deptno = d.deptno;
select * from dname_ename_view;

--2. 사원명, 사수명 worker_manager_view 생성
create view worker_manager_view as select e1.ename 사원, e2.ename 관리자
from emp e1, emp e2 where e1.mgr = e2.empno;

--3. 사번, 사원명, 입사일  입사일이 늦은 순으로 정렬 (최근 입사)
select empno, ename, hiredate from emp order by hiredate desc;

--4. 사번, 사원명, 입사일  입사일이 늦은 순 5명
select empno, ename, hiredate from (select empno, ename, hiredate from emp order by hiredate desc)
where rownum <= 5;

--5. 사번, 사원명, 입사일  입사일이 늦은 순 6명 ~ 10명
select * from (select rownum rn, a.* from (select * from emp order by hiredate desc) a)
where rn between 6 and 10;
-----------------------------------
drop view emp_v1;

drop table sawon;

-- 시퀀스
-- sawon_seq.nextval 1부터 시작해서 1씩 증가
create table sawon (num number(5) primary key, val varchar2(20));
create sequence sawon_seq;
insert into sawon values(sawon_seq.nextval,'안녕하세요');
insert into sawon values(sawon_seq.nextval,'반갑습니다');
insert into sawon values(sawon_seq.nextval,'반가워요');
select * from sawon;

-- 다른 DB에서는 auto_increment를 사용하면 1부터 1씩 증가
-- increment by : 증가하는 크기 변경 가능, start with: 시작하는 번호 임의로 정하기
create sequence sawon_seq2 increment by 2 start with 11;
insert into sawon values(sawon_seq2.nextval,'안녕');
insert into sawon values(sawon_seq2.nextval,'ㅎㅇ');
insert into sawon values(sawon_seq2.nextval,'ㅋㅋ');
select * from sawon;

-- currval: 현재 값, from dual?
select sawon_seq.currval from dual;

alter sequence sawon_seq increment by 2;
insert into sawon values(sawon_seq.nextval,'헤헤');
select * from sawon;

-- 시퀀스 제거
drop sequence sawon_seq;
-----------------------------------
--11.View,Sequence,Index.pdf 65p

--1. 시작 값이 1이고 1씩 증가하고, 최댓값이 100000이 되는 시퀀스 EMP_SEQ 생성합니다
create sequence emp_seq start with 1 increment by 1 maxvalue 100000;

--2. 이번에는 생성된 시퀀스를 사용하기 위해서 사원 번호를 기본 키로 설정하여 EMP01란 이름으로 새롭게 생성합시다.
drop table emp01; -- 이미 있던 테이블 지우기
create table emp01 (
    empno number(4) primary key,
    ename varchar(10),
    hiredate date);
select * from emp01;

--3. 사원 번호를 저장하는 EMPNO 컬럼은 기본 키로 설정하였으므로 중복된 값을 가질 수 없습니다. 
--다음은 생성한 EMP_SEQ 시퀀스로부터 사원번호를 자동으로 할당 받아 데이터를 추가하는 문장입니다. 
insert into emp01 values(emp_seq.nextval, 'JULIA', sysdate);
-----------------------------------
-- 72p 
--5. 부서 번호를 생성하는 시퀀스 객체를 생성하여 시퀀스 객체를 이용하여 부서 번호를 자동 생성하도록 해 봅시다. 
--이 문제를 풀기 위해서 다음과 같이 부서 테이블을 생성합니다.

create table dept_example(
    deptno number(4) primary key,
    dname varchar(15),
    loc varchar(15));
    
desc dept_example;    

--5.1 DEPTNO 컬럼에 유일한 값을 가질 수 있도록 시퀀스 객체 생성(시퀀스 이름 : DEPT_EXAMPLE_SEQ)해 봅시다
create sequence dept_example_seq start with 10 increment by 10;

--5.2 새로운 로우를 추가할 때마다 시퀀스에 의해서 다음과 같이 부서번호가 자동 부여되도록 해 봅시다.
insert into dept_example values (dept_example_seq.nextval,'인사과','서울');
insert into dept_example values (dept_example_seq.nextval,'기술팀','인천');
select * from dept_example;  -- 이 문제 다시 정리해야함. pdf 확인
-----------------------------------
-- create index index명 on table명 (컬럼,...);
-- drop index index명

-- 87p
--테이블 EMP01의 컬럼 중에서 이름(ENAME)에 대해서 인덱스를 생성해봅시다. 
create index idx_emp01_name on emp01(ename);

select * from emp01;

--EMP01 테이블의 IDX_EMP01_ENAME만 사용자가 인덱스를 생성한 것입니다. 이를 제거해 봅시다. 생성된 인덱스 객체를
--제거하기 위해서는 DROP INDEX 문을 사용합니다
drop index idx_emp01_name;
-----------------------------------
-- 91p
-- EMP 테이블에서 이름을 가지고 INDEX(emp_ename_indx)를 생성
create index emp_ename_indx on emp(ename);

---------------------------------
-- 동의어
create synonym e for emp;
select * from e;

-- 사용자 추가
-- create user user_id(계정) identified by 암호

create user c##kim identified by k1;
grant create session to c##kim;

grant select on c##scott.dept to c##kim;
revoke select on c##scott.emp from c##kim;

grant select on c##scott.emp to c##kim;
grant update (dname, loc) on c##scott.dept to c##kim;
---------------------------------
-- 57p
drop user c##kim;
-- 나중에 설정하기

-- 1. 계정이 KIM, 암호가 LION인 사용자 계정을 작성하시오.
create user c##kim identified by lion;

-- 2. KIM에게 CREATE TABLE과 CREATE SESSION 권한을 부여하시오.
grant create table, create session to c##kim;

-- 3. KIM에게 SCOTT의 DEPT, EMP 테이블의 SELECT 권한을 부여하시오.
grant select on c##scott.dept to c##kim;
grant select on c##scott.emp to c##kim;

-- 4. KIM에게 SCOTT의 EMP 테이블에 SAL,COMM 컬럼을 UPDATE할 수 있는 권한을 부여하시오.
grant update (sal,comm) on c##scott.emp to c##kim;

-- 5. KIM에게 부여된 EMP 테이블의 UPDATE 권한을 회수하시오.
revoke update on c##scott.emp from c##kim;
---------------------------------
-- 58p
--1. 사용자는 KSH이고 패스워드는 KIM인 사용자를 생성하여라.
create user c##ksh identified by c##kim;

--2. 생성된 사용자에게 CONNECT와 RESOURCE권한을 부여하여라.
grant connect, resource to c##ksh;

--3. 부여한 권한을 취소하고 KSH사용자를 삭제하여라.
revoke connect, resource from c##ksh;
drop user c##ksh;

-----------------------------
select * from dept;
select * from emp;
drop table emp; -- 자식
drop table dept; -- 부모

 select w.ename 직원, m.ename 관리자, dname 부서명 from emp w, emp m, dept d where w.deptno = d.deptno and w.mgr = m.empno;
select ename, job, dname from emp e, dept d where e.deptno = d.deptno;




