----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2021 16:27:58
-- Design Name: 
-- Module Name: Control - Behavioral
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

entity Control is
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
end Control;

architecture Behavioral of Control is

component InstrDec is
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
end component InstrDec;

component WELogic is
  Port ( 
  op: in std_logic_vector(1 downto 0);
  SL: in std_logic;
  NoWriteIn: in std_logic;
  MemWriteIn: out std_logic;
  FlagsWriteIn: out std_logic;
  RegWriteIn: out std_logic);
end component WELogic;


component PCLogic is
  Port ( 
  Rd: in std_logic_vector(3 downto 0);
  op1: in std_logic;
  RegWriteIn: in std_logic;
  PCSrcIn: out std_logic
  );
end component PCLogic;

component CONDLogic is
  Port ( 
  cond: in std_logic_vector(3 downto 0);
  flags: in std_logic_vector(3 downto 0);
  CondExIn: out std_logic
  );
end component CONDLogic;

signal RegWriteIn :  std_logic;
signal PCSrcIn :  std_logic;
signal NoWriteIn :  std_logic;
signal FlagsWriteIn :  std_logic;
signal MemWriteIn :  std_logic;
signal CondExIn : std_logic;


begin
U1: InstrDec
port map(
  op=>instr(27 downto 26),
  funct=>instr(25 downto 20),
  sh=>instr(6 downto 5), 
  RegSrc=>RegSrc,
  ALUControl=>ALUControl,
  ALUSrc=>ALUSrc,
  ImmSrc=>ImmSrc,
  MemtoReg=>MemtoReg,
  NoWriteIn=>NoWriteIn
  );
  
U2: WELogic
port map(
  op=>instr(27 downto 26),
  SL=>instr(20),
  NoWriteIn=>NoWriteIn,
  MemWriteIn=>MemWriteIn,
  FlagsWriteIn=>FlagsWriteIn,
  RegWriteIn=>RegWriteIn
  );
  
U3: PCLogic
port map(
  Rd=>instr(15 downto 12),
  op1=>instr(27),
  RegWriteIn=>RegWriteIn,
  PCSrcIn=>PCSrcIn
  );
  
U4:CONDLogic 
port map(
  cond=>instr(31 downto 28),
  flags=>Flags,
  CondExIn=>CondExIn
  );
 
MemWrite <= MemWriteIn and CondExIn;
FlagsWrite <= FlagsWriteIn and CondExIn; 
RegWrite <= RegWriteIn and CondExIn;
PCSrc <= PCSrcIn and CondExIn;



end Behavioral;
