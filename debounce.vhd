library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity debounce is
port 
(
	clk,button1,button2,button3,button4:in std_logic;
	de_b1,de_b2,de_b3,de_b4:inout std_logic
);
end debounce;
architecture d of debounce is
	constant debounce_time:integer:=10000;
----------------------------------------------------------
procedure deb
(
	signal b:in std_logic;
	signal db:inout std_logic;
	variable counter:inout integer
)is
begin
	if(db/=b and counter<debounce_time)then
		counter:=counter+1;
	elsif(counter=debounce_time)then
		counter:=0;
		db<=b;
	else counter:=0;
	end if;
end procedure;
begin
process(clk)
variable cnt1,cnt2,cnt3,cnt4:integer:=0;
begin
	if(rising_edge(clk))then
		deb(button1,de_b1,cnt1);
		deb(button2,de_b2,cnt2);
		deb(button3,de_b3,cnt3);
		deb(button4,de_b4,cnt4);
	end if;
end process;
end d;