----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.09.2021 15:20:49
-- Design Name: 
-- Module Name: WELogic - Behavioral
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

entity WELogic is
  Port ( 
  op: in std_logic_vector(1 downto 0);
  SL: in std_logic;
  NoWriteIn: in std_logic;
  MemWriteIn: out std_logic;
  FlagsWriteIn: out std_logic;
  RegWriteIn: out std_logic);
end WELogic;

architecture Behavioral of WELogic is

begin
process(op, SL, NoWriteIn)
    begin
        if(op="00")then
            if(SL='0')then
                FlagsWriteIn<='0';
            elsif(SL='1')then
                FlagsWriteIn<='1';
            else  --ERROR--
                FlagsWriteIn<='0';
            end if;
            
            if(NoWriteIn='0')then
                RegWriteIn <= '1';
            elsif(NoWriteIn='1')then
                RegWriteIn <= '0';
            else --ERROR--
                RegWriteIn <= '0';
            end if;
            MemWriteIn <= '0';
    elsif(op="01")then
        if(SL='0')then
            RegWriteIn <= '0';
            FlagsWriteIn <= '0';
            MemWriteIn <= '1'; 
        elsif(SL= '1')then
            RegWriteIn <= '1';
            FlagsWriteIn <= '0';
            MemWriteIn <= '0';
        else -- ERROR --
            RegWriteIn <= '0';
            FlagsWriteIn <= '0';
            MemWriteIn <= '0';
        end if;
    elsif(op= "10")then
        if(NoWriteIn='0')then
            RegWriteIn <= '1';
        elsif(NoWriteIn='1')then
            RegWriteIn <= '0';
        else  --ERROR--
            RegWriteIn <= '0';
        end if;
        FlagsWriteIn <= '0';
        MemWriteIn <= '0';
    else  -- ERROR--
        RegWriteIn <= '0';
        FlagsWriteIn <= '0';
        MemWriteIn <= '0';
    end if;
end process;

end Behavioral;
