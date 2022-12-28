----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2022 09:03:45 PM
-- Design Name: 
-- Module Name: QR_to_board_testbench - Behavioral
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

entity QR_to_board_testbench is
--  Port ( );
end QR_to_board_testbench;

architecture Behavioral of QR_to_board_testbench is
component QRcode_Board is
    Port ( 
        CLK100MHZ : in std_logic;
        Main_reset : in std_logic;
        accept_in: in std_logic;
        mask_control: in  std_logic;
        create_QR_btn: in std_logic;
        send_QR_btn: in std_logic;
        data_in: in std_logic_vector(3 downto 0);
        createQR_LED: out std_logic;
        sendQR_LED: out std_logic;
        LEDS: out std_logic_vector(3 downto 0):= (others => '0');
        S7display : out STD_LOGIC_VECTOR (6 downto 0);
        cat : out STD_LOGIC;
        Regdata: out std_logic_vector (31 downto 0):= (others => '0');
        --message: out std_logic_vector (33 downto 0):= (others => '0');
        Message_masked: out std_logic_vector (35 downto 0):= (others => '0');
        Gen_QRcode: out std_logic_vector (120 downto 0):=(others => '0');
        Send_Gen_QRcode: out std_logic_vector (120 downto 0):=(others => '0')
        
  );
end component;
signal  CLK100MHZ,Main_reset,cat, accept_in, mask_control,create_QR_btn,send_QR_btn : std_logic;
signal   createQR_LED,sendQR_LED: std_logic;
signal  data_in, LEDS: std_logic_vector(3 downto 0):= (others => '0');
signal S7display : STD_LOGIC_VECTOR (6 downto 0);
signal Message_Masked:  std_logic_vector (35 downto 0):= (others => '0');
signal Gen_QRcode,Send_Gen_QRcode: std_logic_vector (120 downto 0):= (others => '0');
signal Regdata: std_logic_vector (31 downto 0):= (others => '0');
constant clk_period : time := 10000 ps;
begin

QR: QRcode_Board port map(
------------Input--------------------
CLK100MHZ => CLK100MHZ,
Main_reset => Main_reset,
data_in => data_in,
accept_in => accept_in,
mask_control => mask_control,
create_QR_btn => create_QR_btn,
send_QR_btn=> send_QR_btn,


----------Output-------------

cat=> cat,
LEDS => LEDS,
createQR_LED => createQR_LED,
sendQR_LED => sendQR_LED,
S7display => S7display,
Regdata => Regdata,
Message_masked=>Message_masked,
Gen_QRcode => Gen_QRcode,
Send_Gen_QRcode =>  Send_Gen_QRcode
);
clk_process: process
begin
    CLK100MHZ <= '0';
    wait for clk_period/2;
    CLK100MHZ <= '1';
    wait for clk_period/2;
end process;

stim_process: process
begin
    -- initial reset
    Main_reset <= '1';
    accept_in <= '0';
    data_in <= "0000";
    --mask_control <= '0';
    create_QR_btn <= '0';
    send_QR_btn <= '0';
    wait for clk_period;
    Main_reset <= '0';
    --wait for clk_period/2;
    -- test input sequence-----81034012
    -------Mask control = 00=---------------
    accept_in <= '1';
    data_in <= "0011";
    mask_control <= '1';
    create_QR_btn <= '0';
    send_QR_btn <= '0';
    wait for clk_period;
    
    accept_in <= '1';
    data_in <= "0100";
    mask_control <= '1';
    create_QR_btn <= '0';
    send_QR_btn <= '0';
    wait for clk_period;
    
    accept_in <= '1';
    data_in <= "0000";
    mask_control <= '1';
    create_QR_btn <= '0';
    send_QR_btn <= '0';    
    wait for clk_period;
    
    accept_in <= '1';
    data_in <= "0001";
    mask_control <= '1';
    create_QR_btn <= '0';
    send_QR_btn <= '0';
    wait for clk_period;
    
    accept_in <= '1';
    data_in <= "0010";
    mask_control <= '1';
    create_QR_btn <= '0';
    send_QR_btn <= '0';
    wait for clk_period;
    
    
    --------------------------------------------------------------------------
    accept_in <= '0';
    mask_control <= '1';
    create_QR_btn <= '1';
    send_QR_btn <= '0';
    wait for clk_period;
    
    accept_in <= '0';
    mask_control <= '1';
    create_QR_btn <= '1';
    send_QR_btn <= '1';
    wait for clk_period;
    
    
end process;
end Behavioral;
