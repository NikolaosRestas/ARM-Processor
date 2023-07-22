-----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2021 15:58:09
-- Design Name: 
-- Module Name: Data_Memory - Behavioral
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

entity Data_Memory is
generic (
    N: positive :=5; -- address length
    M: positive:= 32); -- data word length
Port ( 
    CLK: in std_logic;
    WE: in std_logic;
    ADDR: in std_logic_vector(N-1 downto 0);
    WRITE_DATA: in std_logic_vector(M-1 downto 0);
    DATA_OUT: out std_logic_vector(M-1 downto 0));
end Data_Memory;

architecture Behavioral of Data_Memory is
type Data_Memory is array(2**N-1 downto 0)
    of std_logic_vector(M-1 downto 0);

signal RAM: Data_Memory;
begin
BLOCK_RAM: process(CLK)
    begin
       if(CLK='1' and CLK'event) then
            if (WE='1') then
               RAM(to_integer(unsigned(ADDR)))<= WRITE_DATA;
            end if;
       end if;
    end process;
    
    DATA_OUT<=RAM(to_integer(unsigned(ADDR)));  

end Behavioral;
