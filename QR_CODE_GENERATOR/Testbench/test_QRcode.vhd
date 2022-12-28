----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/11/2022 10:20:12 PM
-- Design Name: 
-- Module Name: test_QRcode - Behavioral
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

entity test_QRcode is
--  Port ( );
end test_QRcode;

architecture Behavioral of test_QRcode is
component QR_generator is
Port (
      mask_control: in  std_logic;
      mode_selected: out std_logic_vector(1 downto 0);
      masked_message: in std_logic_vector (35 downto 0);
      RegQRcode: out std_logic_vector (120 downto 0)
      );
end component;
signal mask_control: std_logic;
signal mode_selected: std_logic_vector(1 downto 0);
signal masked_message:  std_logic_vector (35 downto 0);
signal RegQRcode: std_logic_vector (120 downto 0);
constant clk_period: time := 10 ns;
begin
uut: QR_generator
    port map (
      mask_control => mask_control,
      mode_selected => mode_selected,
      masked_message => masked_message,
      RegQRcode => RegQRcode
    );
clk_process: process
  begin
    
    masked_message <= (others => '0');
    wait for clk_period;
    
    mask_control <= '0';
    masked_message <= "001100111011001101010010011110001101";
    wait for clk_period;
    
    mask_control <= '1';
    masked_message <= "001100111011001101010010011110001101";
    wait for clk_period;
    
end process;
end Behavioral;
