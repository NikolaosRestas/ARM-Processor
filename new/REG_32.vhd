----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.08.2021 11:00:06
-- Design Name: 
-- Module Name: REG_32 - Behavioral
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

entity REG_32 is
generic (N: positive :=32);
  Port ( 
  CLK: in std_logic;
  RESET: in std_logic;
  WE: in std_logic;
  Din: in std_logic_vector(N-1 downto 0);
  Dout: out std_logic_vector(N-1 downto 0));
end REG_32;

architecture Behavioral of REG_32 is
begin
     process(CLK, RESET) begin
         if (RESET = '1') then 
            Dout <= (others => '0');
         elsif (rising_edge(CLK)) then
            if (WE = '1') then
                Dout <= Din;
            end if;
        end if;
    end process;
end behavioral;
