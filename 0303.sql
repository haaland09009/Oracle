-- 주석, * 는 모두, emp 테이블의 데이터를 모두 보여준다.
select * from emp;
select * from salgrade;
-- dept 테이블 데이터 모두 출력
select * from dept;
select sum(sal) from emp;
select * from tab;
-- desc 테이블명 : 테이블의 구성을 보여준다.
--   number(2) : 정수 두 자리, varchar2(14): 문자 14자리 [variable character] - 오라클만 varchar2로 명시, char(14): 문자 14자리
desc dept;
-- not null: 반드시 값이 있어야 한다.
-- number(7,2) : 숫자가 7자리로 구성되어 있으면 2자리는 소숫점 이하
desc emp;
-- select 컬럼,... from 테이블명;
select empno, ename, sal from emp;
-- where : table로부터 데이터를 추출하는 조건
select empno, ename, sal from emp where sal >= 2500;
select empno, job, ename, sal from emp where deptno = 20;
-- 문자를 구별할 때는 작은 따옴표('), 값은 대소문자 구별
select ename, job, sal from emp where job = 'MANAGER';
-- >, >=, <, <= , 같다 = , 같지 않다 != , ^=, <>


--1. salgrade 모든 데이터
--2. scott가 사용할 테이블
--3. dept 테이블 구조
--4. emp 테이블에서 1) 사번, 이름, 업무, 급여 2) 이름, 업무, 급여, 부서코드 20인 부서만 출력 3) 이름,업무,급여,부서코드 10부서가 아닌 경우만 출력
--                4) 이름,업무,급여,부서코드 업무가 ANALYST인 경우만 출력    5) " 급여가 2000미만만 출력
--                  6) 이름, 업무, 입사일 82년 1월 1일 이후에 입사한 사람
select * from salgrade;
select * from tab;
desc dept;
--desc emp;
select empno, ename, job, sal from emp;
select ename, job, sal, deptno from emp where deptno = 20;
select ename, job, sal, deptno from emp where deptno != 10;
select ename, job, sal, deptno from emp where job = 'ANALYST';
select ename, job, sal, deptno from emp where sal < 2000;
select ename, job,hiredate from emp where hiredate >= '82/01/01';
--desc emp;