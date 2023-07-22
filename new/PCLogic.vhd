----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.09.2021 16:04:50
-- Design Name: 
-- Module Name: PCLogic - Behavioral
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

entity PCLogic is
  Port ( 
  Rd: in std_logic_vector(3 downto 0);
  op1: in std_logic;
  RegWriteIn: in std_logic;
  PCSrcIn: out std_logic
  );
end PCLogic;

architecture Behavioral of PCLogic is
begin
process(Rd, op1, RegWriteIn)
    begin
    if((Rd="1111") and (RegWriteIn='1')) then 
        PCSrcIn <= '1';
    elsif (op1='1') then 
        PCSrcIn <= '1';
    else
        PCSrcIn <= '0';
        end if;      
end process;


end Behavioral;
