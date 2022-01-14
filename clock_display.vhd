library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity clock_display is
port
(
	clk_1hz,sw3:in std_logic;
	fsm_in:in std_logic_vector(2 downto 0);
	set1,set2:in std_logic_vector(3 downto 0);
	d_h1,d_h2,d_m1,d_m2,d_s1,d_s2:out std_logic_vector(3 downto 0);
	led,aled:inout std_logic:='1'
);
end clock_display;
architecture circuit of clock_display is
	signal a_flag,flag:std_logic:='0';
	signal hr1,hr2,min1,min2,sec1,sec2:std_logic_vector(3 downto 0):="0001";
	signal ahr1,ahr2,amin1,amin2,asec1,asec2:std_logic_vector(3 downto 0):="0000";
begin
process(clk_1hz,fsm_in,hr1,hr2,min1,min2,sec1,sec2,set1,set2,ahr1,ahr2,amin1,amin2,asec1,asec2)
begin
	if(fsm_in="000")then
		if(rising_edge(clk_1hz))then
			if(sec2="1001")then 
				sec2<="0000";
				if(sec1="0101")then
					sec1<="0000";
					if(min2="1001")then
						min2<="0000";
						if(min1<="0101")then
							min1<="0000";
							if(hr2="1001")then
								hr2<="0000";
								if(hr1="0010" and hr2="0100" and min1="0101" and min2="1001"
								and sec1="0101" and sec2="1001")then
									hr1<="0000";hr2<="0000";
									min1<="0000";min2<="0000";
									sec1<="0000";sec2<="0000";
								else hr1<=hr1+1;
								end if;
							else hr2<=hr2+1;
							end if;
						else min1<=min1+1;
						end if;
					else min2<=min2+1;
					end if;
				else sec1<=sec1+1;
				end if;
			else sec2<=sec2+1;	
			end if;
		end if;
	elsif(fsm_in="001")then
		hr1<=set1;
		hr2<=set2;
	elsif(fsm_in="010")then
		min1<=set1;
		min2<=set2;
	elsif(fsm_in="011")then
		sec1<=set1;
		sec2<=set2;
	elsif(fsm_in="100")then
		ahr1<=set1;
		ahr2<=set2;
	elsif(fsm_in="101")then
		amin1<=set1;
		amin2<=set2;
	elsif(fsm_in="110")then
		asec1<=set1;
		asec2<=set2;
	else NULL;
	end if;
end process;
process(sw3,fsm_in,hr1,hr2,min1,min2,sec1,sec2,set1,set2,ahr1,ahr2,amin1,amin2,asec1,asec2)
begin
	if(fsm_in="000")then
		if(flag='1')then
			if(hr1=ahr1 and hr2=ahr2 and min1=amin1 and min2=amin2 and sec1=asec1 and sec2=asec2)then
				a_flag<=not a_flag;
			end if;
		elsif(flag='0')then a_flag<='0';
		end if;
	else a_flag<='0';
	end if;
end process;
process(sw3,fsm_in)
begin
	if(fsm_in="000")then
		if(sw3='0')then aled<='0';flag<='1';
		else aled<='1';flag<='0';
		end if;
	else aled<='1';flag<='0';
	end if;
end process;
process(a_flag,clk_1hz,led)
begin	
	if(a_flag='1')then
		if(rising_edge(clk_1hz))then
			led<=not led;
		end if;
	elsif(a_flag='0')then led<='1';
	else NULL;
	end if;
end process;
process(fsm_in,sec1,sec2,min1,min2,hr1,hr2)
begin
	if(fsm_in="000")then
		d_s1<=sec1;d_s2<=sec2;
		d_m1<=min1;d_m2<=min2;
		d_h1<=hr1;d_h2<=hr2;
	else d_h1<="ZZZZ";d_h2<="ZZZZ";d_m1<="ZZZZ";d_m2<="ZZZZ";d_s1<="ZZZZ";d_s2<="ZZZZ";	
	end if;
end process;
end circuit;