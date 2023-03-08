select ename, lower(ename), upper(ename), initcap(ename) from emp;
-- 업무가 MANAGER이거나 SALESMAN 수 많은 데이터 속에서 대문자인지 소문자인지 모를 때 => 소문자로 바꿔버리기
select * from emp where lower(job) in ('manager','salesman');
select ename, substr(ename,2,3) from emp; -- 주의사항: 인덱스가 아니라 문자열 순서
select ename, substr(ename,2,3), substr(ename,-4,2) from emp; -- substr(ename, 시작위치, 글자길이)
-- dual은 dummy table로서 데이터 한 건  / length: 글자 수
select length('oracle'), length('오라클') from dual;
-- lengthb 저장하는 byte 길이
select lengthb('oracle'), lengthb('오라클') from dual;

-- 2월에 입사한 사람
--select ename, hiredate from emp where hiredate like '%02%'; -- 2일에 입사한 사람도 같이 찍히기 때문에 안됨. 잘못된 코드임.
select ename, hiredate from emp where substr(hiredate,4,2) = 02;

----------------------------------------------------------------------------------------
--EMP 테이블에서 Hiredate의 년도가 1987인 사원의 모든 정보를 출력하시오 (단 substr 함수를 이용해서 where절을 만드시오)
--? EMP 테이블에서 ename이 E로 끝나는 사원의 모든 정보를 출력하시오. (단 substr 함수를 이용해서 where절을 만드시오

--EMP 테이블에서 Hiredate의 년도가 1987인 사원의 모든 정보를 출력하시오 (단 substr 함수를 이용해서 where절을 만드시오)
select * from emp where substr(hiredate, 1,2) = 87;
--? EMP 테이블에서 ename이 E로 끝나는 사원의 모든 정보를 출력하시오. (단 substr 함수를 이용해서 where절을 만드시오)
select * from emp where substr(lower(ename), -1,1) = 'e';
select * from emp where substr(ename, -1,1) = 'E';
----------------------------------------------------------------------------------------

select substr('welcome oracle',2,3), substr('환영합니다 오라클',2,3) from dual;
select substrb('welcome oracle',2,3), substrb('오라클',2,3) from dual;

-- instr(컬럼, 문자, 시작, 순서) 위치에 해당하는 순서를 출력
select ename, instr(ename,'L') e_null, instr(ename,'L',1,1) e_11, instr(ename,'L',1,2) e_12, 
instr(ename,'L',4,1) e_41, instr(ename,'L',4,2) e_42 from emp order by ename;

-- lpad, rpad: 글자를 맞추고 싶을 때
select ename, lpad(ename,'7','@'), rpad(ename,7,'#') from emp;
select ename, lpad(ename,'7',' '), rpad(ename,7,' ') from emp;

-- 특정 단어를 버리고 싶을 때 
select ename, ltrim(ename, 'A'), rtrim(ename, 'S'), trim('S' from ename) from emp;

-- translate : 문자 한글자씩 변경 / replace: 단어 단위로 변경
select empno, ename, translate(ename,'ABCDEFG','0123456') from emp; 
select ename, job, replace(job,'MAN','PERSON') from emp; 
----------------------------------------------------------------------------------------
--1. job을 원본,소문자,첫글자만 대문자,대문자로 출력 원본 순서
--2. 업무가 CLERK이거나 MANAGER인 사람의 이름, 업무 lower함수 사용
--3. 81년도에 입사한 사람의 이름,업무,입사일 substr 이용
--4. 이름,좌측 S제거, 우측 S제거, 양쪽 S 제거
--5. 급여를 5자로 출력하는 5자가 아닐 경우 왼쪽에 # 추가
--6. 이름,두번째부터 3글자, 연봉(=(급여+comm)*12) comm이 null이면 0) 연봉 큰 순 정렬
--7. 이름,업무 업무에서 MAN을 인간으로 변경하여 출력
--8. 이름,급여 급여 0123456789 => 영일이삼사...로 변경하여 출력
--9. 이름, 이름의 글자수  글자수가 큰순으로  정렬


--1. job을 원본,소문자,첫글자만 대문자,대문자로 출력 원본 순서
select job, lower(job), initcap(job), upper(job) from emp order by job;

--2. 업무가 CLERK이거나 MANAGER인 사람의 이름, 업무 lower함수 사용
select ename, job from emp where lower(job) in ('clerk','manager');

--3. 81년도에 입사한 사람의 이름,업무,입사일 substr 이용
select ename, job, hiredate from emp where substr(hiredate,1,2) = 81;

--4. 이름,좌측 S제거, 우측 S제거, 양쪽 S 제거
select ename, ltrim(ename,'S'), rtrim(ename,'S'), trim('S' from ename) from emp;

--5. 급여를 5자로 출력하는 5자가 아닐 경우 왼쪽에 # 추가
select sal, lpad(sal,'5','#') from emp;

--6. 이름,두번째부터 3글자, 연봉(=(급여+comm)*12) comm이 null이면 0) 연봉 큰 순 정렬
select ename, substr(ename,2,3), (sal+nvl(comm,0))*12 연봉 from emp order by 연봉 desc;

--7. 이름,업무 업무에서 MAN을 인간으로 변경하여 출력
select ename, job, replace(job,'MAN','인간') from emp;

--8. 이름,급여 급여 0123456789 => 영일이삼사...로 변경하여 출력
select ename, sal, translate(sal, '0123456789', '영일이삼사오육칠팔구') from emp;

--9. 이름, 이름의 글자수  글자수가 큰순으로  정렬
select ename, length(ename) from emp order by length(ename) desc;
----------------------------------------------------------------------------------------
select abs(10), abs(-10) from dual;

-- 양수일 경우 trunc와 floor가 같은 결과
select ename, sal/3, round(sal/3), trunc(sal/3), ceil(sal/3), floor(sal/3) from emp;
-- 음수일 경우 trunc와 ceil과 같은 결과
select ename, -sal/3, round(-sal/3), trunc(-sal/3), ceil(-sal/3), floor(-sal/3) from emp;
select ename, sal, mod(sal,30) from emp; -- mod는 나머지
select ename, sal, power(sal,2) from emp;
select power(2,3),power(3,3) from dual;
select sqrt(10), sqrt(4), sqrt(2) from dual;
-- sign 양수 1, 음수 -1, 0은 0
select sign(100), sign(-100) from dual;
select chr(65), chr(48), chr(97) from dual;
select ename, sal/3, round(sal/3, 2), trunc(sal/3, 1), round(sal/3, -2), trunc(sal/3, -1) from emp; -- -2는 100단위, -1는 10단위까지 반올림
----------------------------------------------------------------------------------------
--1. 이름, 급여/7, 반올림, 절사, ceil, floor
--2. 이름, -급여/7, 반올림, 절사, ceil, floor
--3. 이름, 급여/7, 반올림, 소수점 1, 소수점 2, 10단위, 100단위
--4. 이름, 급여/7, 절사, 소수점 1, 소수점 2, 10단위, 100단위
--5. 이름, 급여, 급여/8의 나머지, 급여/7의 나머지
--6. 2의 10승, 루트 3, 아스키 66에 해당하는 문자


--1. 이름, 급여/7, 반올림, 절사, ceil, floor
select ename, sal/7, round(sal/7), trunc(sal/7), ceil(sal/7), floor(sal/7) from emp;

--2. 이름, -급여/7, 반올림, 절사, ceil, floor
select ename, -sal/7, round(-sal/7), trunc(-sal/7), ceil(-sal/7), floor(-sal/7) from emp;

--3. 이름, 급여/7, 반올림, 소수점 1, 소수점 2, 10단위, 100단위
select ename, sal/7, round(sal/7), round(sal/7, 1), round(sal/7, 2), round(sal/7, -1), round(sal/7, -2) from emp;

--4. 이름, 급여/7, 절사, 소수점 1, 소수점 2, 10단위, 100단위
select ename, sal/7, trunc(sal/7), trunc(sal/7, 1), trunc(sal/7, 2), trunc(sal/7, -1), trunc(sal/7, -2) from emp;

--5. 이름, 급여, 급여/8의 나머지, 급여/7의 나머지
select ename, sal, mod(sal,8), mod(sal,7) from emp;

--6. 2의 10승, 루트 3, 아스키 66에 해당하는 문자
select power(2,10), sqrt(3), chr(66) from dual;
----------------------------------------------------------------------------------------
-- months_between, add_months, next_day 알고있기
select sysdate from dual;
select ename, sysdate, hiredate, round(sysdate-hiredate) 근무일, round((sysdate-hiredate)/7) 근무주,
round((sysdate-hiredate)/30) 근무달, round(months_between(sysdate, hiredate)) 근무월 from emp; -- 근무월 셀 때 months_betweeon 써야한다.
-- months_between : 31일,윤년,윤달 모두 계산해준다.
-- 현재 날짜 다음에 오는 요일
select ename, hiredate, add_months(hiredate, 2), next_day(hiredate, '금') from emp;

select ename, hiredate, to_char(hiredate, 'yy/mm/dd hh:mi:ss'), to_char(hiredate, '(dy) yyyy/mm/dd'),
to_char(hiredate, '(day) yyyy-mm-dd (am) hh:mi:ss'), to_char(hiredate, 'yy"년" mm"월" dd"일" hh"시" mi"분" ss"초"') from emp;

select ename, sal, to_char(sal, '00000'), to_char(sal, '99999'), to_char(sal, '9,999'),
to_char(sal, '9,999.99'), to_char(sal, 'L9,999'), to_char(sal, '$9,999') from emp;


-- 문자 => 숫자, 문자 => 날짜
select 76 - to_number('45') from dual;
select round(sysdate - to_date(19980115, 'yyyy/mm/dd')) from dual;
select round(sysdate - to_date(980115, 'rr/mm/dd')) from dual; 
-- yy를 사용하면 현재 세기 20
-- rr: 0 ~ 49는 20 현 세기
--    50 ~ 99는 19 전 세기

----------------------------------------------------------------------------------------
--1. 이름, 입사일, 근무일, 근무월, 급여, 지금까지 받은 총급여(절사)
--2. 이름, 입사일, 입사 후 두달 후
--3. 이름, 입사일 (요일 3자리) 년도4-월-일 (오전/오후) 시:분:초
--4. 이름, 급여, 첫단위 컴마, 원화표시
--5. 본인의 살아온 시간 소수점이하 반올림


--1. 이름, 입사일, 근무일, 근무월, 급여, 지금까지 받은 총급여(절사)
select ename, hiredate,round(sysdate-hiredate) 근무일, round(months_between(sysdate, hiredate)) 근무월,
sal, trunc(sal*round(months_between(sysdate, hiredate))) 총급여 from emp;

--2. 이름, 입사일, 입사 후 두달 후
select ename, hiredate, add_months(hiredate, 2) from emp;

--3. 이름, 입사일 (요일 3자리) 년도4-월-일 (오전/오후) 시:분:초
select ename, to_char(hiredate, '(day) yyyy-mm-dd (am) hh:mi:ss') from emp;

--4. 이름, 급여, 첫단위 컴마, 원화표시 (원화 대문자 L)
select ename,  to_char(sal, 'L99,999') from emp;

--5. 본인의 살아온 시간 소수점이하 반올림
select round(sysdate - to_date('91/07/20', 'rr/mm/dd')) from dual;

-- case when문
select empno, ename, sal, job, case lower(job) when 'analyst' then sal*1.1 
                                               when 'clerk' then sal*1.2
                                               when 'manager' then sal*1.3 
                                               when 'president' then sal*1.4 
                                               when 'salesman' then sal*1.5 
                                               else sal end 금여인상분 from emp; -- end는 case문 종료

-- decode는 오라클만 가능
select empno, ename, sal, job, decode(lower(job),'analyst',sal*1.1 
                                                 ,'clerk',sal*1.2
                                                 ,'manager',sal*1.3 
                                                ,'president',sal*1.4 
                                                ,'salesman',sal*1.5 
                                                ,sal) 금여인상분 from emp; 
                                                
                                                
----------------------------------------------------------------------------------------
-- 사번,부서코드,부서명 : 부서코드 10이면 회계팀 20이면 연구소 30이면 영업팀 아니면 운영팀
select empno, deptno, job, decode(deptno, '10','회계팀','20','연구소','30','영업팀','운영팀') 부서팀 from emp;

