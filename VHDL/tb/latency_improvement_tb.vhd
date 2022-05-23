----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.02.2022 14:41:31
-- Design Name: 
-- Module Name: latency_improvement_tb - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity latency_improvement_tb is
--  Port ( );
end latency_improvement_tb;

architecture Behavioral of latency_improvement_tb is
    file file_pointer:      text;
    constant CLOCK_PERIOD: time := 10 ns;
    constant RESET_STOP: time := 40 ns;
   
    constant START_ON: time := 16*CLOCK_PERIOD;
    constant START_OFF: time := 16*CLOCK_PERIOD;

    
component toptop_PnR is
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
end component;
    
    signal rst, read_en: std_logic:='0';
    signal clk,start,finish,flag_write_end: std_logic:='0';
    signal input_data: std_logic_vector(16-1 downto 0):=(others=>'0');
    signal ram_full:std_logic;
    signal flagwrite, flagread, flag_end_read: std_logic:='0';
    signal output_ram: std_logic_vector(8 downto 0);
    signal line_c: integer:=1;
begin
    UUT: toptop_PnR
    port map(
        clk =>clk,
       rst => rst,
       start =>start,           
       finish =>finish,
       ram_full => ram_full,
       read_en =>read_en,
           input_a=> input_data(15),
           input_b=> input_data(14),
           input_c=> input_data(13),
           input_d=> input_data(12),
           input_e=> input_data(11),
           input_f=> input_data(10),
           input_g=> input_data(9),
           input_h=> input_data(8),
           input_i=> input_data(7),
           input_j=> input_data(6),
           input_k=> input_data(5),
           input_l=> input_data(4),
           input_m=> input_data(3),
           input_n=> input_data(2),
           input_o=> input_data(1),
           input_p=> input_data(0),
           
--           addres_read_a=>address_read(7),
--           addres_read_b=>address_read(6),
--           addres_read_c=>address_read(5),
--           addres_read_d=>address_read(4),
--           addres_read_e=>address_read(3),
--           addres_read_f=>address_read(2),
--           addres_read_g=>address_read(1),
--           addres_read_h=>address_read(0),
           
           output_ram_a=>output_ram(8),
           output_ram_b=>output_ram(7),
           output_ram_c=>output_ram(6),
           output_ram_d=>output_ram(5),
           output_ram_e=>output_ram(4),
           output_ram_f=>output_ram(3),
           output_ram_g=>output_ram(2),
           output_ram_h=>output_ram(1),
           output_ram_i=>output_ram(0)
--           output_ram_j=>output_ram(8),
--           output_ram_k=>output_ram(7),
--           output_ram_l=>output_ram(6),
--           output_ram_m=>output_ram(5),
--           output_ram_n=>output_ram(4),
--           output_ram_o=>output_ram(3),
--           output_ram_p=>output_ram(2),
--           output_ram_q=>output_ram(1),
--           output_ram_r=>output_ram(0)
    );
    rst <= '1' after RESET_STOP;
    clk <= not clk after CLOCK_PERIOD / 2;
    
    --start   
    process
    begin
         start<='0';
     wait for 90 ns;
         for i in 0 to 7 loop
            start<='1';
            wait for START_ON ;
            start<='0';     
            wait for START_OFF ;
         end loop;     
         wait;
     end process;
   

    process -- (clk)            -- process now contains wait statement
        constant filename:      string := "../../src/text_files/Xfiles/X_bn.txt"; -- use more than once
        file file_pointer:      text;
        variable line_content:  bit_vector(16-1 downto 0);
        variable line_num:      line; 
        variable filestatus:    file_open_status;
        
        constant filename_w:      string := "../../src/text_files/Rfiles/RAM_SIM.txt"; -- use more than once
        file out_file:      text;
        variable line_contentw:  bit_vector(8 downto 0);
        variable out_line:      line; 
        variable filestatusw:    file_open_status;
        variable fake_address:unsigned(7 downto 0):="00000000";
        
    begin
        
        if flagread = '0' then  
            report "start read trigger!!!\n";
            file_open (filestatus, file_pointer, filename, READ_MODE);
            report filename & LF & HT & " read file_open_status = " & 
                file_open_status'image(filestatus);
            assert filestatus = OPEN_OK 
            report "read file_open_status  /= file_ok"
            severity FAILURE;    -- end simulation 
            flagread <= '1';
        end if;
        
        if flagwrite = '0' then  
          
            report "start write  trigger!!!\n";
            file_open (filestatusw, out_file, filename_w, WRITE_MODE);
            report filename & LF & HT & "write file_open_status = " & 
                file_open_status'image(filestatusw);
            assert filestatusw = OPEN_OK 
            report "write file_open_status /= file_ok"
            severity FAILURE;    -- end simulation 
            flagwrite<='1';
        end if;
        
        -- read accordingly to start
        
        if (not endfile(file_pointer)) then
            wait until start ='1' ;
            wait until rising_edge (clk);
            readline(file_pointer, line_num);
            read(line_num, line_content);
            input_data<=to_stdlogicvector(line_content);
            wait until rising_edge (clk);
             while (start='1') loop
                readline(file_pointer, line_num);
                read(line_num, line_content);
                input_data<=to_stdlogicvector(line_content);
                wait until rising_edge  (clk);
            end loop;
        else
            file_close(file_pointer);
            input_data<=(others=>'0');
            wait until rising_edge (ram_full);
            read_en <='1';
            input_data(15 downto 8)<=std_logic_vector(fake_address);
            wait until rising_edge(clk);
            while true loop
                input_data(15 downto 8)<=std_logic_vector(fake_address);
                line_contentw:=to_bitvector(output_ram);
                WRITE(out_line, line_contentw);
                wait until rising_edge(clk);
                line_contentw:=to_bitvector(output_ram);
                WRITE(out_line, line_contentw);
                write(out_line, character(','));
                write(out_line, LF);
                if(unsigned(input_data(15 downto 8))=144)then
                    writeline(out_file, out_line);
                    file_close(out_file);
                    wait;
                end if;
                fake_address:=fake_address +1;
                wait until rising_edge(clk);
            end loop;
            
         end if;
    end process;
end Behavioral;


