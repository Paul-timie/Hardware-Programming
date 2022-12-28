----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2022 03:24:51 PM
-- Design Name: 
-- Module Name: clock - Behavioral
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

entity clock is
  Port (
         CLK100MHZ : in STD_LOGIC;
         reset : in STD_LOGIC;
         CLK60HZ: out STD_LOGIC );
         
end clock;

architecture Behavioral of clock is
 signal clk: STD_LOGIC;
 signal counter: integer range 0 to 16666667 := 0;
begin

 cd: process (reset,CLK100MHZ) begin
        if (reset ='1') then
            clk <= '0';
            counter <= 0;
         elsif rising_edge(CLK100MHZ) then
            if (counter = 16666667) then
                clk <= not (clk);
                counter <= 0;
             else
                counter <= counter + 1;
             end if;
         end if;
       end process;
       
       CLK60HZ <= clk;
                      
end Behavioral;
