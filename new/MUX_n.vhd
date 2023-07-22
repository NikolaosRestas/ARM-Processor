----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2021 09:32:15
-- Design Name: 
-- Module Name: MUX_n - Behavioral
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

entity MUX_n is
generic (WIDTH: positive :=4);
  --generic (WIDTH: positive :=32);
  Port (
    A0 , A1: in std_logic_vector(WIDTH-1 downto 0);
    S: in std_logic;
    Y: out std_logic_vector(WIDTH-1 downto 0)
  );
end MUX_n;

architecture Behavioral of MUX_n is

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
