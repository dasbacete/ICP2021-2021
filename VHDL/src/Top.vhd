library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           input : in std_logic_vector(15 downto 0);
           --address_read: in std_logic_vector(7 downto 0);
           read_en: in std_logic;
           output_ram:out std_logic_vector(8 downto 0);           
           finish : out STD_LOGIC;
           ram_full: out STD_LOGIC
           );
end Top;

architecture Behavioral of Top is
    constant ADDR_WIDTH: natural :=4;

    component StateMachine is 
        port(
          clk: in std_logic;
          rst: in std_logic;
          start: in std_logic;
          web: out std_logic;
          acc_PEs: out std_logic;
          counter_out: out std_logic_vector(2 downto 0);
          counter_in: out std_logic_vector(4 downto 0);
          address:out std_logic_vector(7 downto 0);
          state_output: out std_logic_vector(2 downto 0);
          state_input: out std_logic;
          finish: out std_logic;
          ram_full: out std_logic
          );
    end component;
    
    component Datapath is
        port(
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
    end component;
    
    component RW_RAM_mod is
      Port (
        a_read:IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        a_write : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        d_in : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        clk : IN STD_LOGIC;
        rst: in std_logic;
        we_in : IN STD_LOGIC;
        read_en : in STD_LOGIC;
        spo_out : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)

        );
    end component RW_RAM_mod;

    component HC_ROM is
     Port ( 
        clk:std_logic;
        rst:std_logic;
        enable: in std_logic;
        address: in std_logic_vector( 3 downto 0);
        rom_output: out signed(13 downto 0)
    );
    end component;
    
    --Flags, state control
    signal web, new_input, acc_PEs, finished : std_logic;
    signal matrix_num: std_logic_vector(2 downto 0);
    --counters
    signal counter_out : std_logic_vector(2 downto 0);
    signal counter_in : std_logic_vector(4 downto 0);
    --addresses
    signal ROMaddr: std_logic_vector(3 downto 0);
    signal address_write : std_logic_vector(7 downto 0);
    --data
    signal output_data : signed(18-1 downto 0);
    signal input_A_data : signed(14-1 downto 0);
    
    begin
    
    RAM_inst: RW_RAM_mod
      Port map(
        a_read=>input(15 downto 8),-- muxing of the addresses and input values with web enable
        a_write =>address_write,
        d_in =>std_logic_vector(output_data),
        clk =>clk,
        rst=>rst,
        we_in => web,
        read_en => read_en,
        spo_out=>output_ram
        );
     
    StateMachine_inst : StateMachine
       port map(
          clk=>clk,
          rst=>rst,
          start=>start,
          web=>web,
          acc_PEs=>acc_PEs,
          counter_out=>counter_out,
          counter_in=>counter_in,
          address=>address_write,
          state_output=>matrix_num,
          state_input =>new_input,
          finish=>finished,
          ram_full=>ram_full      
       ); 


    Datapath_inst : Datapath
        port map(
            clk=>clk,
            rst=>rst,
            web=>web,
            new_input=>new_input,
            acc_PEs=>acc_PEs,
            lock_shift_reg=>counter_in(4), -- flag to control the input shifting and flow
            input_X_data=>input,
            input_A_data=>std_logic_vector(input_A_data),
            counter_out=>counter_out, -- counter to control the muxed values to write
            matrix_num=>matrix_num, -- signal to compute average
            output_data=>output_data
        );
     HC_ROM_inst : HC_ROM
         port map(
              clk=>clk,
              rst=>rst,
              enable => new_input,
              address => ROMaddr,
              rom_output => input_A_data
         );
    ROMaddr<=counter_in(4)&counter_in(2 downto 0);
    finish <= finished;
end Behavioral;
