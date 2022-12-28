----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2022 10:24:54 PM
-- Design Name: 
-- Module Name: test_inputcapture - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_inputcapture is
--  Port ( );
end test_inputcapture;

architecture Behavioral of test_inputcapture is
component Captureinput is
    Port ( 
        clk : in std_logic;
        reset : in std_logic;
        accept_in: in std_logic;
        data_in: in std_logic_vector(3 downto 0):= (others => '0');
        Capture_data: out std_logic_vector (31 downto 0):= (others => '0');
        message: out std_logic_vector (33 downto 0):= (others => '0')
  );
end component;

signal   reset,clk ,accept_in: std_logic;
signal  data_in: std_logic_vector(3 downto 0):= (others => '0');
signal  reg_data: std_logic_vector (31 downto 0):= (others => '0');
signal  message: std_logic_vector (33 downto 0):= (others => '0');
constant clk_period : time := 10000 ps;
begin 
uut : Captureinput port map(
clk => clk,
reset => reset,
data_in => data_in,
accept_in => accept_in,
Capture_data => reg_data,
message=>message

);

-- Clock process to generate a clock signal
clk_process: process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

-- Testbench process to provide input and verify output
-- test stimulus
stim_process: process
begin
    -- initial reset
    reset <= '1';
    accept_in <= '0';
    data_in <= "0000";
    wait for clk_period;
    reset <= '0';
    --wait for clk_period/2;
    -- test input sequence-----81034012
    accept_in <= '1';
    data_in <= "1000";
    wait for clk_period;
    
    accept_in <= '1';
    data_in <= "0001";
    wait for clk_period;
    
    accept_in <= '1';
    data_in <= "0000";    
    wait for clk_period;
    
    accept_in <= '1';
    data_in <= "0011";
    wait for clk_period;
    
    accept_in <= '1';
    data_in <= "0100";
    wait for clk_period;
    
    accept_in <= '1';
    data_in <= "0000";
    wait for clk_period;
    
    accept_in <= '1';
    data_in <= "0001";
    wait for clk_period;
    
    accept_in <= '1';
    data_in <= "0010";
    wait for clk_period;
end process;
end Behavioral;