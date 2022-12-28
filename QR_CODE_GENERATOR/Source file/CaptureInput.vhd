-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2022 10:15:40 PM
-- Design Name: 
-- Module Name: CaptureInput - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use ieee.std_logic_unsigned.all;
entity CaptureInput is
  Port ( 
        clk : in std_logic;
        reset : in std_logic;
        accept_in: in std_logic;
        data_in: in std_logic_vector(3 downto 0):= (others => '0');
        Capture_data: out std_logic_vector (31 downto 0):= (others => '0');
        message: out std_logic_vector (33 downto 0):= (others => '0')
  );
end CaptureInput;

architecture Behavioral of CaptureInput is
---------Capture Input---------------------
component inputs is
    Port ( 
        clk : in std_logic;
        reset : in std_logic;
        accept_in: in std_logic;
        data_in: in std_logic_vector(3 downto 0):= (others => '0');
        reg_data: out std_logic_vector (31 downto 0):= (others => '0')
  );
  
end component;
----------------BCD Conversion---------------------
component BCD2bin is
    Port ( 
        accept_in: in std_logic;
        data_in_reg: in std_logic_vector(31 downto 0);
        GROUP1_BCD: out std_logic_vector (9 downto 0):= (others => '0');
        GROUP2_BCD: out std_logic_vector (9 downto 0):= (others => '0');
        GROUP3_BCD: out std_logic_vector (7 downto 0):= (others => '0')
  );
  
end component;
signal input: std_logic_vector(3 downto 0);
signal  reg_data: std_logic_vector (31 downto 0):= (others => '0');
signal groupC: std_logic_vector (7 downto 0);
---------------------Output wires-------------------------
signal groupA, groupB: std_logic_vector(9 downto 0);
signal mode : std_logic_vector(3 downto 0);
signal char_count: std_logic_vector(2 downto 0);

begin
input <= data_in;
Cap_input : inputs port map(
clk => clk,
reset => reset,
data_in => input,
accept_in => accept_in,
reg_data => reg_data
);
Capture_data <= reg_data;
BCDConv : BCD2bin port map(
        
        accept_in => accept_in,
        data_in_reg => reg_data,
        GROUP1_BCD => groupA,
        GROUP2_BCD => groupB,
        GROUP3_BCD => groupC
);

   --------------Main Data Output For the feed to the QR code generator-------------------------------------
   mode <= "0011";
   char_count <= "111";
   message <=mode & char_count & groupA & groupB & groupC(6 downto 0);
end Behavioral;