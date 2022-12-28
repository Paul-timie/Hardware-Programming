----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2022 11:27:05 AM
-- Design Name: 
-- Module Name: digit2 - Behavioral
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

entity digit2 is
  Port ( sw22:in STD_LOGIC_VECTOR (3 downto 0);
        -- reset: in STD_LOGIC;
         s7_left : out STD_LOGIC_VECTOR (6 downto 0));
end digit2;

architecture Behavioral of digit2 is

begin
--cd: process (reset) begin
 ---       if (reset ='1') then
 --           s7_left <= "0000000";
  --       else
           
   --   end if;
   -- end process;
process(sw22)
  begin
  
    case sw22 is
        when "0000" => s7_left <= "0111111"; 
        when "0001" => s7_left <= "0000110"; 
        when "0010" => s7_left <= "1011011"; 
        when "0011" => s7_left <= "1001111"; 
        when "0100" => s7_left <= "1100110"; 
        when "0101" => s7_left <= "1101101"; 
        when "0110" => s7_left <= "1111101"; 
        when "0111" => s7_left <= "0000111"; 
        when "1000" => s7_left <= "1111111"; 
        when "1001" => s7_left <= "1101111"; 
        when others => s7_left <= "0000000"; 
    end case;
  end process;

end Behavioral;
