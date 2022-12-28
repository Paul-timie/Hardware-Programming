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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbcd2bin is
--  Port ( );
end testbcd2bin;

architecture Behavioral of testbcd2bin is
component BCD2bin is
    Port ( 
        accept_in: in std_logic;
        data_in_reg: in std_logic_vector(31 downto 0);
        GROUP1_BCD: out std_logic_vector (9 downto 0):= (others => '0');
        GROUP2_BCD: out std_logic_vector (9 downto 0):= (others => '0');
        GROUP3_BCD: out std_logic_vector (7 downto 0):= (others => '0')
  );
  
end component;


signal accept_in : std_logic;
signal data_in_reg : std_logic_vector(31 downto 0):= (others => '0');
signal GROUP1_BCD : std_logic_vector (9 downto 0):= (others => '0');
signal GROUP2_BCD : std_logic_vector (9 downto 0):= (others => '0');
signal GROUP3_BCD: std_logic_vector (7 downto 0):= (others => '0');
--constant clk_period : time := 100 ns;

begin 
uut : BCD2bin port map(
        
        accept_in => accept_in,
        data_in_reg => data_in_reg,
        GROUP1_BCD => GROUP1_BCD,
        GROUP2_BCD => GROUP2_BCD,
        GROUP3_BCD => GROUP3_BCD
);

-- Clock process to generate a clock signal
-- Testbench process to provide input and verify output
-- test stimulus
stim_process: process
begin

    accept_in <= '0';
    data_in_reg <= "00000000000000000000000000000000";
    wait for 10ns;

    accept_in <= '1';
    data_in_reg <= "10000001000000110100000000010010"; ----81,034,012
    wait for 10ns;
    accept_in <= '1';
    data_in_reg <= "00010011010001000101001000000000"; ----134452
    wait for 10ns;
    accept_in <= '1';
    data_in_reg <= "00110100000000010010000000000000"; ----34012
    wait for 10ns;
    
end process;
end Behavioral;
