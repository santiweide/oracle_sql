create or replace function GET_STARS_NUM(p_str in varchar2,p_char in character) return number is
  v_ret   number(9,0);
  v_iter  number(9,0);
begin
  v_ret:=0;
  v_iter:=0;
  loop
    if v_iter=length(p_str) then 
      exit;
    end if;
    if substr(p_str,v_iter,1)=p_char then
      v_ret:=v_ret+1;
    end if;
    v_iter := v_iter + 1;
  end loop;
  return(v_ret);
end GET_STARS_NUM;
/
