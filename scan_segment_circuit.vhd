library IEEE; 
use IEEE.STD_logic_1164.all;
use IEEE.std_logic_unsigned.all;
-----------------------------------------------------------
entity scan_segment_circuit is
port
(
	cnt_0,cnt_1,cnt_2,cnt_3:in std_logic_vector(3 downto 0);
	clk,test_rst:in std_logic;
	seg:out std_logic_vector(7 downto 0);
	scan:out std_logic_vector(3 downto 0)
);
end scan_segment_circuit;
------------------------------------------------------------
architecture circuit of scan_segment_circuit is
---------------signal---------------------------------------
signal cnt:std_logic_vector(3 downto 0):="0000";
signal scan_cnt:std_logic_vector(2 downto 0):="000";
signal scan_clk:std_logic:='0';
------------------------------------------------------------
begin 
process(test_rst,scan_clk)
begin 
	if(test_rst='0')then
		scan_cnt<="000";
	else
		if(rising_edge(scan_clk))then
			if(scan_cnt="100")then
				scan_cnt<="000";
			else
				scan_cnt<=scan_cnt+1;
			end if;
		end if;
	end if;
end process;
-------------------------------------------------------------
process(scan_cnt,cnt_0,cnt_1,cnt_2,cnt_3)
begin
	case scan_cnt is
		when"000"=>cnt<=cnt_0;
		when"001"=>cnt<=cnt_1;
		when"010"=>cnt<=cnt_2;
		when"011"=>cnt<=cnt_3;
		when others =>NULL;
	end case;
end process;
-------------------------------------------------------------
process(clk)
variable counter_1:integer:=0;
begin
	if(rising_edge(clk))then
		if(counter_1=100000)then
			counter_1:=0;
			scan_clk<=not scan_clk;
		else counter_1:=counter_1+1;
		end if;
	end if;
end process;
-------------------------------------------------------------
with cnt select
seg<=  "00000011" when "0000" ,
		 "10011111" when "0001" ,
		 "00100101" when "0010" ,
	    "00001101" when "0011" ,
	    "10011001" when "0100" ,
		 "01001001" when "0101" ,
		 "01000001" when "0110" ,
		 "00011011" when "0111" ,
		 "00000001" when "1000" ,
		 "00001001" when "1001" ,
		 "10010001" when "1010" ,--H(10)
		 "11100011" when "1011" ,--L(11)
		 "01001001" when "1100" ,--S(12)
		 "00010001" when "1101" ,--A(13)
		 "01100011" when "1110" ,--C(14)
		 "00000011" when others;
-------------------------------------------------------------
with scan_cnt select
scan<= "0111" when "000",
		 "1011" when "001",
		 "1101" when "010",
		 "1110" when "011",
		 "1111" when others;
end circuit;