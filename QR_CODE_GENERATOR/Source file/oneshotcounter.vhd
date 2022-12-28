----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:00:09 04/24/2012 
-- Design Name: 
-- Module Name:    oneshotcounter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity oneshotcounter is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           tickout : out  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (7 downto 0));
end oneshotcounter;

architecture Behavioral of oneshotcounter is
	signal r_reg,r_next : unsigned(7 downto 0);
begin
	process(clk,reset)
	begin
		if reset ='1' then
			r_reg <= (others => '0');
		elsif rising_edge(clk) then
			r_reg <= r_next;
		end if;
	end process;
	
	r_next <= (others => '0') when r_reg = 163 else
					r_reg + 1;
					
	q <= std_logic_vector(r_reg);
	tickout <= '1' when r_reg = 163 else '0';

end Behavioral;

