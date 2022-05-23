----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2022 14:26:02
-- Design Name: 
-- Module Name: sg - Behavioral
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



entity sg is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           shift_input: in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (15 downto 0);
           data_out : out STD_LOGIC_VECTOR (15 downto 0));
end sg;

architecture Behavioral of sg is
    
    signal data, data_next: std_logic_vector(16-1 downto 0);
begin

--sequential logic
clock_process:process(clk)
begin
    if rising_edge(clk) then
        if(rst ='0')then
            data<=(others=>'0');
        else
            data<=data_next;
        end if;
    end if;
end process;

--combinational
combinational_process:process(data_in,data, shift_input)
begin
    if (shift_input ='1') then
        data_next<=data_in;
    else
        data_next<=data;
    end if;
end process;
-- output
data_out<=data;

end Behavioral;
