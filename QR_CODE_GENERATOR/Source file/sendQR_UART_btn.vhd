----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2022 08:26:59 PM
-- Design Name: 
-- Module Name: sendQR_UART_btn - Behavioral
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

entity sendQR_UART_btn is
port (
    clk: in std_logic;
    reset : in std_logic;
    button: in std_logic;
    action: out std_logic
  );
end sendQR_UART_btn;

architecture Behavioral of sendQR_UART_btn is
signal state: std_logic;
begin
  -- button state logic
    process(clk, reset) is
    begin
        if (reset = '1') then
            state <= '0';
        elsif (rising_edge(clk)) then
            if (button = '1') then
                state <= '1';
            end if;
        end if;
    end process;

    -- output button state
    action <= state;
end Behavioral;
