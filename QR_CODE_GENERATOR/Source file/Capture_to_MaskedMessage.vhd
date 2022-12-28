----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/11/2022 06:28:58 PM
-- Design Name: 
-- Module Name: Capture_to_MaskedMessage - Behavioral
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
entity Capture_to_MaskedMessage is
Port ( 
        CLK100MHZ : in std_logic;
        reset : in std_logic;
        accept_in: in std_logic;
        mask_control: in  std_logic;
        data_in: in std_logic_vector(3 downto 0):= (others => '0');
        reg_data: out std_logic_vector (31 downto 0):= (others => '0');
        --message: out std_logic_vector (33 downto 0):= (others => '0');
        final_masked_message: out std_logic_vector (35 downto 0):= (others => '0')
  );
end Capture_to_MaskedMessage;

architecture Behavioral of Capture_to_MaskedMessage is
component Captureinput is
    Port ( 
        clk : in std_logic;
        reset : in std_logic;
        accept_in: in std_logic;
        data_in: in std_logic_vector(3 downto 0):= (others => '0');
        Capture_data: out std_logic_vector (31 downto 0):= (others => '0');
        message: out std_logic_vector (33 downto 0):= (others => '0')
  );
end component;

component Masking is
    port (
    mask_control: in std_logic;-----------mask control switch
    message_in: in std_logic_vector(33 downto 0);
    masked_message: out std_logic_vector (35 downto 0)
  );
  end component;
  

signal  reg_data_out: std_logic_vector (31 downto 0):= (others => '0');
signal  message_out: std_logic_vector (33 downto 0):= (others => '0');
signal message_in: std_logic_vector(33 downto 0);
signal  masked_message_out: std_logic_vector(35 downto 0);
begin

messagein : Captureinput port map(
clk => CLK100MHZ,
reset => reset,
data_in => data_in,
accept_in => accept_in,
Capture_data => reg_data_out,
message=>message_out
);

reg_data  <= reg_data_out;
--message <= message_out;
masked: Masking
    port map (
      mask_control =>mask_control,
      message_in => message_out,
      masked_message => masked_message_out
    );
    
final_masked_message <= masked_message_out;
end Behavioral;
