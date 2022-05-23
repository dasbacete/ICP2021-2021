----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2022 14:15:37
-- Design Name: 
-- Module Name: processing_block - Behavioral
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

entity processing_block is
  Port (
        clk: in std_logic;
        rst: in std_logic;
        web: in std_logic;--
        acc_PEs: in std_logic;
        matrix_num: in std_logic_vector(2 downto 0);
        A_data: in std_logic_vector(13 downto 0);
        X_data: in std_logic_vector(15 downto 0);
        counter_out: in std_logic_vector(2 downto 0);-- counter to control output
        result_matrix_data: out signed(17 downto 0)
        );
end processing_block;

architecture Behavioral of processing_block is
signal processed_out,PE_out : signed(17 downto 0);
signal max_value,max_value_next : signed(17 downto 0);
signal avg_value,avg_value_next,avg_div : signed(17 downto 0);
-----------------------------PE BLOCK --------------------------
component PE is
    Port (clk: in std_logic;
           rst: in std_logic;
           new_acc : in std_logic; 
           x_in : in unsigned (7 downto 0);
           a_in : in signed (6 downto 0);
           acc_out: out signed(17 downto 0));
end component;

--PE1
    --buffer
signal ResultPe1:signed (17 downto 0);
--------------------------------------------------------
--PE2
    --buffer
signal ResultPe2,ResultPe2_next:signed (17 downto 0);
--------------------------------------------------------
--PE3
    --buffer
signal ResultPe31,ResultPe31_next,ResultPe32,ResultPe32_next:signed (17 downto 0);
--------------------------------------------------------
--PE4
    --buffer
signal ResultPe41,ResultPe41_next,ResultPe42,ResultPe42_next,ResultPe43,ResultPe43_next:signed (17 downto 0);
--------------------------------------------------------
begin
--PE1 n buffer

PE1: PE
Port map(
           clk=>clk,
           rst=>rst,
           new_acc => acc_PEs, -- finished column
           x_in => unsigned(X_data(15 downto 8)),
           a_in =>signed(A_data(13 downto 7)),
           acc_out=>ResultPe1
);

--PE2 n buffer
PE2: PE
Port map(
           clk=>clk,
           rst=>rst,
           new_acc =>  acc_PEs, -- finished column
           x_in => unsigned(X_data(7 downto 0)),
           a_in =>signed(A_data(6 downto 0)),
           acc_out=>ResultPe2_next
);
--------------------------------------------------
--PE3 n buffer
ResultPe32_next<=ResultPe31;
PE3: PE
Port map(
           clk=>clk,
           rst=>rst,
           new_acc =>  acc_PEs, -- finished column
           x_in => unsigned(X_data(15 downto 8)),
           a_in =>signed(A_data(6 downto 0)),
           acc_out=>ResultPe31_next
);
--------------------------------------------------
--PE4 n buffer
ResultPe42_next<=ResultPe41;
ResultPe43_next<=ResultPe42;
PE4: PE
Port map(
           clk=>clk,
           rst=>rst,
           new_acc =>acc_PEs, -- finished column
           x_in => unsigned(X_data(7 downto 0)),
           a_in =>signed(A_data(13 downto 7)),
           acc_out=>ResultPe41_next
);
--------------------------------------------------
sequential_process:process(clk)
begin

    if(rising_edge(clk))then
        if (rst='0')then
            max_value<="100000000000000000";
            avg_value<=(others=>'0');
            
            ResultPe2<=(others=>'0');

            ResultPe31<=(others=>'0');
            ResultPe32<=(others=>'0');

            ResultPe41<=(others=>'0');
            ResultPe42<=(others=>'0');
            ResultPe43<=(others=>'0');
        else
            max_value<=max_value_next;
            avg_value<=avg_value_next;

            ResultPe2<=ResultPe2_next;

            ResultPe31<=ResultPe31_next;
            ResultPe32<=ResultPe32_next;

            ResultPe41<=ResultPe41_next;
            ResultPe42<=ResultPe42_next;
            ResultPe43<=ResultPe43_next;
        end if;
    end if;
end process;

combinational_process: process(matrix_num,PE_out,counter_out,max_value,avg_div,avg_value,processed_out,web,ResultPe1,ResultPe2,ResultPe43,ResultPe32)
begin
    
    -----------------------
    --muxed values
    if (counter_out="001") then
        PE_out<=ResultPe1;
        processed_out<=PE_out;
    elsif (counter_out="010") then
        PE_out<=ResultPe2;
        processed_out<=PE_out;
    elsif (counter_out="011") then
        PE_out<=ResultPe32;
        processed_out<=PE_out;
    elsif (counter_out="100") then
        PE_out<=ResultPe43;
        processed_out<=PE_out;
    elsif (counter_out="101") then
        processed_out<=avg_div;
        PE_out<=(others=>'0');
    elsif (counter_out="110") then
        processed_out<=max_value;
        PE_out<=(others=>'0');
    else
        processed_out<=(others=>'0'); 
        PE_out<=(others=>'0');  
    end if;
    
    ----------------------
    -- max and avg value storage
    if matrix_num /= "000" then 
        if(web = '0')then
            if (max_value<PE_out) then
                max_value_next<=PE_out;
            else
               max_value_next<=max_value;
           end if;
           if (matrix_num= "001" or matrix_num="100")then
               if(counter_out = "001" or counter_out = "010" )then
                    avg_value_next<=avg_value + PE_out;
                else
                    avg_value_next<=avg_value;
                end if;
           else
             avg_value_next<=avg_value;
           end if;
        else
            max_value_next<=max_value;
            avg_value_next<=avg_value;
        end if;
    else
        max_value_next<="100000000000000000";
        avg_value_next<=(others=>'0');
    end if;
end process;

-- outputs
result_matrix_data<=processed_out;
avg_div<=avg_value(17)&avg_value(17)&avg_value(17 downto 2);
end Behavioral;
