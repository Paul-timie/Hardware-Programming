----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/14/2022 10:23:03 AM
-- Design Name: 
-- Module Name: QRcode_Board - Behavioral
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

entity QRcode_Board is
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
end QRcode_Board;

architecture Behavioral of QRcode_Board is
component Capture_to_MaskedMessage is
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
end component;

component QR_generator is
Port (
      clk: in std_logic;
      reset : in std_logic;
      mask_control: in  std_logic;
      masked_message: in std_logic_vector (35 downto 0);
      RegQRcode: out std_logic_vector (120 downto 0)
      );
end component;

component LEDControl is
  Port (--clk: in std_logic;
        ledsw: in std_logic_vector(3 downto 0);
        reset: in std_logic;
        accept_in: in std_logic;
        led_out: out std_logic_vector(3 downto 0) 
  
  );
end component;
component create_QR_button is
  port (
    clk: in std_logic;
    reset: in std_logic;
    button: in std_logic;
    action: out std_logic
  );
end component;

component sendQR_UART_btn is
  port (
    clk: in std_logic;
    reset: in std_logic;
    button: in std_logic;
    action: out std_logic
  );
end component;

component s7_display is
  Port ( swD1:in STD_LOGIC_VECTOR (3 downto 0);
         swD2:in STD_LOGIC_VECTOR (3 downto 0);
         CLK100MHZ : in STD_LOGIC;
         reset : in STD_LOGIC;
         display : out STD_LOGIC_VECTOR (6 downto 0); 
         c : out STD_LOGIC
  );
end component;

	
signal  clkQR,resetQR,c_en, accept_inQR, mask_controlQR, createQR,sendQR, cQR_ledON, cQR_ledOFF: std_logic;
signal  data_inQR, led_outQR: std_logic_vector(3 downto 0):= (others => '0');
signal  reg_data: std_logic_vector (31 downto 0):= (others => '0');
signal  messageQR: std_logic_vector (35 downto 0):= (others => '0');
signal display : STD_LOGIC_VECTOR (6 downto 0);
signal final_masked_messageQR:  std_logic_vector (35 downto 0):= (others => '0');
signal RegQRcodeQR,RegQRcodeQR_e: std_logic_vector (120 downto 0):= (others => '0');
begin

clkQR<=CLK100MHZ;
resetQR<=Main_reset;
data_inQR<= data_in;
mask_controlQR<= mask_control;
-----------------------4 LEDs control---------------
LED: LEDControl port map (
        --clk=> clkQR,
        ledsw => data_inQR,
        reset => resetQR,
        accept_in => accept_in,
        led_out => led_outQR

);
LEDS <= led_outQR;
-----------------------7segment---------------
s7: s7_display Port map ( 
         swD1 => data_inQR,
         swD2 => data_inQR,
         reset => resetQR,
         CLK100MHZ => clkQR,
         display => display,
         c => c_en 
  );
 S7display<=  display;
 cat<= c_en;
--------------create QR button--------------------
Create_QR: create_QR_button port map (
        clk=> clkQR,
        reset => resetQR,
        button => create_QR_btn,
        action => createQR

);
createQR_LED <=createQR;

Send_QR_UART_Btn: sendQR_UART_btn port map (
        clk=> clkQR,
        reset => resetQR,
        button => send_QR_btn,
        action => sendQR

);
sendQR_LED <= sendQR;
 -----------------------Masked Message---------------
capture_to_masked : Capture_to_MaskedMessage port map(
CLK100MHZ => clkQR,
reset => resetQR,
data_in => data_in,
mask_control => mask_control,
accept_in => accept_in,
reg_data => reg_data,
final_masked_message => messageQR
);
Regdata <= reg_data;
final_masked_messageQR <= messageQR;
Message_masked <= messageQR;
-----------------------QR code generation---------------
QR_gen: QR_generator
    port map (
      clk=> clkQR,
      reset => resetQR,
      mask_control => mask_control,
      masked_message => final_masked_messageQR,
      RegQRcode => RegQRcodeQR
    );
    
RegQRcodeQR_e <= (others => '0');

Gen_QRcode <= RegQRcodeQR when (createQR = '1') else RegQRcodeQR_e ;
Send_Gen_QRcode <= RegQRcodeQR when (sendQR = '1') else RegQRcodeQR_e ;
end Behavioral;
