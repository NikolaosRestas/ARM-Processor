----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.08.2021 11:35:00
-- Design Name: 
-- Module Name: MUX32 - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX32 is
  generic (WIDTH: positive :=32);
  Port (
    A0 , A1: in std_logic_vector(WIDTH-1 downto 0);
    S: in std_logic;
    Y: out std_logic_vector(WIDTH-1 downto 0));
end MUX32;

architecture Behavioral of MUX32 is

begin
process(A0,A1,S)
    begin
        if(S='0') then
            Y<=A0;
        else
            Y<=A1;
        end if;
end process;

end Behavioral;
