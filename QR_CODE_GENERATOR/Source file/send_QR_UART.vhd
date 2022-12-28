----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/14/2022 06:47:06 PM
-- Design Name: 
-- Module Name: send_QR_UART - Behavioral
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

entity send_QR_UART is
  Port ( CLK100MHZ: in std_logic; -------clock
         reset: in std_logic; -------reset
         --uart_start : in std_logic;
         --QR: in std_logic_vector(120 downto 0); -------QR Register 
       -- output_done: out std_logic;----------When it's UART done to ON the light
         --uart_data: out std_logic_vector(7 downto 0);-----Connect to UART data_to_send
         txbit : out std_logic
  
  
  );
end send_QR_UART;

architecture Behavioral of send_QR_UART is

	component uart is
      port(CLK100MHZ : in std_logic;
           reset : in std_logic;
           uart_start : in std_logic;
           data_to_send : in std_logic_vector(7 downto 0);
           uart_done : out std_logic;
           txbit : out std_logic
           );
	end component;
	
signal count : integer range 0 to 121;
signal QR_reg: std_logic_vector(120 downto 0);
signal tx_out,done, start: std_logic;
signal uart_data: std_logic_vector(7 downto 0);
begin
--QR_reg <= QR;
QR_reg <="1111111010110000010000101110101101011101011010111010011100000100001111111001100000000101101001011110111001100011010110111";
process
begin

    if reset = '1' then
        count <= 0;
        --output_done<='0';
        start <= '0';
       elsif rising_edge(done) then
            if count < 120 then
            tx_out <= QR_reg(count);
            --output_done<='0';
            start <= '1';
            count <= count + 1;
             elsif count = 120 then
             --output_done<='1';
             start <= '0';
             --done = '1'
             count <= 121;
              end if;  
      end if;
  end process;
--tx_out <= QR_reg(count);

with tx_out select
            uart_data <= "00110001" when '1',
                         "00110000" when others;

--output_done <= '1' when count = 0 else '0';  
u0: uart port map (
		CLK100MHZ => CLK100MHZ,
        reset => reset,
        uart_start => start,
        data_to_send => uart_data,
        uart_done => done,
        txbit => txbit
        );         
end Behavioral;
