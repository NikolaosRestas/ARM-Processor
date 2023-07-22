----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2021 09:09:17
-- Design Name: 
-- Module Name: INC4 - Behavioral
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

entity INC4 is
generic (WIDTH: positive :=32);
  Port ( 
  X: in std_logic_vector(WIDTH-1 downto 0);
  Y: out std_logic_vector(WIDTH-1 downto 0)
  );
end INC4;

architecture Behavioral of INC4 is

begin

Y<= std_logic_vector(to_unsigned(to_integer(unsigned(X))+4,WIDTH));

end Behavioral;
