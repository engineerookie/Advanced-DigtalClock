library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity timer is
port
(
	clk_1hz,sw3:in std_logic;
	fsm_in:in std_logic_vector(2 downto 0);
	t_m1,t_m2,t_s1,t_s2,t_h1,t_h2:out std_logic_vector(3 downto 0)
);
end timer;
architecture circuit of timer is
	signal m1:std_logic_vector(3 downto 0):="0101";
	signal m2,s1,s2:std_logic_vector(3 downto 0):="0000"; 
begin
process(clk_1hz,sw3,m1,m2,s1,s2)
begin
	if(fsm_in="111")then
		if(sw3='0')then
			m2<=m2;m1<=m1;s2<=s2;s1<=s1;
		elsif(rising_edge(clk_1hz))then
			if(s2="0000")then
				if(s1="0000" and m2="0000" and m1="0000")then s2<="0000";
				else s2<="1001";
				end if;
				if(s1="0000")then
					if(m2="0000" and m1="0000")then s1<="0000";
					else s1<="0101";
					end if;
					if(m2="0000")then
						if(m1="0000")then m2<="0000";
						else m2<="1001";
						end if;
						if(m1="0000")then m1<="0000";
						else m1<=m1-1;
						end if;
					else m2<=m2-1;
					end if;
				else s1<=s1-1;
				end if;
			else s2<=s2-1;
			end if;
		end if;
	else m1<="0101";m2<="0000";s1<="0000";s2<="0000";
	end if;	
end process;
process(fsm_in,m1,m2,s1,s2)
begin
	if(fsm_in="111")then t_s2<=s2;t_s1<=s1;t_m2<=m2;t_m1<=m1;t_h2<="ZZZZ";t_h1<="ZZZZ";
	else t_s2<="ZZZZ";t_s1<="ZZZZ";t_m1<="ZZZZ";t_m2<="ZZZZ";t_h1<="ZZZZ";t_h2<="ZZZZ";
	end if;
end process;
end circuit;