----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2022 11:05:15 AM
-- Design Name: 
-- Module Name: Masking - Behavioral
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

entity Masking is
port (
    mask_control: in std_logic;-----------mask control switch
    message_in: in std_logic_vector(33 downto 0);
    masked_message: out std_logic_vector (35 downto 0)
  );
end Masking;

architecture Behavioral of Masking is
SIGNAL mask_out00, mask_out01: std_logic_vector(35 downto 0);
--------01 Masking Signal ----------------------
signal mask_messageA, mask_messageB, mask_messageC, mask_messageD: std_logic_vector(3 downto 0);
signal mask_message1A, mask_message1B, mask_message1C, mask_message1D: std_logic_vector(3 downto 0);
signal mask_messageE: std_logic_vector(1 downto 0);
signal maska, maskb: std_logic;
------------00 Masking signal------------------------
signal mmA,mm1A, mmB, mm1B, mmC,mm1C,mmD,mm1D,mmE,mm1E: std_logic_vector(1 downto 0);
signal m1,m2,m3,m4,m5,m6,m7, m1A,m2A,m3A,m4A,m5A,m6A,m7A,bba, bbb: std_logic;
--signal ctrl:std_logic;
signal before_masking : std_logic_vector(35 downto 0);

--------
begin
before_masking<= "00" & message_in;
---------------------01 Masking ------------------------

maska <= not before_masking(35);
maskb <= not before_masking(34);
  mask_messageA <= not before_masking(33 downto 30);
      mask_message1A <= before_masking(29 downto 26);
      mask_messageB <= not before_masking(25 downto 22);
        mask_message1B <= before_masking(21 downto 18);
        mask_messageC <= not before_masking(17 downto 14);
        mask_message1C <= before_masking(13 downto 10);
         mask_messageD <= not before_masking(9 downto 6);
         mask_message1D <= before_masking(5 downto 2);
         mask_messageE <= not before_masking(1 downto 0);
 -----------------00 Masking-----------------------------
---------------------------------------------------------
bba <= before_masking(35);
bbb <= not before_masking(34);
mmA <= not before_masking(33 downto 32);
  mm1A <= before_masking(31 downto 30);
  mmB <= not before_masking(29 downto 28);
  mm1B <= before_masking(27 downto 26);
  mmC <= not before_masking(25 downto 24);
  mm1C <= before_masking(23 downto 22);
  mmD <= not before_masking(21 downto 20);
  mm1D <= before_masking(19 downto 18);
  mmE <= not before_masking(17 downto 16);
  mm1E<= before_masking(15 downto 14);
  m1 <= not before_masking(13);   m1A<= before_masking(12);
  m2 <= not before_masking(11);   m2A<= before_masking(10);
  m3 <= not before_masking(9);   m3A<= before_masking(8);
  m4 <= not before_masking(7);   m4A<= before_masking(6);
  m5 <= not before_masking(5);   m5A<= before_masking(4);
  m6 <= not before_masking(3);   m6A<= before_masking(2);
  m7 <= not before_masking(1);   m7A<= before_masking(0);


mask_out01 <= (maska & maskb & mask_messageA & mask_message1A & mask_messageB & mask_message1B & mask_messageC & 
        mask_message1C & mask_messageD & mask_message1D & mask_messageE);

mask_out00 <=bba & bbb & mmA & mm1A & mmB & mm1B & mmC & mm1C & mmD & mm1D & mmE & mm1E & m1 & m1A & m2 & m2A
                        & m3 & m3A & m4 & m4A & m5 & m5A & m6 & m6A & m7 & m7A;

with mask_control select
    masked_message <= mask_out00 when '0',
                      mask_out01 when '1',
                       "000000000000000000000000000000000000" when others;

end Behavioral;
