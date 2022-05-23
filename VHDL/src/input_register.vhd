library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--It is assumed that the values of the matrix (32*4) are shifted in order, row-wise.
 
--This input registers allows the sifting of the values if sel_shift is high.
-- Two numbers of the input matrix values are selected at the same time through the muxes 
-- (depending on the values of sel_rows and sel_element). 
-- Values that are in the same column and adjacent rows are selected together. 
-- ie.- X(1,1) and X(2,1)
-- ie.- X(3,1) and X(4,1) 

entity input_register is
    Port (
        clk: in std_logic;
        rst: in std_logic;
        shift_input: in std_logic;
        lock_shift_reg: in std_logic;
        input_data: in std_logic_vector(15 downto 0);
        output_X_data: out std_logic_vector(15 downto 0)
        );
end input_register;
    
architecture Behavioral of input_register is
    
    signal sg_outputs: std_logic_vector(256-1 downto 0);
    signal input_shift_register,dataout, data_n,data_c : std_logic_vector(16-1 downto 0);


    signal input_rg, input_rg_next:std_logic_vector(15 downto 0);
  --  signal output_rg, output_rg_next:std_logic_vector(15 downto 0);
    signal sg_1_in:std_logic_vector(15 downto 0);
    signal sg1_to_sg2:std_logic_vector(15 downto 0);
    signal sg2_to_sg3:std_logic_vector(15 downto 0);
    signal sg3_to_sg4:std_logic_vector(15 downto 0);
    signal sg4_to_sg5:std_logic_vector(15 downto 0);
    signal sg5_to_sg6:std_logic_vector(15 downto 0);
    signal sg6_to_sg7:std_logic_vector(15 downto 0);
    signal sg7_to_sg8:std_logic_vector(15 downto 0);
    signal sg8_to_sg9:std_logic_vector(15 downto 0);
    signal sg9_to_sg10:std_logic_vector(15 downto 0);
    signal sg10_to_sg11:std_logic_vector(15 downto 0);
    signal sg11_to_sg12:std_logic_vector(15 downto 0);
    signal sg12_to_sg13:std_logic_vector(15 downto 0);
    signal sg13_to_sg14:std_logic_vector(15 downto 0);
    signal sg14_to_sg15:std_logic_vector(15 downto 0);
    signal sg15_to_sg16:std_logic_vector(15 downto 0);
    signal sg_16_out:std_logic_vector(15 downto 0);

    component sg
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           shift_input: in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (16-1 downto 0);
           data_out : out STD_LOGIC_VECTOR (16-1 downto 0));
  end component;
  
begin
                -- shift register
    st_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg_1_in,
        data_out=>sg1_to_sg2
        );
    nd_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg1_to_sg2,
        data_out=>sg2_to_sg3
        );
    rd_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg2_to_sg3,
        data_out=>sg3_to_sg4
        );
    th_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg3_to_sg4,
        data_out=>sg4_to_sg5
        );
    fifth_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg4_to_sg5,
        data_out=>sg5_to_sg6
        );
    sixth_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg5_to_sg6,
        data_out=>sg6_to_sg7
        );
    seventh_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg6_to_sg7,
        data_out=>sg7_to_sg8
        );
    eigth_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg7_to_sg8,
        data_out=>sg8_to_sg9
        );
    ninth_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg8_to_sg9,
        data_out=>sg9_to_sg10
        );
    tenth_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg9_to_sg10,
        data_out=>sg10_to_sg11
        );
    eleventh_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg10_to_sg11,
        data_out=>sg11_to_sg12
        );
    twelvth_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg11_to_sg12,
        data_out=>sg12_to_sg13
        );
    thirdteenth_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg12_to_sg13,
        data_out=>sg13_to_sg14
        );
    foutteenth_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg13_to_sg14,
        data_out=>sg14_to_sg15
        );
    fiveteenth_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg14_to_sg15,
        data_out=>sg15_to_sg16
        );
    sixteenth_sg:sg 
    port map (
        rst=>rst,
        clk=>clk,
        shift_input=>shift_input,
        data_in=>sg15_to_sg16,
        data_out=>sg_16_out
        );


    seq_procces:process(clk)
    begin
        
        if(rising_edge(clk))then
            if(rst='0') then
                input_rg<=(others=>'0');
    --          output_rg<=(others=>'0');
            else
                input_rg<=input_rg_next;
                --output_rg<=output_rg_next;
            end if;
        end if;
    end process;

    combnational_logic:process(lock_shift_reg,input_rg,sg_16_out)
        begin
            if lock_shift_reg = '1' then
               sg_1_in<=sg_16_out; --lock
            else
               sg_1_in<=input_rg; --shift input
            end if;
    end process; 

--input
input_rg_next<=input_data;
--output_rg_next<=sg_1_in;
output_X_data<=sg1_to_sg2;
end Behavioral;