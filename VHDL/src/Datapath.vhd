library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datapath is
  Port (
        clk: in std_logic;
        rst: in std_logic;
        web: in std_logic;
        new_input: in std_logic;
        acc_PEs: in std_logic;
        lock_shift_reg:in std_logic; -- flag to control the input shifting and flow
        input_X_data:in std_logic_vector(15 downto 0);
        input_A_data:in std_logic_vector(13 downto 0);
        counter_out: in std_logic_vector(2 downto 0); -- counter to control the muxed values to write
        matrix_num:in std_logic_vector(2 downto 0); -- signal to compute average
        output_data:out signed(17 downto 0)
        );
end Datapath;

architecture Behavioral of Datapath is
signal fIRtoPB:std_logic_vector(16-1 downto 0);
component input_register is
    Port (
        clk: in std_logic;
        rst: in std_logic;
        shift_input : in std_logic; -- reset or block PEs
        lock_shift_reg: in std_logic; -- lock input reg
        input_data: in std_logic_vector(16-1 downto 0);
        output_X_data: out std_logic_vector(16-1 downto 0)
        );
end component ;

component processing_block is
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
end component;
begin

IR: input_register
Port map(
    clk=>clk,
    rst=>rst,
    shift_input=>new_input,
    lock_shift_reg => lock_shift_reg,
    input_data=>input_X_data,
    output_X_data=>fIRtoPB
);

PB: processing_block
Port map(
        clk=>clk,
        rst=>rst,
        web=>web,
        acc_PEs=>acc_PEs,
        matrix_num=>matrix_num,
        A_data=>input_A_data,
        X_data=>fIRtoPB,
        counter_out=>counter_out,-- counter to control output
        result_matrix_data=>output_data
);
end Behavioral;