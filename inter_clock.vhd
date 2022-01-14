library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-----------------------內部時鐘信號電路----------------------------------
entity inter_clock is 
	port(
			clk:in std_logic;
			clock_1hz,clock_2hz:out std_logic
		 ); 
end inter_clock;
architecture circuit of inter_clock is
	signal clk_1hz,clk_2hz:std_logic;	
	constant lim_1hz:integer:=25000000;
	constant lim_2hz:integer:=12500000;
-----------------------------------------------------------------------
begin 
	clock_1hz<=clk_1hz;
	clock_2hz<=clk_2hz;
process(clk)
	variable cnt_2hz:integer:=0;
begin
	if(rising_edge(clk))then
		if(cnt_2hz=lim_2hz)then
			cnt_2hz:=0;	
			clk_2hz<=not clk_2hz;
		else cnt_2hz:=cnt_2hz+1;
		end if;
	end if;
end process;
process(clk)	
	variable cnt_1hz:integer:=0;
begin
	if(rising_edge(clk))then
		if(cnt_1hz=lim_1hz)then
			cnt_1hz:=0;	
			clk_1hz<=not clk_1hz;
		else cnt_1hz:=cnt_1hz+1;
		end if;
	end if;
end process;
end circuit;