----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.09.2021 17:35:35
-- Design Name: 
-- Module Name: CONDLogic - Behavioral
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

entity CONDLogic is
  Port ( 
  cond: in std_logic_vector(3 downto 0);
  flags: in std_logic_vector(3 downto 0);
  CondExIn: out std_logic
  );
end CONDLogic;

architecture Behavioral of CONDLogic is

begin
    process(cond, flags)
    begin
            if(cond="0000" )then 
                CondExIn <= flags(2);    
            elsif(cond="0001")then 
                CondExIn <= not flags(2);    
            elsif(cond="0010")then 
                CondExIn <= flags(1);    
            elsif(cond="0011")then 
                CondExIn <= not flags(1);    
            elsif(cond="0100")then 
                CondExIn <= flags(3);    
            elsif(cond="0101")then 
                CondExIn <= not flags(3);    
            elsif(cond="0110" )then 
                CondExIn <= flags(0);   
            elsif(cond="0111")then 
                CondExIn <= not flags(0);    
            elsif(cond="1000")then 
                CondExIn <= (not flags(2)) and flags(1);   
            elsif(cond="1001")then 
                CondExIn <= flags(2) or (not flags(1));     
            elsif(cond="1010")then 
                CondExIn <= not (flags(3) xor flags(0));    
            elsif(cond="1011")then  
                CondExIn <= flags(3) xor flags(0);    
            elsif(cond="1100")then  
                CondExIn <= (not flags(2)) and (not (flags(3) xor flags(0)));   
            elsif(cond="1101")then  
                CondExIn <= flags(2) or (flags(3) xor flags(0));    
            elsif(cond="1110")then 
                CondExIn <= '1';    
            elsif(cond ="1111")then  
                CondExIn <= '1';    
            else  
                CondExIn <= '0'; 
        end if;

    end process;


end Behavioral;
