----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2022 11:32:12 AM
-- Design Name: 
-- Module Name: Mux_display - Behavioral
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

entity Mux_display is
  Port ( led1: in STD_LOGIC_VECTOR (6 downto 0);
         led2: in STD_LOGIC_VECTOR (6 downto 0);
         sel_c : in STD_LOGIC;
         ledout: out STD_LOGIC_VECTOR (6 downto 0));
          
end Mux_display;

architecture Behavioral of Mux_display is
--signal clk_state : std_logic;

begin
 ledout <= led1 when (sel_c = '0') else led2;

end Behavioral;
