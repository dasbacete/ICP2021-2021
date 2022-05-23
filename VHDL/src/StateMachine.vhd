library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity StateMachine is
    Port (
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
end StateMachine;


architecture Behavioral of StateMachine is
    signal state_load_c, state_load_n, flag_readyOut, start_c, start_n:std_logic;
    signal state_out_c, state_out_n:std_logic_vector(2 downto 0);
    signal counter_in_c, counter_in_n:unsigned(4 downto 0);
    signal counter_out_c, counter_out_n:unsigned(2 downto 0);
    signal address_c, address_n:unsigned(7 downto 0);
    begin
    
    --input
    start_n<=start;
    --Register
    process(clk)
    begin    
        if rising_edge(clk) then
            if rst = '0' then
                state_load_c<='0';
                state_out_c<=(others=>'0');
                counter_in_c<=(others=>'0');
                counter_out_c<=(others=>'0');
                address_c<=(others=>'0');
                start_c<='0';
            else
                state_load_c<=state_load_n;
                state_out_c<=state_out_n;
                counter_in_c<=counter_in_n;
                counter_out_c<=counter_out_n;
                address_c<=address_n;
                start_c<=start_n;
            end if;
        end if;
    end process;

    --FSM input
    process (state_load_c, start_c,counter_in_c)
    begin
        case state_load_c is 
        when '0' => --idle
            flag_readyOut<='0';
            counter_in_n<=(others=>'0');
            acc_PEs<='0';
            if(start_c='0')then
                state_load_n<='0';
            else
                state_load_n<='1';
            end if;
        when others => -- count --> reset PEs, shift, close;
           counter_in_n<=counter_in_c +1;
           case counter_in_c is 
           when "00001" | "01001" | "10001" | "11001" =>
                flag_readyOut<='0';
                acc_PEs<='1';
                state_load_n<='1';
           when "00111" | "01111" | "10111"  =>
                flag_readyOut<='1';
                acc_PEs<='0';
                state_load_n<='1';
           when "11111" =>
                flag_readyOut<='1';
                acc_PEs<='0';
                if(start_c='0')then
                    state_load_n<='0';
                else
                    state_load_n<='1';
                end if;
           when others =>
                flag_readyOut<='0';
                state_load_n<='1';
                acc_PEs<='0';
           end case;
        end case;
    end process;
     --FSM output
    process (state_out_c, flag_readyOut, address_c, counter_out_c)
    begin
        case state_out_c is
        when "000"=>
            finish<='0';
            ram_full<='0';
            address_n<=address_c;
            counter_out_n<=(others=>'0');
            web<='1';
            if flag_readyOut='1' then
                state_out_n<="001";
            else
                state_out_n<="000";
            end if;
        when "001"=>
            finish<='0';
            ram_full<='0';
            counter_out_n<=counter_out_c+1;
            case counter_out_c is
            when "000" =>
                address_n<=address_c;
                web<='1';
                state_out_n<="001";
            when "001" | "010" | "011" | "100"=>
                web<='0';
                state_out_n<="001";
                address_n<=address_c+1;
            when others=>
                address_n<=address_c;
                web<='1';
                if flag_readyOut='1' then
                    state_out_n<="010";
                else
                    state_out_n<="001";
                end if;
            end case;
        when "010"=>
            finish<='0';
            ram_full<='0';
            counter_out_n<=counter_out_c+1;
            case counter_out_c is
            when "000" =>
                address_n<=address_c;
                web<='1';
                state_out_n<="010";
            when "001" | "010" | "011" | "100"=>
                address_n<=address_c+1;
                web<='0';
                state_out_n<="010";
            when others=>
                address_n<=address_c;
                web<='1';
                if flag_readyOut='1' then
                    state_out_n<="011";
                else
                    state_out_n<="010";
                end if;
            end case;
        when "011"=>
            finish<='0';
            ram_full<='0';
            counter_out_n<=counter_out_c+1;
            case counter_out_c is
            when "000" =>
                address_n<=address_c;
                web<='1';
                state_out_n<="011";
            when "001" | "010" | "011" | "100"=>
                address_n<=address_c+1;
                web<='0';
                state_out_n<="011";
            when others=>
                address_n<=address_c;
                web<='1';
                if flag_readyOut='1' then
                    state_out_n<="100";
                else
                    state_out_n<="011";
                end if;
            end case;
        when "100"=>
            counter_out_n<=counter_out_c+1;
            case counter_out_c is
            when "000" =>
                finish<='0';
                ram_full<='0';
                address_n<=address_c;
                web<='1';
                state_out_n<="100";
            when "001" | "010" | "011" | "100" | "101" =>
                ram_full<='0';
                address_n<=address_c+1;
                web<='0';
                state_out_n<="100";
                finish<='0';
            when "110"=>
                address_n<=address_c+1;
                web<='0';
                if address_c = "10001111"then
                    ram_full<='1';
                else
                    ram_full<='0';
                end if;
                state_out_n<="000";
                finish<='1';
            when others=>
                finish<='0';
                ram_full<='0';
                address_n<=address_c;
                web<='1';
                state_out_n<="000";
            end case;
        when others=>
            finish<='0';
            address_n<=address_c;
            counter_out_n<=(others=>'0');
            web<='1';
            ram_full<='0';
            if flag_readyOut='1' then
                state_out_n<="001";
            else
                state_out_n<=state_out_c;
            end if;
        end case;
    end process;
        --OUT
    counter_in <= std_logic_vector(counter_in_c);
    counter_out<= std_logic_vector(counter_out_c);
    address <= std_logic_vector(address_c);   
    state_input<=state_load_c;
    state_output<=state_out_c;
    end Behavioral;
  