----------------------------------------------------------------------------------

-- Engineer: David Albacete Segura

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RW_RAM_mod is
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
end RW_RAM_mod;

architecture Behavioral of RW_RAM_mod is

    component SRAM_SP_WRAPPER is
      port (
        ClkxCI  : in  std_logic;
        CSxSI   : in  std_logic;            -- Active Low
        WExSI   : in  std_logic;            --Active Low
        AddrxDI : in  std_logic_vector (7 downto 0);
        RYxSO   : out std_logic;
        DataxDI : in  std_logic_vector (17 downto 0);
        DataxDO : out std_logic_vector (31 downto 0)
        );
    end component;

    signal output_ram: std_logic_vector(31 downto 0);
    signal a : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal RY:std_logic;
    signal clk_div, clk_div_n: std_logic;

begin

MEM_inst: SRAM_SP_WRAPPER
Port map(
ClkxCI =>clk,
CSxSI =>'0',
WExSI=>we_in,
AddrxDI=>a,
RYxSO=>RY,
DataxDI=>d_in,
DataxDO=>output_ram
);



sequential_logic: process(clk, rst)
begin
if rising_edge(clk) then 
    if rst = '0' then 
        clk_div<='0';
    else
        clk_div<=clk_div_n;
    end if;
end if;
end process;

combnational_logic_out:process(clk_div, read_en, we_in, output_ram)
begin
	if read_en = '1' and we_in = '1' then 
	   clk_div_n<=not(clk_div);
	else
	   clk_div_n<=clk_div;
	end if;
	
	if clk_div = '1' then
	   spo_out<=output_ram(17 downto 9);
	else
	   spo_out<=output_ram(8 downto 0);
	end if;
end process;

combnational_logic_in:process(a_read,a_write,we_in)
begin
	if we_in = '0' then
		a<=a_write;
	else
	   a<=a_read;
	end if;

end process;

end Behavioral;
