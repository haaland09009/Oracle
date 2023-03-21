set serveroutput on -- 출력을 열어준다는 의미
declare
  vi_num number;
begin
  vi_num := 100;
  dbms_output.put_line(vi_num);
end;    
/

declare
  a number := 2**2 * 3**2;
begin
  dbms_output.put_line('a = ' || a);  
end;
/

declare
  t1 char(3);
begin
  t1 := '&t2';
  dbms_output.put_line(t1);
exception
  when others then dbms_output.put_line('올바르게 입력하세요');
end;
/

declare
  v_ename varchar2(20);
  v_dname varchar2(20);
begin
  select ename, dname into v_ename, v_dname from emp e, dept d
  where e.deptno = d.deptno and e.empno = 7839;
  -- 외부로 내보내는 데이터는 식별자로 선언한 변수명을 사용해야 한다.
  dbms_output.put_line('이름 : '|| v_ename);
  dbms_output.put_line('부서 : '|| v_dname);
end;  
/

declare
  max_sal number(7,2);
  v_ename varchar2(20);
begin
  select max(sal) into max_sal from emp;
  select ename into v_ename from emp where sal = max_sal; 
  dbms_output.put_line('이름 : '|| v_ename);
  dbms_output.put_line('급여 : '|| max_sal);
end;
/
-- table명.column명%type
declare
  max_sal emp.sal%type; -- max_sal은 emp.sal과 같은 타입으로 선언
  v_ename emp.ename%type;
begin
  select max(sal) into max_sal from emp;
  select ename into v_ename from emp where sal = max_sal; 
  dbms_output.put_line('이름 : '|| v_ename);
  dbms_output.put_line('급여 : '|| max_sal);
end;
/


declare
  vi_num number default 100; -- 후에 아무것도 선언하지 않으면 100으로 출력
begin
--  vi_num := 100;
  dbms_output.put_line(vi_num);
end;    
/
-- bind 함수
declare
  v_sal emp.sal%type;
begin
  select sal into v_sal from emp where empno = :empno;
  dbms_output.put_line(v_sal);
end;
/

select * from emp where sal >: sal;
select * from emp where ename =: ename;


begin
  dbms_output.put_line('3 * 1 = ' || 3*1);
  dbms_output.put_line('3 * 2 = ' || 3*2);
  dbms_output.put_line('3 * 3 = ' || 3*3);
  dbms_output.put_line('3 * 4 = ' || 3*4);
  dbms_output.put_line('3 * 5 = ' || 3*5);
  dbms_output.put_line('3 * 6 = ' || 3*6);
  dbms_output.put_line('3 * 7 = ' || 3*7);
  dbms_output.put_line('3 * 8 = ' || 3*8);
  dbms_output.put_line('3 * 9 = ' || 3*9);
end;
/

declare
  num number := &num;
begin
  dbms_output.put_line(num||' * 1 = ' || num * 1);
  dbms_output.put_line(num||' * 2 = ' || num * 2);
  dbms_output.put_line(num||' * 3 = ' || num * 3);
  dbms_output.put_line(num||' * 4 = ' || num * 4);
  dbms_output.put_line(num||' * 5 = ' || num * 5);
  dbms_output.put_line(num||' * 6 = ' || num * 6);
  dbms_output.put_line(num||' * 7 = ' || num * 7);
  dbms_output.put_line(num||' * 8 = ' || num * 8);
  dbms_output.put_line(num||' * 9 = ' || num * 9);
end;
/

declare
  d varchar2(10) := '&요일'; -- 문자니까 작은 따옴표
begin
  case d
  when '월' then dbms_output.put_line('월요일입니다.');
  when '화' then dbms_output.put_line('화요일입니다.');
  when '수' then dbms_output.put_line('수요일입니다.');
  when '목' then dbms_output.put_line('목요일입니다.');
  when '금' then dbms_output.put_line('금요일입니다.');
  when '토' then dbms_output.put_line('토요일입니다.');
  when '일' then dbms_output.put_line('일요일입니다.');
  end case;
end;
/

declare
  num number := &num;
  i number := 1;
begin
  dbms_output.put_line('구구단 '|| num ||'단');
  loop
    if i > 9 then exit;
    end if;
    dbms_output.put_line(num||' * ' ||i||' = '||num*i);
    i := i + 1;
  end loop;
end;
/
