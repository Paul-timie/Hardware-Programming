----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 12:16:39 PM
-- Design Name: 
-- Module Name: test_masking - Behavioral
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

entity test_masking is
--  Port ( );
end test_masking;

architecture Behavioral of test_masking is
component Masking is
    port (
    mask_control: in std_logic;-----------mask control switch
    message_in: in std_logic_vector(33 downto 0);
    masked_message: out std_logic_vector (35 downto 0)
  );
  end component;
  
  signal mask_control: std_logic;
  signal message_in: std_logic_vector(33 downto 0);
  signal  masked_message: std_logic_vector(35 downto 0);
  constant clk_period: time := 10 ns;
begin
uut: Masking
    port map (
      mask_control =>mask_control,
      message_in => message_in,
      masked_message => masked_message
    );

clk_process: process
  begin
    mask_control <= '0';
    message_in <= "0011111000111101101110010001001110";
    wait for clk_period;
    
    mask_control <= '1';
    message_in <= "0011111000111101101110010001001110";
    wait for clk_period;
    
end process;


end Behavioral;
