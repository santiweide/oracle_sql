create or replace function GET_TAX(
p_income in number, 
p_insurance in number
) return number is
type lower is table of number index by binary_integer;
type tax_rate is table of number index by binary_integer;
type nums is table of number index by binary_integer;
v_lower lower;
v_tax_rate tax_rate;
v_nums nums;
v_tmp number(12,3);
v_ret number(12,3);
begin
   v_ret:=0;
   v_nums(0):=0;
   v_tax_rate(0):=0.03;
   v_lower(0):=5000;
   
   v_nums(1):=2520;
   v_tax_rate(1):=0.10;
   v_lower(1):=36000;
   
   v_nums(2):=16920;
   v_tax_rate(2):=0.20;
   v_lower(2):=144000;
   
   v_nums(3):=31920;
   v_tax_rate(3):=0.25;
   v_lower(3):=300000;
   
   v_tmp:= p_income - p_insurance;
   for i in 0..2 loop
     if v_lower(i) < v_tmp and v_tmp <= v_lower(i+1) then
       v_ret := (v_tmp - v_lower(i)) * v_tax_rate(i) - v_nums(i);
       exit;
     end if;
   end loop;
   return (v_ret);
end GET_TAX;
/
