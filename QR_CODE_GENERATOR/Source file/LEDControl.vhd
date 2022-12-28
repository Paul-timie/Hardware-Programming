----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/14/2022 09:58:48 AM
-- Design Name: 
-- Module Name: LEDControl - Behavioral
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

entity LEDControl is
  Port (ledsw: in std_logic_vector(3 downto 0) ;
        accept_in, reset: in std_logic;
        led_out: out std_logic_vector(3 downto 0) 
  
  );
end LEDControl;

architecture Behavioral of LEDControl is
signal sw: std_logic_vector(3 downto 0);
begin
sw<= ledsw;

process(accept_in,sw)
begin

if accept_in ='1' and (sw = "0000" ) then
    led_out<="1111";
    elsif accept_in ='1' and (sw = "0001") then
    led_out<="0001";
    elsif accept_in ='1' and (sw = "0010") then
    led_out<="0010";
    elsif accept_in ='1' and (sw = "0011") then
    led_out<="0011";
    elsif accept_in ='1' and (sw = "0100") then
    led_out<="0100";
    elsif accept_in ='1' and (sw = "0101") then
    led_out<="0101";
    elsif accept_in ='1' and (sw = "0110") then
    led_out<="0110";
    elsif accept_in ='1' and (sw = "0111") then
    led_out<="0111";
    elsif accept_in ='1' and (sw = "1000") then
    led_out<="1000";
    end if;
end process;
end Behavioral;
