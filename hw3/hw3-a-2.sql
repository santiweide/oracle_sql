declare
list_ag varchar2(2000);
list_ho varchar2(2000);
list_pz varchar2(2000);
cursor cur_p(c1 char,c2 char) is
       select ename from emp 
       where ascii(c1)<=ascii(ename) and ascii(ename) <= ascii(c2);
begin
  for cur_i in cur_p('A','G') loop
    list_ag:=list_ag || ' ' || cur_i.ename;
  end loop;
  list_ag := substr(list_ag,2);
  dbms_output.put_line(list_ag);
  
  for cur_i in cur_p('H','O') loop
    list_ho:=list_ho || ' ' || cur_i.ename;
  end loop;
  list_ho := substr(list_ho,2);
  dbms_output.put_line(list_ho);

  for cur_i in cur_p('P','Z') loop
    list_pz:=list_pz || ' ' || cur_i.ename;
  end loop;
  list_pz := substr(list_pz,2);
  dbms_output.put_line(list_pz);

end;
