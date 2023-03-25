create or replace procedure insert_dept
  (v_deptno in dept.deptno%type, v_dname in dept.dname%type,
   v_loc in dept.loc%type)
is
begin
  insert into dept values(v_deptno, v_dname, v_loc);
  commit;
end;
/

select * from dept order by deptno;



create or replace procedure emp_info
  (p_empno in emp.empno%type, p_ename out emp.ename%type, 
   p_sal out emp.sal%type)
is
  v_empno emp.empno%type; 
  v_ename emp.ename%type;
  v_sal emp.sal%type;
begin
  select empno, ename, sal into v_empno,v_ename,v_sal from emp where empno = p_empno;
  p_ename := v_ename; 
  p_sal := v_sal;
end;
/


create table test (
  id varchar2(20) primary key,
  photo blob -- blob는 사진 저장
);
  
select * from test;


create table customer (
  id varchar2(20) primary key,
  pass varchar2(20),
  email varchar2(20),
  name varchar2(20),
  reg_date date
);
desc customer;

select * from customer;
delete from customer where id='k2';
commit;