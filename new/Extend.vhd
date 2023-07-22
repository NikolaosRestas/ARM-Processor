----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.08.2021 15:32:36
-- Design Name: 
-- Module Name: Extend - Behavioral
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

entity Extend is
generic (WIDTH_IN: positive:=24; 
         WIDTH_OUT: positive:=32);
  Port (
  Sorz: in std_logic; 
  SZ_in: in std_logic_vector(WIDTH_IN-1 downto 0); 
  SZ_out: out std_logic_vector(WIDTH_OUT-1 downto 0)); 
end Extend;

architecture Behavioral of Extend is


begin
-------------------------------------------------------------------------
test: process (Sorz , SZ_in) is
--variable SZ_in_u: unsigned(WIDTH_IN-1 downto 0);
--variable SZ_in_s: signed(WIDTH_IN-1 downto 0);
--variable SZ_out_u: unsigned (WIDTH_OUT-1 downto 0);
--variable SZ_out_s: signed(WIDTH_OUT-1 downto 0);

variable Instr_unsigned:unsigned (11 downto 0);
variable Instr_signed: signed (23 downto 0);
variable ExtImm_unsigned: unsigned (31 downto 0);
variable ExtImm_signed: signed (31 downto 0);

------------------------ 1os tropos ---------------------------------

--begin 
--  SZ_in_u:=unsigned(SZ_in);
--  SZ_in_s:=signed(SZ_in); 
--  if(Sorz='0')then
--         SZ_out(31 downto 12) <= (others=>'0'); 
--         SZ_out(11 downto 0) <= SZ_in(11 downto 0);
--  elsif(Sorz='1')then
--        SZ_out_s:=resize(shift_left(SZ_in_s,2),WIDTH_OUT);
--        SZ_out<=std_logic_vector(SZ_out_s);
--  else
--        SZ_out<=(others=>'0'); -- ALTERNATIVE SENARIO --
--  end if;
  
--end process;

---------------------- 2os tropos ----------------------------------

begin
    Instr_unsigned := unsigned (SZ_in(11 downto 0)); 
    Instr_signed := signed (SZ_in); 
    
    if (Sorz = '0') then
        ExtImm_unsigned := resize(Instr_unsigned, 32);
        SZ_out <= std_logic_vector(ExtImm_unsigned);
    else 
        ExtImm_signed := resize(Instr_signed & "00", 32);
        SZ_out <= std_logic_vector(ExtImm_signed);
    end if;       

    end process test;

end Behavioral;
