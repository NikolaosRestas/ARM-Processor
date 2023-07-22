-----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2021 10:29:52
-- Design Name: 
-- Module Name: Register_File - Behavioral
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

entity Register_File is
generic (
    N: positive :=4; -- address length
    M: positive:= 32); -- data word length
    
  Port ( 
  CLK: in std_logic;
  WE: in std_logic;
  ADDR_R1: in std_logic_vector(N-1 downto 0);
  ADDR_R2: in std_logic_vector(N-1 downto 0);
  ADDR_R3: in std_logic_vector(N-1 downto 0);
  R15: in std_logic_vector(M-1 downto 0);
  DATA_IN: in std_logic_vector(M-1 downto 0);
  DATA_OUT1: out std_logic_vector(M-1 downto 0);
  DATA_OUT2: out std_logic_vector(M-1 downto 0)
  );
end Register_File;

architecture Behavioral of Register_File is
type RF_array is array (2**N-1 downto 0)
    of std_logic_vector(M-1 downto 0);

signal RF: RF_array;

begin
    REG_FILE: process(CLK)

begin
    if(CLK='1' and CLK'event) then
        if (WE='1') then 
            RF(to_integer(unsigned(ADDR_R3)))<= DATA_IN; 
        end if;
    end if;
end process;

process(ADDR_R1,ADDR_R2,R15) begin 
        if (to_integer(unsigned(ADDR_R1)) = 15) then DATA_OUT1 <= R15;
            else DATA_OUT1 <= RF(to_integer(unsigned(ADDR_R1)));
        end if;
        if (to_integer(unsigned(ADDR_R2)) = 15) then DATA_OUT2 <= R15;
            else DATA_OUT2 <= RF(to_integer(unsigned(ADDR_R2)));
        end if;
    end process;

end Behavioral;
