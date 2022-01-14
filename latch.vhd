library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity latch is
port
(
	clk,b1,b2,b3,b4:in std_logic;
	sw1,sw2,sw3,sw4:out std_logic
);
end latch;
architecture circuit of latch is
	signal s1,s2,s3,s4:std_logic;
begin
	sw1<=s1;sw2<=s2;sw3<=s3;sw4<=s4;
process()
begin
	if(rising_edge(clk))then
		if(b1='0')then s1<=not s1; end if;
		if(b2='0')then s2<=not s2; end if;
		if(b3='0')then s3<=not s3; end if;
		if(b4='0')then s4<=not s4; end if;
	end if;
end process;
end circuit;