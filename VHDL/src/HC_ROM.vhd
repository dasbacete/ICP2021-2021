----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2022 11:12:52
-- Design Name: 
-- Module Name: HC_ROM - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HC_ROM is
 Port ( 
    clk:std_logic;
    rst:std_logic;
    enable: in std_logic;
    address: in std_logic_vector( 3 downto 0);
    rom_output: out signed(13 downto 0)
    );
end HC_ROM;

architecture Behavioral of HC_ROM is


type rom_data is array(0 to (2**(4)-1)) of signed((14 - 1) downto 0);

constant data: rom_data:=
-- find other matrixes at the end of the file
(                                       
"00000110001000",
"00101100001111",
"00010110000010",
"00000010000100",
"00010000001100",
"00000110000110",
"00000010000001",
"00000100000010",
"00100100000001",
"01010000001010",
"00000110000100",
"00000100000000",
"00100000000010",
"00010010001100",
"00000010000001",
"00000100000010"
--   to_signed(1,7) & to_signed(9,7),
--   to_signed(2,7) & to_signed(0,7),     
--   to_signed(3,7) & to_signed(1,7),
--   to_signed(4,7) & to_signed(2,7),
--   to_signed(5,7) & to_signed(3,7),
--   to_signed(6,7) & to_signed(4,7),
--   to_signed(7,7) & to_signed(5,7),
--   to_signed(8,7) & to_signed(6,7),
--   to_signed(7,7) & to_signed(5,7),
--   to_signed(8,7) & to_signed(6,7),
--   to_signed(9,7) & to_signed(7,7),
--   to_signed(0,7) & to_signed(8,7),
--   to_signed(1,7) & to_signed(9,7),
--   to_signed(2,7) & to_signed(0,7),
--   to_signed(3,7) & to_signed(1,7),
--   to_signed(4,7) & to_signed(2,7)
   );

signal data_o, data_next: signed((14 - 1) downto 0);

begin

sequential_process:process(clk)
begin
    
    if(rising_edge(clk))then
        if(rst='0')then
            data_o<=(others=>'0');
        else
            data_o<=data_next;
        end if;    
    end if;
end process;

combinational_logic: process(enable,address)
begin
if enable='1' then
    data_next<= data(to_integer(unsigned(address)));
else
    data_next<=(others=>'0');
end if;
end process;
rom_output<=data_o;
end Behavioral;

--( -- Matrix 2
----   -1000
----   0-100
----   00-10
----   000-1
----   -1000
----   0-100
----   00-10
----   000-1                                       
--   to_signed(-1,7) & to_signed(0,7),
--   to_signed(0,7) & to_signed(-1,7),
--   to_signed(0,7) & to_signed(0,7),
--   to_signed(0,7) & to_signed(0,7),
--   to_signed(-1,7) & to_signed(0,7),
--   to_signed(0,7) & to_signed(-1,7),
--   to_signed(0,7) & to_signed(0,7),
--   to_signed(0,7) & to_signed(0,7),
--   to_signed(0,7) & to_signed(0,7),
--   to_signed(0,7) & to_signed(0,7),
--   to_signed(-1,7) & to_signed(0,7),
--   to_signed(0,7) & to_signed(-1,7),
--   to_signed(0,7) & to_signed(0,7),
--   to_signed(0,7) & to_signed(0,7),
--   to_signed(-1,7) & to_signed(0,7),
--   to_signed(0,7) & to_signed(-1,7)
   
--);

--( -- Matrix 2 
----  4 3 2 1
---- -1-2-3-4
----  1 2 3 4
---- -4-3-2-1
---- -4 3 2-1
----  1-2-3 4
---- -1 3 2-4
----  4-2-3 1                                      
--   to_signed(4,7) & to_signed(3,7),
--   to_signed(-1,7) & to_signed(-2,7),
--   to_signed(1,7) & to_signed(2,7),
--   to_signed(-4,7) & to_signed(-3,7),
--   to_signed(-4,7) & to_signed(3,7),
--   to_signed(1,7) & to_signed(-2,7),
--   to_signed(-1,7) & to_signed(3,7),
--   to_signed(4,7) & to_signed(-2,7),
--   to_signed(2,7) & to_signed(1,7),
--   to_signed(-3,7) & to_signed(-4,7),
--   to_signed(3,7) & to_signed(4,7),
--   to_signed(-2,7) & to_signed(-1,7),
--   to_signed(2,7) & to_signed(-1,7),
--   to_signed(-3,7) & to_signed(4,7),
--   to_signed(2,7) & to_signed(-4,7),
--   to_signed(3,7) & to_signed(1,7)
   
--);
