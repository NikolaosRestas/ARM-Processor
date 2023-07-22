----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.09.2021 10:48:39
-- Design Name: 
-- Module Name: InstrDec - Behavioral
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

entity InstrDec is
  Port (
  op: in std_logic_vector(1 downto 0);
  funct: in std_logic_vector(5 downto 0);
  sh: in std_logic_vector(1 downto 0); 
  RegSrc: out std_logic_vector(2 downto 0);
  ALUControl: out std_logic_vector(2 downto 0);
  ALUSrc: out std_logic;
  ImmSrc: out std_logic;
  MemtoReg: out std_logic;
  NoWriteIn: out std_logic);
end InstrDec;

architecture Behavioral of InstrDec is

begin
process(op, funct, sh)
begin

 if(op="00")then
    if(funct="101000" or funct="101001")then
        RegSrc <= "000";
        ALUSrc <= '1';
        ImmSrc <= '0';
        ALUControl <= "000";
        MemtoReg <= '0';
        NoWriteIn <= '0';             
    elsif(funct= "001000" or funct="001001")then
        RegSrc <= "000";
        ALUSrc <= '0';
        ImmSrc <= '0';
        ALUControl <= "000";
        MemtoReg <= '0';
        NoWriteIn<= '0';             
    elsif(funct="100100" or funct="100101")then
        RegSrc <= "000";
        ALUSrc <= '1';
        ImmSrc <= '0';
        ALUControl <= "001";
        MemtoReg <= '0';
        NoWriteIn <= '0';             
    elsif(funct="000100" or funct="000101")then
        RegSrc <= "000";
        ALUSrc <= '0';
        ImmSrc <= '0';
        ALUControl <= "001";
        MemtoReg <= '0';
        NoWriteIn <= '0';             
    elsif(funct="110101")then 
        RegSrc <= "000";
        ALUSrc <= '1';
        ImmSrc <= '0';
        ALUControl <= "001";
        MemtoReg <= '0';
        NoWriteIn <= '1';             
    elsif(funct= "010101")then 
        RegSrc <= "000";
        ALUSrc <= '0';
        ImmSrc <= '0';
        ALUControl <= "001";
        MemtoReg <= '0';
        NoWriteIn <= '1';             
    elsif(funct= "100000" or funct="100001")then
        RegSrc <= "000";
        ALUSrc <= '1';
        ImmSrc <= '0';
        ALUControl <= "010";
        MemtoReg <= '0';
        NoWriteIn <= '0';             
    elsif(funct="000000" or funct= "000001")then
        RegSrc <= "000";
        ALUSrc <= '0';
        ImmSrc <= '0';
        ALUControl <= "010";
        MemtoReg <= '0';
        NoWriteIn <= '0';             
    elsif(funct="100010" or funct="100011")then
        RegSrc <= "000";
        ALUSrc <= '1';
        ImmSrc <= '0';
        ALUControl <= "011";
        MemtoReg <= '0';
        NoWriteIn <= '0';             
    elsif(funct="000010" or funct="000011")then 
        RegSrc <= "000";
        ALUSrc <= '0';
        ImmSrc <= '0';
        ALUControl <= "011";
        MemtoReg <= '0';
        NoWriteIn <= '0';             
    elsif(funct="111010")then
        RegSrc <= "000";
        ALUSrc <= '1';
        ImmSrc <= '0';
        ALUControl <= "100";
        MemtoReg <= '0';
        NoWriteIn <= '0';             
    elsif(funct="011010")then 
        RegSrc <= "000";
        ALUSrc <= '0';
        ImmSrc <= '0';
        ALUControl <= "100";
        MemtoReg <= '0';
        NoWriteIn <= '0';             
    elsif(funct="111110")then
        RegSrc <= "000";
        ALUSrc <= '1';
        ImmSrc <= '0';
        ALUControl <= "101";
        MemtoReg <= '0';
        NoWriteIn <= '0';             
    elsif(funct="011110")then
        RegSrc <= "000";
        ALUSrc <= '0';
        ImmSrc <= '0';
        ALUControl <= "101";
        MemtoReg <= '0';
        NoWriteIn <= '0';             
    elsif(funct="011100")then
        if(sh="00")then
            RegSrc <= "000";
            ALUSrc <= '0';
            ImmSrc <= '0';
            ALUControl <= "110";
            MemtoReg <= '0';
            NoWriteIn <= '0';
        elsif(sh="10")then 
            RegSrc <= "000";
            ALUSrc <= '0';
            ImmSrc <= '0';
            ALUControl <= "111";
            MemtoReg <= '0';
            NoWriteIn <= '0';             
        else -- ERROR --
            RegSrc <= "000";
            ALUSrc <= '0';
            ImmSrc <= '0';
            ALUControl <= "000";
            MemtoReg <= '0';
            NoWriteIn <= '0';             
        end if;
    else -- ERROR --
        RegSrc <= "000";
        ALUSrc <= '0';
        ImmSrc <= '0';
        ALUControl <= "000";
        MemtoReg <= '0';
        NoWriteIn <= '1';             
    end if;   
 elsif(op="01")then
    if(funct="011001")then
        RegSrc <= "000";
        ALUSrc <= '1';
        ImmSrc <= '0';
        ALUControl <= "000";
        MemtoReg <= '1';
        NoWriteIn <= '0'; 
    elsif(funct= "010001")then
        RegSrc <= "000";
        ALUSrc <= '1';
        ImmSrc <= '0';
        ALUControl <= "001";
        MemtoReg <= '1';
        NoWriteIn <= '0';   
    elsif(funct="011000")then
        RegSrc <= "010";
        ALUSrc <= '1';
        ImmSrc <= '0';
        ALUControl <= "000";
        MemtoReg <= '0';
        NoWriteIn<= '0';   
    elsif(funct="010000")then
        RegSrc <= "010";
        ALUSrc <= '1';
        ImmSrc <= '0';
        ALUControl <= "001";
        MemtoReg <= '0';
        NoWriteIn <= '0';   
    else  --ERROR--
        RegSrc <= "000";
        ALUSrc <= '0';
        ImmSrc <= '0';
        ALUControl <= "000";
        MemtoReg <= '0';
        NoWriteIn <= '1';  
    end if;           
 elsif(op= "10")then
    if(funct(4)='0')then
       RegSrc <= "001";
       ALUSrc <= '1';
       ImmSrc <= '1';
       ALUControl <= "000";
       MemtoReg <= '0';
       NoWriteIn <= '1';  
    elsif(funct(4)= '1')then
        RegSrc <= "101";
        ALUSrc <= '1';
        ImmSrc <= '1';
        ALUControl <= "000";
        MemtoReg <= '0';
        NoWriteIn <= '0';
    else --ERROR--
        RegSrc <= "000";
        ALUSrc <= '0';
        ImmSrc <= '0';
        ALUControl <= "000";
        MemtoReg <= '0';
        NoWriteIn <= '1'; 
    end if;
 else -- ERROR--
    RegSrc <= "000";
    ALUSrc <= '0';
    ImmSrc <= '0';
    ALUControl <= "000";
    MemtoReg <= '0';
    NoWriteIn <= '1';
 end if;
end process;

end Behavioral;
