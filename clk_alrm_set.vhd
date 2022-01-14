library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity clk_alrm_set is
port
(
	clk_2hz,b3:in std_logic;
	fsm_in:in std_logic_vector(2 downto 0);
	sd1,sd2,sd3,sd4:out std_logic_vector(3 downto 0)
	--sd3(digits),sd4(Tens) data output
	--sd1,sd2 menu sign
);
end clk_alrm_set;
architecture circuit of clk_alrm_set is
	signal ch_1,ch_2,cm_1,cm_2,cs_1,cs_2:std_logic_vector(3 downto 0):="0000";
	signal ah_1,ah_2,am_1,am_2,as_1,as_2:std_logic_vector(3 downto 0):="0000";
procedure set_hour_digit
(
	signal button:in std_logic;
	signal low_digit,high_digit:inout std_logic_vector(3 downto 0)
)is
begin
	if(button='0')then
		if(low_digit="1001")then 
			low_digit<="0000";
			if(high_digit="0101")then 
				high_digit<="0000";
			else high_digit<=high_digit+'1';
			end if;
		else low_digit<=low_digit+'1';
		end if;
		if(low_digit="0100" and high_digit="0010")then
			low_digit<="0000";high_digit<="0000";
		end if;
	end if;
end procedure;
procedure set_other_digit
(
	signal button:in std_logic;
	signal low_digit,high_digit:inout std_logic_vector(3 downto 0)
)is
begin
	if(button='0')then
		if(low_digit="1001")then 
			low_digit<="0000";
			if(high_digit="0101")then 
				high_digit<="0000";
			else high_digit<=high_digit+'1';
			end if;
		else low_digit<=low_digit+'1';
		end if;
	end if;
end procedure;
---------------------------------------------------------------------
begin
process(fsm_in,clk_2hz,b3,ch_1,ch_2,cm_1,cm_2,cs_1,cs_2,ah_1,ah_2,am_1,am_2,as_1,as_2)
begin 
	if(fsm_in="001")then--clock_hour
		if(rising_edge(clk_2hz))then
			set_hour_digit(b3,ch_1,ch_2);
		end if;
	elsif(fsm_in="010")then--clock_min
		if(rising_edge(clk_2hz))then
			set_other_digit(b3,cm_1,cm_2);
		end if;
	elsif(fsm_in="011")then--clock_sec
		if(rising_edge(clk_2hz))then
			set_other_digit(b3,cs_1,cs_2);
		end if;
	elsif(fsm_in="100")then--alarm_hour
		if(rising_edge(clk_2hz))then
			set_hour_digit(b3,ah_1,ah_2);
		end if;		
	elsif(fsm_in="101")then--alarm_min
		if(rising_edge(clk_2hz))then
			set_other_digit(b3,am_1,am_2);
		end if;		
	elsif(fsm_in="110")then--alarm_sec
		if(rising_edge(clk_2hz))then
			set_other_digit(b3,as_1,as_2);
		end if;
	else NULL;
	end if;
end process;
--fsm_in:001 clock_hour	sd1<="1110" C(14) sd2<="1010" H(10)
--			010 clock_min	sd1<="1110" C(14)	sd2<="1011" L(11)
--			011 clock_sec	sd1<="1110" C(14) sd2<="1100" S(12)
--			100 alarm_hour sd1<="1101" A(13)	sd2<="1010" H(10)
--			101 alarm_min	sd1<="1101" A(13) sd2<="1011" L(11)
--			110 alarm_sec 	sd1<="1101" A(13) sd2<="1100" S(12)
--			111 non
process(fsm_in,clk_2hz,b3,ch_1,ch_2,cm_1,cm_2,cs_1,cs_2,ah_1,ah_2,am_1,am_2,as_1,as_2)
begin
	if(fsm_in="001")then sd1<="1110";sd2<="1010";--C(10)H(14)
		sd3<=ch_2;sd4<=ch_1;
	elsif(fsm_in="010")then sd1<="1110";sd2<="1011";--C(10)L(14)
		sd3<=cm_2;sd4<=cm_1;
	elsif(fsm_in="011")then sd1<="1110";sd2<="1100";--C(10)S(14)
		sd3<=cs_2;sd4<=cs_1;
	elsif(fsm_in="100")then sd1<="1101";sd2<="1010";--A(10)H(14)
		sd3<=ah_2;sd4<=ah_1;
	elsif(fsm_in="101")then sd1<="1101";sd2<="1011";--A(10)L(14)
		sd3<=am_2;sd4<=am_1;
	elsif(fsm_in="110")then sd1<="1101";sd2<="1100";--A(10)S(14)
		sd3<=as_2;sd4<=as_1;
	elsif(fsm_in="000" or fsm_in="111")then sd1<="ZZZZ";sd2<="ZZZZ";
		sd3<="ZZZZ";sd4<="ZZZZ";
	else NULL;
	end if;
end process;
end circuit;