----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 09:47:39 AM
-- Design Name: 
-- Module Name: QR_generator - Behavioral
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity QR_generator is
Port (clk: in std_logic;
      reset : in std_logic;
      mask_control: in  std_logic;
      masked_message: in std_logic_vector (35 downto 0);
      RegQRcode: out std_logic_vector (120 downto 0)
      );
end QR_generator;

architecture Behavioral of QR_generator is
type Main_QR is array(0 to 120) of std_logic;
-----------Signals for QR code creation--------------------
signal QR2D1 : Main_QR;
signal Reg_QRcode,regQR: std_logic_vector (120 downto 0);

-----------IINPUTS---------------------

-----------QR code signals----------------------
signal maskedM: std_logic_vector (35 downto 0);
signal mask_mode: std_logic_vector(1 downto 0);
begin


--Store_data <=QRreg_data;
--masked_message <=maskedM;
maskedM <= masked_message;
--==================================QR Code Generator Starting Here=========================================
-------------Alignment and Timing Starting----------------------------
-- ---Alignment--Blacks--------
QR2D1(0) <= '1'; QR2D1(1) <= '1'; QR2D1(2) <= '1'; QR2D1(3) <= '1'; QR2D1(4) <= '1'; QR2D1(5) <= '1';  
QR2D1(6) <= '1'; QR2D1(11) <= '1'; QR2D1(22) <= '1'; QR2D1(33) <= '1'; QR2D1(44) <= '1'; QR2D1(55) <= '1'; 
QR2D1(66) <= '1'; QR2D1(17) <= '1'; QR2D1(28) <= '1'; QR2D1(39) <= '1'; QR2D1(50) <= '1'; QR2D1(61) <= '1'; 
QR2D1(72) <= '1'; QR2D1(67) <= '1'; QR2D1(68) <= '1'; QR2D1(69) <= '1'; QR2D1(70) <= '1'; QR2D1(71) <= '1'; 
QR2D1(48) <= '1'; QR2D1(47) <= '1'; QR2D1(46) <= '1'; QR2D1(35) <= '1'; QR2D1(36) <= '1'; QR2D1(37) <= '1';
QR2D1(26) <= '1'; QR2D1(25) <= '1'; QR2D1(24) <= '1';
------------------------- Alignment White -------------------------------
QR2D1(12) <= '0'; QR2D1(13) <= '0'; QR2D1(14) <= '0'; QR2D1(15) <= '0'; QR2D1(16) <= '0';
QR2D1(23) <= '0'; QR2D1(34) <= '0'; QR2D1(45) <= '0'; QR2D1(56) <= '0'; QR2D1(57) <= '0';
QR2D1(58) <= '0'; QR2D1(59) <= '0'; QR2D1(60) <= '0'; 
QR2D1(49) <= '0'; QR2D1(38) <= '0'; QR2D1(27) <= '0';  

--------------------------- Timing --------------------------
QR2D1(88) <= '1'; QR2D1(110) <= '1'; QR2D1(8) <= '1'; QR2D1(10) <= '1'; 

---------Blanks-------------
QR2D1(99) <= '0';  QR2D1(9) <= '0';  QR2D1(7) <= '0';  QR2D1(18) <= '0';  QR2D1(29) <= '0'; QR2D1(40) <= '0';
QR2D1(51) <= '0'; QR2D1(73) <= '0';  QR2D1(83) <= '0';  QR2D1(81) <= '0';  QR2D1(79) <= '0';  QR2D1(77) <= '0';
QR2D1(62) <= '0';  QR2D1(84) <= '0';  QR2D1(82) <= '0';  QR2D1(80) <= '0';  QR2D1(78) <= '0';

-------------Alignment , Timing End and Blanks Ends here----------------------------

-----------Message input starting-----------------
------------Message----------------
QR2D1(120) <= maskedM(33); QR2D1(119) <= maskedM(32); QR2D1(109) <= maskedM(31); QR2D1(108) <= maskedM(30); -----------Mode
--------------------------===============
QR2D1(98) <= maskedM(29); QR2D1(97) <= maskedM(28); QR2D1(87) <= maskedM(27); ---------Character count

--------------------------==========-Group1============
QR2D1(86) <= maskedM(26); QR2D1(76) <= maskedM(25); QR2D1(75) <= maskedM(24); QR2D1(65) <= maskedM(23); QR2D1(64) <= maskedM(22);
QR2D1(54) <= maskedM(21); QR2D1(53) <= maskedM(20); QR2D1(43) <= maskedM(19); QR2D1(42) <= maskedM(18); QR2D1(32) <= maskedM(17);

---=========================Group 2=================
QR2D1(31) <= maskedM(16); QR2D1(21) <= maskedM(15); QR2D1(20) <= maskedM(14); QR2D1(118) <= maskedM(13); QR2D1(107) <= maskedM(12);
QR2D1(117) <= maskedM(11); QR2D1(106) <= maskedM(10); QR2D1(116) <= maskedM(9); QR2D1(105) <= maskedM(8); QR2D1(115) <= maskedM(7);

---------------------===========Group 3================
QR2D1(104) <= maskedM(6); QR2D1(114) <= maskedM(5); QR2D1(103) <= maskedM(4); QR2D1(113) <= maskedM(3);
QR2D1(102) <= maskedM(2); QR2D1(112) <= maskedM(1); QR2D1(101) <= maskedM(0); --------------

---------Two blanks converted to 1's-------
QR2D1(111)<= maskedM(34);  QR2D1(100)<=maskedM(35);
-------------======================End of Message===============

--====================== Masking Starting=====================

with mask_control select
    mask_mode <= "01" when '1',
                 "00" when others;
  
QR2D1(19) <= mask_mode(1);
QR2D1(30) <= mask_mode(0); ------------ condition for this

-----==========================End Masking==================================

----=======================Error Parity Starting===========================

QR2D1(41) <= maskedM(18) xor maskedM(19); -----12
QR2D1(52) <= maskedM(20) xor maskedM(21);
QR2D1(63) <= maskedM(22) xor maskedM(23);
QR2D1(74)  <= maskedM(24) xor maskedM(25);
QR2D1(85)  <= maskedM(26) xor maskedM(27);
QR2D1(96)  <= maskedM(12) xor maskedM(13);
QR2D1(95)  <= maskedM(10) xor maskedM(11);
QR2D1(94)  <= maskedM(8) xor maskedM(9);
QR2D1(93)  <= maskedM(6) xor maskedM(7);
QR2D1(92)  <= maskedM(4) xor maskedM(5);
QR2D1(91)  <= maskedM(2) xor maskedM(3);
QR2D1(90)  <= maskedM(0) xor maskedM(1); ------- 1
QR2D1(89)  <= QR2D1(111) xor QR2D1(100); ------------last part----------------- 0

--=========================Error Parity Ending==============================

Reg_QRcode <= std_logic_vector(QR2D1);

--==================================QR Code Generator Ending Here=========================================
process(clk,reset) is
    begin
        if (reset = '1') then
            regQR <= (others => '0');
            elsif (rising_edge(clk)) then
            if (reset = '0') then
            regQR <= Reg_QRcode;
           end if;
        end if;
    end process;
    

RegQRcode <= regQR;
end Behavioral;
