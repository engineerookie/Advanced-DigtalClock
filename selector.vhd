library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity selector is
port
(
	sw4:in std_logic;
	h1_in,h2_in,m1_in,m2_in,s1_in,s2_in:in std_logic_vector(3 downto 0);--7輸入
	c0,c1,c2,c3:out std_logic_vector(3 downto 0)--4輸出
);
end selector;
architecture circuit of selector is
begin
process(sw4)
begin
	if(sw4='1')then
		c0<=h1_in;c2<=m1_in;
		c1<=h2_in;c3<=m2_in;
	elsif(sw4='0')then
		c0<=m1_in;c2<=s1_in;
		c1<=m2_in;c3<=s2_in;
	else NULL;
	end if;
end process;
end circuit;