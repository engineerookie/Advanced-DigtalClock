library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-----------------------狀態機實踐---------------------------------------
entity clock_FSM is 
	port
	(
		b1,b2,clk_2hz:in std_logic;--3輸入
		fsm_out:out std_logic_vector(2 downto 0)--1輸出
	 );
end clock_FSM;
architecture FSM of clock_FSM is
	type state is(s0,s1,s2,s3,s4,s5,s6,s7);--各個狀態用自定義信號來表示
	--s0=clock和alarm顯示:fsm輸出000
	--s1=clock_hour設定:fsm輸出001
	--s2=clock_min設定:fsm輸出010
	--s3=clock_sec設定:fsm輸出011
	--s4=alarm/timer_hour設定:fsm輸出100
	--s5=alarm/timer_min設定:fsm輸出101
	--s6=alarm/timer_sec設定:fsm輸出110
	--s7=timer顯示和暫停:fsm輸出111
	signal prst,nxt:state:=s0;
----------------狀態機信號流程(參照state_flow_diagram)---------------------
begin
process(prst,b1,b2)
begin
	case prst is
		when s0=>if(b1='0')then nxt<=s2;fsm_out<="010";else nxt<=s0;fsm_out<="000";end if;
		when s1=>if(b1='0')then nxt<=s4;fsm_out<="100";elsif(b2='0')then nxt<=s2;fsm_out<="010";
		else nxt<=s1;fsm_out<="001";end if;
		when s2=>if(b2='0')then nxt<=s3;fsm_out<="011";elsif(b1='0')then nxt<=s4;fsm_out<="100";
		else nxt<=s2;fsm_out<="010";end if;
		when s3=>if(b2='0')then nxt<=s1;fsm_out<="001";elsif(b1='0')then nxt<=s4;fsm_out<="100";
		else nxt<=s3;fsm_out<="011";end if;
		when s4=>if(b1='0')then nxt<=s7;fsm_out<="111";elsif(b2='0')then nxt<=s6;fsm_out<="110";
		else nxt<=s4;fsm_out<="100";end if;
		when s5=>if(b2='0')then nxt<=s4;fsm_out<="100";elsif(b1='0')then nxt<=s7;fsm_out<="111"; 
		else nxt<=s5;fsm_out<="101";end if;
		when s6=>if(b2='0')then nxt<=s5;fsm_out<="101";elsif(b1='0')then nxt<=s7;fsm_out<="111";
		else nxt<=s6;fsm_out<="110";end if;
		when s7=>if(b1='0')then nxt<=s0;fsm_out<="000";else nxt<=s7;fsm_out<="111";end if;
	end case;
end process;
---------------------------狀態機時脈----------------------------------
process(clk_2hz)
begin
	if(rising_edge(clk_2hz))then
		prst<=nxt;
	end if;
end process;
----------------------------------------------------------------------
end FSM;