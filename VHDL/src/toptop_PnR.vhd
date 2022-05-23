----------------------------------------------------------------------------------

-- Engineer: David Albacete Segura

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity toptop_PnR is
  Port (   
  	   clk : in STD_LOGIC;
	   rst : in STD_LOGIC;
           start : in STD_LOGIC;
           finish : out STD_LOGIC;
           ram_full: out STD_LOGIC;
           read_en: in std_logic;
           --INPUT 15 DOWNTO 0
           input_a: in STD_LOGIC;
           input_b: in STD_LOGIC;
           input_c: in STD_LOGIC;
           input_d: in STD_LOGIC;
           input_e: in STD_LOGIC;
           input_f: in STD_LOGIC;
           input_g: in STD_LOGIC;
           input_h: in STD_LOGIC;
           input_i: in STD_LOGIC;
           input_j: in STD_LOGIC;
           input_k: in STD_LOGIC;
           input_l: in STD_LOGIC;
           input_m: in STD_LOGIC;
           input_n: in STD_LOGIC;
           input_o: in STD_LOGIC;
           input_p: in STD_LOGIC;

--           --ADDRESS_READ 7 DOWNTO 0
--           addres_read_a: in STD_LOGIC;
--           addres_read_b: in STD_LOGIC;
--           addres_read_c: in STD_LOGIC;
--           addres_read_d: in STD_LOGIC;
--           addres_read_e: in STD_LOGIC;
--           addres_read_f: in STD_LOGIC;
--           addres_read_g: in STD_LOGIC;
--           addres_read_h: in STD_LOGIC;

           --OUTPUT_RAM 17 DOWNTO 0
           output_ram_a: out STD_LOGIC;
           output_ram_b: out STD_LOGIC;
           output_ram_c: out STD_LOGIC;
           output_ram_d: out STD_LOGIC;
           output_ram_e: out STD_LOGIC;
           output_ram_f: out STD_LOGIC;
           output_ram_g: out STD_LOGIC;
           output_ram_h: out STD_LOGIC;
           output_ram_i: out STD_LOGIC
--           output_ram_j: out STD_LOGIC;
--           output_ram_k: out STD_LOGIC;
--           output_ram_l: out STD_LOGIC;
--           output_ram_m: out STD_LOGIC;
--           output_ram_n: out STD_LOGIC;
--           output_ram_o: out STD_LOGIC;
--           output_ram_p: out STD_LOGIC;
--           output_ram_q: out STD_LOGIC;
--           output_ram_r: out STD_LOGIC

           );
end toptop_PnR;


architecture Behavioral of toptop_PnR is

Component Top is
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
end component;

Component CPAD_S_74x50u_IN is
     Port (PADIO: in STD_LOGIC; 
	   COREIO: out STD_LOGIC
	  );
end component;

Component  CPAD_S_74x50u_OUT is
     Port (COREIO: in STD_LOGIC; 
	   PADIO: out STD_LOGIC
	  );
end component;

           signal input : std_logic_vector(15 downto 0);
--           signal addres_read: std_logic_vector(7 downto 0);
           signal output_ram: std_logic_vector(8 downto 0);   
	
	   --pad io signal
	   --input
	   signal PAD_rst : std_logic;
	   signal PAD_read_en : std_logic;
	   signal PAD_clk : std_logic;
	   signal PAD_start : std_logic;
	   signal PAD_Finish : std_logic;
	   signal PAD_Ramfull : std_logic;

	   signal PAD_X_a : std_logic;
	   signal PAD_X_b : std_logic;
	   signal PAD_X_c : std_logic;
	   signal PAD_X_d : std_logic;
	   signal PAD_X_e : std_logic;
	   signal PAD_X_f : std_logic;	
	   signal PAD_X_g : std_logic;
	   signal PAD_X_h : std_logic;
	   signal PAD_X_i : std_logic;
	   signal PAD_X_j : std_logic;
	   signal PAD_X_k : std_logic;
	   signal PAD_X_l : std_logic;
	   signal PAD_X_m : std_logic;
	   signal PAD_X_n : std_logic;
	   signal PAD_X_o : std_logic;
	   signal PAD_X_p : std_logic;	

--	   signal PAD_Addr_a : std_logic;
--	   signal PAD_Addr_b : std_logic;
--	   signal PAD_Addr_c : std_logic;
--	   signal PAD_Addr_d : std_logic;
--	   signal PAD_Addr_e : std_logic;
--	   signal PAD_Addr_f : std_logic;
--	   signal PAD_Addr_g : std_logic;
--	   signal PAD_Addr_h : std_logic;



begin


input<= PAD_X_a & PAD_X_b & PAD_X_c & PAD_X_d & PAD_X_e & PAD_X_f & PAD_X_g & PAD_X_h & PAD_X_i & PAD_X_j & PAD_X_k & PAD_X_l & PAD_X_m & PAD_X_n & PAD_X_o & PAD_X_p;

--addres_read<= PAD_Addr_a & PAD_Addr_b & PAD_Addr_c & PAD_Addr_d & PAD_Addr_e & PAD_Addr_f & PAD_Addr_g & PAD_Addr_h;


TOP_inst: Top
port map(
	   clk =>PAD_clk,
       rst =>PAD_rst,
       start =>PAD_start,
       input => input,
       read_en=>PAD_read_en,
--       address_read =>addres_read,
       output_ram =>output_ram,           
       finish =>PAD_Finish,
       ram_full =>PAD_Ramfull
);


PADinstRST: CPAD_S_74x50u_IN
port map(

	PADIO => rst,
	COREIO => PAD_rst
);

PADinstREADen: CPAD_S_74x50u_IN
port map(

	PADIO => read_en,
	COREIO => PAD_read_en
);

PADinstCLK: CPAD_S_74x50u_IN
port map(
	PADIO => clk,
	COREIO => PAD_clk
);

PADinstSTART: CPAD_S_74x50u_IN
port map(
	PADIO => start,
	COREIO => PAD_start
);

PADinstXaADDRa: CPAD_S_74x50u_IN
port map(
	PADIO => input_a,
	COREIO => PAD_X_a
);

PADinstXbADDRb: CPAD_S_74x50u_IN
port map(
	PADIO => input_b,
	COREIO => PAD_X_b
);

PADinstXcADDRc: CPAD_S_74x50u_IN
port map(
	PADIO => input_c,
	COREIO => PAD_X_c
);

PADinstXdADDRd: CPAD_S_74x50u_IN
port map(
	PADIO => input_d,
	COREIO => PAD_X_d
);

PADinstXeADDRe: CPAD_S_74x50u_IN
port map(
	PADIO => input_e,
	COREIO => PAD_X_e
);

PADinstXfADDRf: CPAD_S_74x50u_IN
port map(
	PADIO => input_f,
	COREIO => PAD_X_f
);

PADinstXgADDRg: CPAD_S_74x50u_IN
port map(
	PADIO => input_g,
	COREIO => PAD_X_g
);

PADinstXhADDRh: CPAD_S_74x50u_IN
port map(
	PADIO => input_h,
	COREIO => PAD_X_h
);

PADinstXi: CPAD_S_74x50u_IN
port map(
	PADIO => input_i,
	COREIO => PAD_X_i
);

PADinstXj: CPAD_S_74x50u_IN
port map(
	PADIO => input_j,
	COREIO => PAD_X_j
);

PADinstXk: CPAD_S_74x50u_IN
port map(
	PADIO => input_k,
	COREIO => PAD_X_k
);

PADinstXl: CPAD_S_74x50u_IN
port map(
	PADIO => input_l,
	COREIO => PAD_X_l
);

PADinstXm: CPAD_S_74x50u_IN
port map(
	PADIO => input_m,
	COREIO => PAD_X_m
);

PADinstXn: CPAD_S_74x50u_IN
port map(
	PADIO => input_n,
	COREIO => PAD_X_n
);

PADinstXo: CPAD_S_74x50u_IN
port map(
	PADIO => input_o,
	COREIO => PAD_X_o
);

PADinstXp: CPAD_S_74x50u_IN
port map(
	PADIO => input_p,
	COREIO => PAD_X_p
);

--PAD_inst_Adr_a: CPAD_S_74x50u_IN
--port map(
--	PADIO => addres_read_a,
--	COREIO => PAD_Addr_a
--);

--PAD_inst_Adr_b: CPAD_S_74x50u_IN
--port map(
--	PADIO => addres_read_b,
--	COREIO => PAD_Addr_b
--);

--PAD_inst_Adr_c: CPAD_S_74x50u_IN
--port map(
--	PADIO => addres_read_c,
--	COREIO => PAD_Addr_c
--);

--PAD_inst_Adr_d: CPAD_S_74x50u_IN
--port map(
--	PADIO => addres_read_d,
--	COREIO => PAD_Addr_d
--);

--PAD_inst_Adr_e: CPAD_S_74x50u_IN
--port map(
--	PADIO => addres_read_e,
--	COREIO => PAD_Addr_e
--);

--PAD_inst_Adr_f: CPAD_S_74x50u_IN
--port map(
--	PADIO => addres_read_f,
--	COREIO => PAD_Addr_f
--);

--PAD_inst_Adr_g: CPAD_S_74x50u_IN
--port map(
--	PADIO => addres_read_g,
--	COREIO => PAD_Addr_g
--);

--PAD_inst_Adr_h: CPAD_S_74x50u_IN
--port map(
--	PADIO => addres_read_h,
--	COREIO => PAD_Addr_h
--);

PADinstRAMfull: CPAD_S_74x50u_OUT
port map(
	PADIO => ram_full,
	COREIO => PAD_Ramfull
);

PADinstFINISH: CPAD_S_74x50u_OUT
port map(
	PADIO => finish,
	COREIO => PAD_Finish
);

PADinstOUTa: CPAD_S_74x50u_OUT
port map(
	PADIO => output_ram_a,
	COREIO => output_ram(8)
);

PADinstOUTb: CPAD_S_74x50u_OUT
port map(
	PADIO => output_ram_b,
	COREIO => output_ram(7)
);

PADinstOUTc: CPAD_S_74x50u_OUT
port map(
	PADIO => output_ram_c,
	COREIO => output_ram(6)
);

PADinstOUTd: CPAD_S_74x50u_OUT
port map(
	PADIO => output_ram_d,
	COREIO => output_ram(5)
);

PADinstOUTe: CPAD_S_74x50u_OUT
port map(
	PADIO => output_ram_e,
	COREIO => output_ram(4)
);

PADinstOUTf: CPAD_S_74x50u_OUT
port map(
	PADIO => output_ram_f,
	COREIO => output_ram(3)
);

PADinstOUTg: CPAD_S_74x50u_OUT
port map(
	PADIO => output_ram_g,
	COREIO => output_ram(2)
);

PADinstOUTh: CPAD_S_74x50u_OUT
port map(
	PADIO => output_ram_h,
	COREIO => output_ram(1)
);

PADinstOUTi: CPAD_S_74x50u_OUT
port map(
	PADIO => output_ram_i,
	COREIO => output_ram(0)
);

--PAD_inst_OUT_j: CPAD_S_74x50u_OUT
--port map(
--	PADIO => output_ram_j,
--	COREIO => output_ram(8)
--);

--PAD_inst_OUT_k: CPAD_S_74x50u_OUT
--port map(
--	PADIO => output_ram_k,
--	COREIO => output_ram(7)
--);

--PAD_inst_OUT_l: CPAD_S_74x50u_OUT
--port map(
--	PADIO => output_ram_l,
--	COREIO => output_ram(6)
--);

--PAD_inst_OUT_m: CPAD_S_74x50u_OUT
--port map(
--	PADIO => output_ram_m,
--	COREIO => output_ram(5)
--);

--PAD_inst_OUT_n: CPAD_S_74x50u_OUT
--port map(
--	PADIO => output_ram_n,
--	COREIO => output_ram(4)
--);

--PAD_inst_OUT_o: CPAD_S_74x50u_OUT
--port map(
--	PADIO => output_ram_o,
--	COREIO => output_ram(3)
--);

--PAD_inst_OUT_p: CPAD_S_74x50u_OUT
--port map(
--	PADIO => output_ram_p,
--	COREIO => output_ram(2)
--);

--PAD_inst_OUT_q: CPAD_S_74x50u_OUT
--port map(
--	PADIO => output_ram_q,
--	COREIO => output_ram(1)
--);

--PAD_inst_OUT_r: CPAD_S_74x50u_OUT
--port map(
--	PADIO => output_ram_r,
--	COREIO => output_ram(0)
--);
end Behavioral;



