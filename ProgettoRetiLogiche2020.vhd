----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2020 15:19:43
-- Design Name: 
-- Module Name: 10584373 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity project_reti_logiche is
    Port (
            i_clk       : in std_logic;
            i_start     : in std_logic;
            i_rst       : in std_logic;
            i_data      : in std_logic_vector (7 downto 0);
            o_address   : out std_logic_vector (15 downto 0);
            o_done      : out std_logic;
            o_en        : out std_logic;
            o_we        : out std_logic;
            o_data      : out std_logic_vector (7 downto 0)
    );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is

    type status is (reset, idle, get_ADDR, get_WZ0, get_WZ1 , get_WZ2, get_WZ3, get_WZ4, get_WZ5, get_WZ6, get_WZ7, check_WZ0, check_WZ1, check_WZ2, check_WZ3, check_WZ4, check_WZ5, check_WZ6, check_WZ7, save, ending);
    
    signal current_state: status := reset;
    signal ADDR: std_logic_vector(7 downto 0);
    signal WZ0: std_logic_vector(7 downto 0);
    signal WZ1: std_logic_vector(7 downto 0);
    signal WZ2: std_logic_vector(7 downto 0);
    signal WZ3: std_logic_vector(7 downto 0);
    signal WZ4: std_logic_vector(7 downto 0);
    signal WZ5: std_logic_vector(7 downto 0);
    signal WZ6: std_logic_vector(7 downto 0);
    signal WZ7: std_logic_vector(7 downto 0);
    signal output: std_logic_vector (7 downto 0);
    

    
begin

   FSM: process(i_clk)
    begin
           
       if i_clk'event and i_clk = '0' then
        
            if i_rst = '1' then
                current_state <= reset;            
                
            else
           
                case current_state is
                    when reset =>
                        o_address <= (others =>'0');
                        o_en <= '0';
                        o_we <= '0';
                        o_done <= '0';
                        o_data <= "00000000";
                        ADDR <= (others => '0');
                        WZ0 <= "00000000";
                        WZ1 <= "00000000";
                        WZ2 <= "00000000";
                        WZ3 <= "00000000";
                        WZ4 <= "00000000";
                        WZ5 <= "00000000";
                        WZ6 <= "00000000";
                        WZ7 <= "00000000";
                        output <= (others => '0');
                       current_state <= idle;
                    when idle =>
                        if (i_start = '1') then
                            o_en <= '1'; 
                            o_address <= "0000000000001000";
                            current_state <= get_ADDR;                                
                        else
                            o_done <= '0';
                            current_state <= idle;
                        end if;
                        
                    when get_ADDR =>
                        ADDR <= i_data;
                        o_address <= "0000000000000000";
                        current_state <= get_WZ0;
                    
                    when get_WZ0 =>
                        WZ0 <= i_data;
                        current_state <= check_WZ0;                                                  

                    when check_WZ0 =>
                        
                        if (ADDR = WZ0)then   
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10000001";
                            current_state <= save;                         
                        elsif(ADDR = (WZ0 + 1)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10000010";
                            current_state <= save;
                        elsif(ADDR = (WZ0 +2)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10000100";
                            current_state <= save;
                        elsif(ADDR = (WZ0 +3)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10001000";
                            current_state <= save;
                        else 
                            o_address <= "0000000000000001";
                            current_state <= get_WZ1;                            
                        end if;
                        
                    when get_WZ1 =>
                        WZ1 <= i_data;
                        current_state <= check_WZ1;      
                                      
                    when check_WZ1 =>
                        if (ADDR = WZ1)then  
                            o_we <= '1';
                            o_address <= "0000000000001001"; 
                            output <= "10010001";
                            current_state <= save;                         
                        elsif(ADDR = (WZ1 + 1)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10010010";
                            current_state <= save;
                        elsif(ADDR = (WZ1 +2)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10010100";
                            current_state <= save;
                        elsif(ADDR = (WZ1 +3)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10011000";
                            current_state <= save;
                        else 
                            o_address <= "0000000000000010";
                            current_state <= get_WZ2;                            
                        end if;                        
                    
                    when get_WZ2 =>
                        WZ2 <= i_data;
                        current_state <= check_WZ2;      
 
                    
                    when check_WZ2 =>
                        if (ADDR = WZ2)then   
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10100001";
                            current_state <= save;                         
                        elsif(ADDR = (WZ2 + 1)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10100010";
                            current_state <= save;
                        elsif(ADDR = (WZ2 +2)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10100100";
                            current_state <= save;
                        elsif(ADDR = (WZ2 +3)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10101000";
                            current_state <= save;
                        else 
                            o_address <= "0000000000000011";
                            current_state <= get_WZ3;                            
                        end if;                    
                    
                    when get_WZ3 =>
                        WZ3 <= i_data;
                        current_state <= check_WZ3;      
 
                        
                    when check_WZ3 =>
                        if (ADDR = WZ3)then   
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10110001";
                            current_state <= save;                         
                        elsif(ADDR = (WZ3 + 1)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10110010";
                            current_state <= save;
                        elsif(ADDR = (WZ3 +2)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10110100";
                            current_state <= save;
                        elsif(ADDR = (WZ3 +3)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "10111000";
                            current_state <= save;
                        else 
                            o_address <= "0000000000000100";
                            current_state <= get_WZ4;                            
                        end if;   
                    
                    when get_WZ4 =>
                        WZ4 <= i_data;
                        current_state <= check_WZ4;                                                
                    when check_WZ4 =>
                        if (ADDR = WZ4)then  
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "11000001";
                            current_state <= save;                         
                        elsif(ADDR = (WZ4 + 1)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "11000010";
                            current_state <= save;
                        elsif(ADDR = (WZ4 +2)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "11000100";
                            current_state <= save;
                        elsif(ADDR = (WZ4 +3)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "11001000";
                            current_state <= save;
                        else 
                            o_address <= "0000000000000101";
                            current_state <= get_WZ5;                            
                        end if;  
                        
                    when get_WZ5 =>
                        WZ5 <= i_data;
                        current_state <= check_WZ5;                                                 
                    when check_WZ5 =>
                        if (ADDR = WZ5)then  
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "11010001";
                            current_state <= save;                         
                        elsif(ADDR = (WZ5 + 1)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "11010010";
                            current_state <= save;
                        elsif(ADDR = (WZ5 +2)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "11010100";
                            current_state <= save;
                        elsif(ADDR = (WZ5 +3)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "11011000";
                            current_state <= save;
                        else 
                            o_address <= "0000000000000110";
                            current_state <= get_WZ6;                            
                        end if;                    
                     when get_WZ6 =>
                        WZ6 <= i_data;
                        current_state <= check_WZ6;                                      
                        
                    when check_WZ6 =>
                        if (ADDR = WZ6)then  
                            o_we <= '1';
                            o_address <= "0000000000001001"; 
                            output <= "11100001";
                            current_state <= save;                         
                        elsif(ADDR = (WZ6 + 1)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "11100010";
                            current_state <= save;
                        elsif(ADDR = (WZ6 +2)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "11100100";
                            current_state <= save;
                        elsif(ADDR = (WZ6 +3)) then
                            o_we <= '1';
                            o_address <= "0000000000001001";
                            output <= "11101000";
                            current_state <= save;
                        else 
                            o_address <= "0000000000000111";
                            current_state <= get_WZ7;                            
                        end if;
                        
                    when get_WZ7 =>
                        WZ7 <= i_data;
                        current_state <= check_WZ7;                                                   
                    when check_WZ7 =>
                         o_we <= '1';
                         o_address <= "0000000000001001";
                        if (ADDR = WZ7)then  
                            output <= "11110001";
                            current_state <= save;                         
                        elsif(ADDR = (WZ7 + 1)) then
                            output <= "11110010";
                            current_state <= save;
                        elsif(ADDR = (WZ7 +2)) then
                            output <= "11110100";
                            current_state <= save;
                        elsif(ADDR = (WZ7 +3)) then
                            output <= "11111000";
                            current_state <= save;
                        else 
                            output <= ADDR;
                            current_state <= save;                            
                        end if;                       
                    when save =>
                        o_we <= '1';
                        o_data <= output;
                        current_state <= ending;
                     when ending =>
                        if i_start = '0' then
                            o_done <= '0';
                            current_state <= reset;
                        else
                            o_done <= '1';
                            o_we <= '0'; 
                            current_state <= ending;
                        end if;

                  end case;
            end if;
        end if;
    end process;
end Behavioral;
