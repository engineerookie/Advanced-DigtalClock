library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity test_clk_alrm_set is
end entity;
architecture tst of test_clk_alrm_set is
	signal t_clk:std_logic:='0';
	signal t_b:std_logic:='1';
	signal t_fsm:std_logic_vector(2 downto 0):="000";
	signal t_sd1,t_sd2,t_sd3,t_sd4:std_logic_vector(3 downto 0):="0000";
component clk_alrm_set 
port
(
	clk_2hz,b3:in std_logic;
	fsm_in:in std_logic_vector(2 downto 0);
	sd1,sd2,sd3,sd4:out std_logic_vector(3 downto 0)
);
end component;
begin
    t_clk<=not t_clk after 0.01us;
process
begin
------test the clk_hour_set----
	t_fsm<="001";
	wait for 1ps;
	t_b<='0';
	wait for 480ns;
	t_b<='1';
------test the clk_min_set-----
	t_fsm<="010";
	wait for 1ps;
	t_b<='0';
	wait for 480ns;
	t_b<='1';	
end process;
	simulation:
	clk_alrm_set port map
	(
		clk_2hz=>t_clk,
		b3=>t_b,
		fsm_in=>t_fsm,
		sd1=>t_sd1,sd2=>t_sd2,sd3=>t_sd3,sd4=>t_sd4
	);
end tst;