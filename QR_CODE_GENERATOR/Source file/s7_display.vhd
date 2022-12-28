----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2022 04:20:31 PM
-- Design Name: 
-- Module Name: s7_display - Behavioral
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

entity s7_display is
  Port ( swD1:in STD_LOGIC_VECTOR (3 downto 0);
         swD2:in STD_LOGIC_VECTOR (3 downto 0);
         CLK100MHZ : in STD_LOGIC;
         reset : in STD_LOGIC;
         --CLK60HZ: out STD_LOGIC;
         display : out STD_LOGIC_VECTOR (6 downto 0); 
         c : out STD_LOGIC
  );
end s7_display;

architecture Behavioral of s7_display is
    component digit1
     Port (
         sw11:in STD_LOGIC_VECTOR (3 downto 0);
         --reset: in STD_LOGIC;
         s7_right : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    component digit2
     Port (
         sw22:in STD_LOGIC_VECTOR (3 downto 0);
         --reset: in STD_LOGIC;
         s7_left : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    component Mux_display
     Port (
         led1: in STD_LOGIC_VECTOR (6 downto 0);
         led2: in STD_LOGIC_VECTOR (6 downto 0);
         sel_c : in STD_LOGIC;
         ledout: out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    component clock
     Port (
         CLK100MHZ : in STD_LOGIC;
         reset : in STD_LOGIC;
         CLK60HZ: out STD_LOGIC );
    end component;
    
signal sw1, sw2 :  STD_LOGIC_VECTOR (3 downto 0);
signal clk100,c_en, resetD ,clk60: STD_LOGIC;
signal led1D, led2D, MuxledoutD, Muxled1,Muxled2 :STD_LOGIC_VECTOR (6 downto 0);
begin

sw1 <= swD1; sw2 <= swD2; clk100<= CLK100MHZ ; 
--c_en <= c;
   resetD<=reset;

p0: digit1 port map ( sw11 => sw1,
                      --reset=> resetD,
                      s7_right => led1D);
    Muxled1<= led1D;                
p1: digit2 port map ( sw22 => sw2,
                      --reset=> resetD,
                      s7_left=> led2D);
    Muxled2<= led2D;
p2: clock port map ( CLK100MHZ => clk100,
                      reset=> resetD,
                      CLK60HZ => clk60); 
     c_en<= clk60;                
p3: Mux_display port map (led1 => Muxled1,        
                          led2 => Muxled2,
                          sel_c => c_en, 
                          ledout =>MuxledoutD ); 
    display<= MuxledoutD;
    c<= c_en;              
end Behavioral;
