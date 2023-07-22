----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.09.2021 16:08:22
-- Design Name: 
-- Module Name: Processor - Behavioral
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

entity Processor is
  generic (WIDTH: positive :=32);
  Port (
  CLK: in std_logic;
  RESET: in std_logic; 
  PC: out std_logic_vector(WIDTH-1 downto 0);
  Instr: out std_logic_vector(WIDTH-1 downto 0);
  ALUResult: out std_logic_vector(WIDTH-1 downto 0);
  WriteData: out std_logic_vector(WIDTH-1 downto 0);
  Result: out std_logic_vector(WIDTH-1 downto 0)
  );
end Processor;

architecture Behavioral of Processor is

component Control is
  Port ( 
           Instr : in std_logic_vector(31 downto 0);
           Flags : in std_logic_vector (3 downto 0);
           PCSrc : out std_logic;
           MemtoReg : out std_logic;
           MemWrite : out std_logic;
           ALUControl : out std_logic_vector (2 downto 0);
           ALUSrc : out std_logic;
           ImmSrc : out std_logic;
           RegWrite : out std_logic;
           FlagsWrite : out std_logic;
           RegSrc : out std_logic_vector (2 downto 0));
end component Control;

component Datapath is
  generic (WIDTH: positive :=32);
  
  Port ( 
  CLK: in std_logic;
  RESET: in std_logic;
  PCWrite: in std_logic;
  RegSrc: in std_logic_vector(2 downto 0);
  RegWrite: in std_logic;
  ImmSrc: in std_logic;
  ALUSrc: in std_logic;
  FlagsWrite: in std_logic;
  MemtoWrite: in std_logic;
  MemtoReg: in std_logic;
  PCSrc: in std_logic;
  ALUControl: in std_logic_vector(2 downto 0);
  NZCV: out std_logic_vector(3 downto 0);
  PC: out std_logic_vector(WIDTH-1 downto 0);
  Instr: out std_logic_vector(WIDTH-1 downto 0);
  ALUResult_exit: out std_logic_vector(WIDTH-1 downto 0);
  WriteData: out std_logic_vector(WIDTH-1 downto 0);
  Result: out std_logic_vector(WIDTH-1 downto 0));
end component Datapath;


signal Flags :  std_logic_vector (3 downto 0);
signal Instruction : std_logic_vector(31 downto 0);
signal PCSrc :  std_logic;
signal MemtoReg :  std_logic;
signal MemWrite :  std_logic;
signal ALUControl :  std_logic_vector (2 downto 0);
signal ALUSrc :  std_logic;
signal ImmSrc :  std_logic;
signal RegWrite : std_logic;
signal FlagsWrite :  std_logic;
signal RegSrc :  std_logic_vector (2 downto 0);

begin

U1: Control
port map(
    
     Instr=>Instruction, 
     Flags=>Flags,
     PCSrc=>PCSrc, 
     MemtoReg=>MemtoReg, 
     MemWrite=>MemWrite, 
     ALUControl=>ALUControl, 
     ALUSrc=>ALUSrc, 
     ImmSrc=>ImmSrc, 
     RegWrite=>RegWrite, 
     FlagsWrite=>FlagsWrite, 
     RegSrc=>RegSrc 
    );
    
U2: Datapath
port map(
    CLK=>CLK,
    RESET=>RESET,
    PCWrite=>'1',
    RegSrc=>RegSrc,
    RegWrite=>RegWrite,
    ImmSrc=>ImmSrc,
    ALUSrc=>ALUSrc,
    FlagsWrite=>FlagsWrite,
    MemtoWrite=>MemWrite,
    MemtoReg=>MemtoReg,
    PCSrc=>PCSrc,
    ALUControl=>ALUControl,
    NZCV=>Flags,
    PC=>PC,
    Instr=>Instruction,
    ALUResult_exit=>ALUResult,
    WriteData=>WriteData,
    Result=>Result
    );
    
    Instr<=Instruction;

end Behavioral;
