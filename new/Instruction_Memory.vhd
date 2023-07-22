----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2021 10:08:31
-- Design Name: 
-- Module Name: Instruction_Memory - Behavioral
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

entity Instruction_Memory is
generic (
    N: positive :=6;
    M: positive:= 32);
  Port ( 
    ADDR: in std_logic_vector(N-1 downto 0);
    DATA_OUT: out std_logic_vector(M-1 downto 0));
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is
type Instruction_Memory is array (2**N-1 downto 0)
    of std_logic_vector(M-1 downto 0);
    
--constant ROM: Instruction_Memory := (
--    X"E3A00000", X"E3E01000", X"E0812000", X"E24230FF",
--    X"00000000", X"E3A00000", X"EAFFFFF9", X"E3E01000",
--    X"11111111", X"00000000", X"00000000", X"11111111",
--    X"00000000", X"00000000", X"E0812000", X"00000000",
--    X"00000000", X"E3A00000", X"EAFFFFF9", X"11111111",
--    X"E3A00000", X"00000000", X"E0812000", X"00000000",
--    X"00000000", X"00000000", X"00000000", X"00000000",
--    X"00000000", X"11111111", X"00000000", X"11111111",
--    X"00000000", X"00000000", X"00000000", X"00000000",
--    X"00000000", X"00000000", X"00000000", X"00000000",
--    X"E3A00000", X"00000000", X"E3A00000", X"00000000",
--    X"11111111", X"00000000", X"00000000", X"11111111",
--    X"00000000", X"00000000", X"00000000", X"00000000",
--    X"00000000", X"E3A00000", X"00000000", X"00000000",
--    X"E3A00000", X"E3E01000", X"E0812000", X"E24230FF",
--    X"E1A00000", X"EAFFFFF9", X"00000000", X"11111111"
--    );


constant ROM : Instruction_Memory := (
X"00000000", X"00000000", X"00000000", X"00000000", 
X"00000000", X"00000000", X"00000000", X"00000000", 
X"00000000", X"00000000", X"00000000", X"00000000",
X"00000000", X"00000000", X"00000000", X"00000000", 
X"00000000", X"00000000", X"00000000", X"00000000", 
X"00000000", X"00000000", X"00000000", X"00000000", 
X"00000000", X"00000000", X"00000000", X"00000000",
X"00000000", X"00000000", X"00000000", X"00000000", 
X"00000000", X"00000000", X"00000000", X"00000000", 
X"00000000", X"00000000", X"00000000", X"00000000", 
X"00000000", X"00000000", X"00000000", X"00000000",
X"00000000", X"00000000", X"00000000", X"00000000",
X"00000000", X"00000000", X"EAFFFFF1", X"EBFFFFFF",
X"E1A00000", X"E5908004", X"E5807004", X"E1A071C5",  
X"E1C06105", X"E1550004", X"E0245003", X"E0034002",
X"E24230FF", X"E0812000", X"E3E01000", X"E3A00000");

begin
DATA_OUT<=ROM(to_integer(unsigned(ADDR)));


end Behavioral;
