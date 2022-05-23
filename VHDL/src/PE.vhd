----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2022 16:42:51
-- Design Name: 
-- Module Name: PE - Behavioral
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

entity PE is
    Port (clk: in std_logic;
           rst: in std_logic;
           new_acc : in std_logic; 
           x_in : in unsigned (7 downto 0);
           a_in : in signed (6 downto 0);
           acc_out: out signed(17 downto 0));
end PE;

architecture Behavioral of PE is
    signal acc, acc_next: signed(17 downto 0);
    
begin
--sequential logic
sequential_process:process(clk)
begin

    if(rising_edge(clk)) then
        if(rst='0')then
            acc<=(others=>'0');
        else
            acc<=acc_next;    
        end if;
    end if;
end process;

--combinational_logic
next_state:process(acc,x_in, a_in,new_acc)
begin
    if(new_acc = '0')then
        acc_next <= (signed('0'&x_in) * (a_in(6)&a_in(6)&a_in)) + acc;
    else
        acc_next <= (signed('0'&x_in) * (a_in(6)&a_in(6)&a_in)) + 0;
    end if;
end process;

-- outputs
acc_out<=acc;
end Behavioral;
