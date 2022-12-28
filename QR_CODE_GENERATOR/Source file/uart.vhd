-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

entity uart is
	port(CLK100MHZ : in std_logic;
    	 reset : in std_logic;
         uart_start : in std_logic;
         data_to_send : in std_logic_vector(7 downto 0);
         uart_done : out std_logic;
         txbit : out std_logic
         );
end uart;

architecture bhv of uart is
	component uart_tx is
       generic(
          DBIT: integer:=8;     -- # data bits
          SB_TICK: integer:=16  -- # ticks for stop bits
       );
       port(
          clk, reset: in std_logic;
          tx_start: in std_logic;
          s_tick: in std_logic;
          din: in std_logic_vector(7 downto 0);
          tx_done_tick: out std_logic;
          tx: out std_logic
       );
    end component;
    
    component oneshotcounter is
      Port ( clk : in  STD_LOGIC;
             reset : in  STD_LOGIC;
             tickout : out  STD_LOGIC;
             q : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
    
    signal buad_tick, clk50mhz : std_logic;
begin

process(CLK100MHZ,reset)
begin
	if reset = '1' then
    	clk50mhz <= '0';
    elsif rising_edge(CLK100MHZ) then
    	clk50mhz <= not clk50mhz;
    end if;
end process;

bg: oneshotcounter Port map ( 
		clk => clk50mhz,
        reset => reset,
        tickout => buad_tick,
        q => open
        );

txb: uart_tx port map(
		clk => clk50mhz, 
        reset => reset,
        tx_start => uart_start,
        s_tick => buad_tick,
        din => data_to_send,
        tx_done_tick => uart_done,
        tx => txbit
	);


end bhv;