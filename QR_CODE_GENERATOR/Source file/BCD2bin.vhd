----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2022 02:35:34 AM
-- Design Name: 
-- Module Name: BCD2bin - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD2bin is
  Port ( 
        accept_in: in std_logic;
        data_in_reg: in std_logic_vector(31 downto 0);
        GROUP1_BCD: out std_logic_vector (9 downto 0):= (others => '0');
        GROUP2_BCD: out std_logic_vector (9 downto 0):= (others => '0');
        GROUP3_BCD: out std_logic_vector (7 downto 0):= (others => '0')
        
  );
end BCD2bin;

architecture Behavioral of BCD2bin is
signal bcdinput : std_logic_vector(31 downto 0);
signal bcd1a, bcd2a: std_logic_vector(15 downto 0);
signal bcd1b, bcd2b: std_logic_vector(7 downto 0);
signal bcd1c, bcd2c: std_logic_vector(7 downto 0);
signal bcd3a, bcd3b: std_logic_vector(7 downto 0);
signal data11: std_logic_vector(7 downto 0);
signal data12: std_logic_vector(7 downto 0);

signal groupA, groupB: std_logic_vector(9 downto 0);
signal groupC: std_logic_vector(7 downto 0);

begin

  bcdinput <= data_in_reg;
  data11 <= "0000" & bcdinput(31 downto 28);
  data12 <= "0000" & bcdinput(19 downto 16);
            ------------ group BCD to Binary 1---------------
  bcd1a <=std_logic_vector(unsigned(data11)*100);
  bcd1b <=std_logic_vector(unsigned(bcdinput(27 downto 24))*10);
  bcd1c <=std_logic_vector(unsigned(bcdinput(23 downto 20))*1);
            
            ------------ group BCD to Binary 2---------------
  bcd2a <=std_logic_vector(unsigned(data12)*100);
  bcd2b <=std_logic_vector(unsigned(bcdinput(15 downto 12))*10);
  bcd2c <=std_logic_vector(unsigned(bcdinput(11 downto 8))*1);
            
            ------------ group BCD to Binary 3---------------
  bcd3a <=std_logic_vector(unsigned(bcdinput(7 downto 4))*10);
  bcd3b <=std_logic_vector(unsigned(bcdinput(3 downto 0))*1);
     ------Working on the BCD to Binary block---------------
  --reg_data <= data_in_reg; --------------------------------------------Original Data Input--------------
  groupA <=(bcd1a(9 downto 0) + ("00" &  bcd1b) + ("00" &  bcd1c));
  groupB <=(bcd2a(9 downto 0) + ("00" &  bcd2b) + ("00" &  bcd2c));
  --groupC <=("00" &  bcd3a) + ("00" &  bcd3b);
  groupC <=(bcd3a) + (bcd3b);
  
  GROUP1_BCD <= groupA;
  GROUP2_BCD <= groupB;
  GROUP3_BCD <= groupC;
  
  
end Behavioral;