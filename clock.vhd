library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-------------------------------------------------------------------------------------	
entity clock is 
	port(
			clock,b1,b2,b3,b4:in std_logic;
			segment_out:out std_logic_vector(7 downto 0);
			scan_out:out std_logic_vector(3 downto 0);
			led,aled:out std_logic
		 );
end clock;
architecture entire_connect of clock is
-------------------------------------------------------------------------------------	
	component debounce
		port(
				clk,button1,button2,button3,button4:in std_logic;
				de_b1,de_b2,de_b3,de_b4:inout std_logic
			 );
	end component;
	component inter_clock 
		port(			
				clk:in std_logic;
				clock_1hz,clock_2hz:out std_logic
			 );
	end component;
	component clock_FSM 
		port(
				b1,b2,clk_2hz:in std_logic;
				fsm_out:out std_logic_vector(2 downto 0)
			 );
	end component;
	component scan_segment_circuit
		port(
				clk,test_rst:in std_logic;
				cnt_0,cnt_1,cnt_2,cnt_3:in std_logic_vector(3 downto 0);
				seg:out std_logic_vector(7 downto 0);
				scan:out std_logic_vector(3 downto 0)
			 );
	end component;
	component clk_alrm_set
		port(
				clk_2hz,b3:in std_logic;
				fsm_in:in std_logic_vector(2 downto 0);
				sd1,sd2,sd3,sd4:out std_logic_vector(3 downto 0)
			 );
	end component;
	component timer
		port(
				clk_1hz,sw3:in std_logic;
				fsm_in:in std_logic_vector(2 downto 0);
				t_m1,t_m2,t_s1,t_s2,t_h1,t_h2:out std_logic_vector(3 downto 0)
			 );
	end component;
	component clock_display
		port(
				clk_1hz,sw3:in std_logic;
				fsm_in:in std_logic_vector(2 downto 0);
				set1,set2:in std_logic_vector(3 downto 0);
				d_h1,d_h2,d_m1,d_m2,d_s1,d_s2:out std_logic_vector(3 downto 0);
				led,aled:out std_logic
			 );
	end component;
	component latch
		port(
				b1,b2,b3,b4:in std_logic;
				sw1,sw2,sw3,sw4:out std_logic		
			 );
	end component;
	component selector
		port(
				sw4:in std_logic;
				h1_in,h2_in,m1_in,m2_in,s1_in,s2_in:in std_logic_vector(3 downto 0);
				c0,c1,c2,c3:out std_logic_vector(3 downto 0)
		    );
	end component;
		signal fsm:std_logic_vector(2 downto 0);
		signal clock_1hz,clock_2hz:std_logic;
		signal hour_1,hour_2,min_1,min_2,sec_1,sec_2:std_logic_vector(3 downto 0);
		signal s1,s2,s3,s4:std_logic;
		signal c_0,c_1,c_2,c_3:std_logic_vector(3 downto 0);
		signal b_1,b_2,b_3,b_4:std_logic;
		signal n_sw4:std_logic;
begin
-------------------------------------------------------------------------------------
n_sw4<=fsm(0) or fsm(1) or fsm(2) or s4;
process(b_1,b_2,b_3,b_4)
begin 
	if(b_1='0')then s1<=not s1; end if;
	if(b_2='0')then s2<=not s2; end if;
	if(b_3='0')then s3<=not s3; end if;
	if(b_4='0')then s4<=not s4; end if;
end process;
-------------------------------------------------------------------------------------
	DEBOUNCE_BUTTON:
			debounce port map(
			clk=>clock,
			button1=>b1,button2=>b2,button3=>b3,button4=>b4,
			de_b1=>b_1,de_b2=>b_2,de_b3=>b_3,de_b4=>b_4
			);
	CLOCK_GENERATE:
			inter_clock port map(
			clock_1hz=>clock_1hz,
			clock_2hz=>clock_2hz,
			clk=>clock
			);
	FINITE_STATE_MACHINE:
			clock_FSM port map(
			fsm_out=>fsm,
			b1=>b_1,
			b2=>b_2,
			clk_2hz=>clock_2hz
			);
	CLOCK_function:--時鐘顯示功能 
			clock_display port map(
			fsm_in=>fsm,
			sw3=>s3,
			set1=>min_1,set2=>min_2,
			clk_1hz=>clock_1hz,
			led=>led,aled=>aled,
			d_h1=>hour_1,d_h2=>hour_2,d_m1=>min_1,d_m2=>min_2,d_s1=>sec_1,d_s2=>sec_2
			);
	TIMER_function:--倒數計時噐 
			timer port map(
			fsm_in=>fsm,
			sw3=>s3,
			clk_1hz=>clock_1hz,
			t_m1=>hour_1,t_m2=>hour_2,t_s1=>min_1,t_s2=>min_2
			);
	DIGIT_SETTING_function:--大型可顯示的4bits暫存器 
			clk_alrm_set port map(
			fsm_in=>fsm,
			clk_2hz=>clock_2hz,
			b3=>b_3,
			sd1=>hour_1,sd2=>hour_2,sd3=>min_1,sd4=>min_2
			);
	SWITCH_DISPLAY:--開關切換顯示
			selector port map(
			sw4=>n_sw4,
			h1_in=>hour_1,h2_in=>hour_2,m1_in=>min_1,m2_in=>min_2,s1_in=>sec_1,s2_in=>sec_2,
			c0=>c_0,c1=>c_1,c2=>c_2,c3=>c_3
			);
	SCAN_SEGMENT:--掃描顯示
			scan_segment_circuit port map(
			clk=>clock,
			test_rst=>'1',
			seg=>segment_out,
			scan=>scan_out,
			cnt_0=>c_0,cnt_1=>c_1,cnt_2=>c_2,cnt_3=>c_3
			);
end entire_connect;