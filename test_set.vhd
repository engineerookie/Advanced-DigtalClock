library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity test_set is
end test_set;
architecture A of test_set is
component clk_alrm_set is
port
(
	clk_2hz,b3:in std_logic;
	fsm_in:in std_logic_vector(2 downto 0);
	sd1,sd2,sd3,sd4:out std_logic_vector(3 downto 0)
);
end component;
	signal t_clk,t_b:std_logic:='1';
	signal t_fsm:std_logic_vector(2 downto 0):="000";
begin
	t_clk<=not t_clk after 0.02us;
process
begin
	t_fsm<="001";
	t_b<='0';
	wait for 0.5us;
	t_b<='1';
	wait for 0.01us;
-----------------------
	t_fsm<="010";
	t_b<='0';
	wait for 0.5us;
	t_b<='1';
	wait for 0.01us;
-----------------------
	t_fsm<="011";
	t_b<='0';
	wait for 0.5us;
	t_b<='1';
	wait for 0.01us;
-----------------------
	t_fsm<="100";
	t_b<='0';
	wait for 0.5us;
	t_b<='1';
	wait for 0.01us;
-----------------------
	t_fsm<="101";
	t_b<='0';
	wait for 0.5us;
	t_b<='1';
	wait for 0.01us;
-----------------------
	t_fsm<="110";
	t_b<='0';
	wait for 0.5us;
	t_b<='1';
	wait for 0.01us;
end process;
TEST:clk_alrm_set port map
(
	clk_2hz=>t_clk,
	b3=>t_b,
	fsm_in=>t_fsm
);
end A;