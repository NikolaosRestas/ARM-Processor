----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.08.2021 16:51:54
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
generic (WIDTH: positive :=32);

Port ( 
SrcA: in std_logic_vector(WIDTH-1 downto 0);
SrcB: in std_logic_vector(WIDTH-1 downto 0);
ALUResult: out std_logic_vector(WIDTH-1 downto 0);
ALUControl: in std_logic_vector(2 downto 0);
shamt5: in std_logic_vector(4 downto 0);
NZCV: out std_logic_vector(3 downto 0));
end ALU;

architecture Behavioral of ALU is

begin
    process(SrcA, SrcB, ALUControl, shamt5)
    variable SrcA_signal, SrcB_signal, SrcB_ss, Result_signal: signed(33 downto 0);
    variable Result_ss: signed (31 downto 0);
    begin

    Srca_signal := signed('0' & Srca(31) & SrcA);
    Srcb_signal := signed('0' & Srcb(31) & SrcB);
    SrcB_ss := signed(not SrcB_signal)+1;
    NZCV(0) <= '0';
    NZCV(1) <= '0';
    NZCV(2) <= '0';
    NZCV(3) <= '0';
 
    if (AluControl="000")then 
        Result_signal := SrcA_signal + SrcB_signal; -- ADD --    
        ALUResult <= std_logic_vector(result_signal(31 downto 0));
        NZCV(0) <= (Result_signal(31) xor Result_signal(31));
        NZCV(1) <= result_signal(33);
        if(result_signal(31 downto 0) = "00000000000000000000000000000000") then
            NZCV(2) <= '1';
        else
            NZCV(2) <= '0';
        end if;
        NZCV(3) <= result_signal(31);
    elsif(AluControl="001")then
        Result_signal := SrcA_signal - SrcB_ss; -- DIFF
        ALUResult <= std_logic_vector(Result_signal(31 downto 0));
        NZCV(0) <= Result_signal(32) xor Result_signal(31);
        NZCV(1) <= Result_signal(33);
        if (Result_signal(31 downto 0) = "00000000000000000000000000000000") then
            NZCV(2) <= '1' ;
        else
            NZCV(2) <= '0' ;
        end if;
        NZCV(3) <= Result_signal(31);
    elsif(AluControl="010")then
        Result_signal := SrcA_signal and SrcB_signal; -- AND
        ALUResult <= std_logic_vector(Result_signal(31 downto 0));
        NZCV(0) <= '0';
        NZCV(1) <= Result_signal(33);
        if(Result_signal(31 downto 0) = "00000000000000000000000000000000") then
            NZCV(2) <= '1' ;
        else
            NZCV(2) <= '0' ;
        end if;
        NZCV(3) <= '0';
    elsif(AluControl="011")then
        Result_signal := SrcA_signal xor SrcB_signal; -- XOR
        ALUResult <= std_logic_vector(Result_signal(31 downto 0));
        NZCV(0) <= '0';
        NZCV(1) <= Result_signal(33);
        if(Result_signal(31 downto 0) = "00000000000000000000000000000000") then
            NZCV(2) <= '1' ;
        else
            NZCV(2) <= '0' ;
        end if;
        NZCV(3) <= '0';
    elsif(AluControl="100")then
        Result_signal := signed("00" & SrcB); -- MOV
        ALUResult <= std_logic_vector(Result_signal(31 downto 0));
    elsif(AluControl="101")then
        Result_signal := signed("00" & not SrcB); -- MVN
        ALUResult <= std_logic_vector(Result_signal(31 downto 0));
    elsif(AluControl="110")then
        Result_ss :=(signed(SrcB) sll to_integer(unsigned(shamt5))); --SLL
        ALUResult <= std_logic_vector(result_ss);
    elsif(AluControl="111")then
        result_ss := shift_right(signed(Srcb),to_integer(unsigned(shamt5)));  --ASR
        ALUResult <= std_logic_vector(result_ss);
    else 
        Result_signal := SrcA_signal + SrcB_signal; -- ADD
        ALUResult <= std_logic_vector(Result_signal(31 downto 0));
        NZCV(0) <= Result_signal(32) xor Result_signal(31);
        NZCV(1) <= Result_signal(33);
        if (Result_signal(31 downto 0) = "00000000000000000000000000000000") then
            NZCV(2) <= '1';
        else
            NZCV(2) <= '0';
        end if;
        NZCV(3) <= Result_signal(32);
    end if;
end process;

end behavioral;



