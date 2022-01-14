library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity test_FSM is
end test_FSM;
architecture test of test_FSM is
	component clock_FSM 
		port
		(
			b1,b2,clk_2hz:in std_logic;
			fsm_out:out std_logic_vector(2 downto 0)
		);		
	end component;
	signal test_b1,test_b2:std_logic:='1';
	signal test_clk:std_logic:='0';
begin
	test_clk<=not test_clk after 0.01us;--2hz wave for testing fsm
	test_b2<='Z';--permentally holding on,only testing test_b1
process
begin
  test_b1<='1';--initialize the test_button_1
  wait until(test_clk='1');--waiting the first rising_edge of clk to change the state
  test_b1<='0';--press the button    
  wait until(test_clk='1');--waiting another rising_edge of clk
end process;
	TEST_finite_machine:
	clock_FSM port map(
		b1=>test_b1,
		b2=>test_b2,
		clk_2hz=>test_clk
);
end test;