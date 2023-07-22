----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.08.2021 09:42:47
-- Design Name: 
-- Module Name: Datapath - Behavioral
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

entity Datapath is
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
end Datapath;

architecture Behavioral of Datapath is

component PC_Counter is                      -- COMPONENT PC --
  generic (N: positive :=32);
  Port ( 
  CLK: in std_logic;
  RESET: in std_logic;
  WE: in std_logic;
  Din: in std_logic_vector(N-1 downto 0);
  Dout: out std_logic_vector(N-1 downto 0)
  );
end component PC_Counter;

component Instruction_Memory is               -- COMPONENT INSTRUCTION MEMORY --
generic (
    N: positive :=6;
    M: positive:= 32);
  Port ( 
    ADDR: in std_logic_vector(N-1 downto 0);
    DATA_OUT: out std_logic_vector(M-1 downto 0));
end component Instruction_Memory;

component INC4 is
--generic (WIDTH: positive :=4);                    -- COMPONENT PCPLUS 4 --
  generic (WIDTH: positive :=32);
  Port ( 
  X: in std_logic_vector(WIDTH-1 downto 0);
  Y: out std_logic_vector(WIDTH-1 downto 0)
  );
end component INC4;

component MUX_n is
  generic (WIDTH: positive :=4);                     -- COMPONENT MUX --
  --generic (WIDTH: positive :=32);
  Port (
    A0 , A1: in std_logic_vector(WIDTH-1 downto 0);
    S: in std_logic;
    Y: out std_logic_vector(WIDTH-1 downto 0)
  );
end component MUX_n;


component Register_File is
generic (
    N: positive :=4; -- address length            -- COMPONENT REGISTER FILE --
    M: positive:= 32); -- data word length
    
  Port ( 
  CLK: in std_logic;
  WE: in std_logic;
  ADDR_R1: in std_logic_vector(N-1 downto 0);
  ADDR_R2: in std_logic_vector(N-1 downto 0);
  ADDR_R3: in std_logic_vector(N-1 downto 0);
  R15: in std_logic_vector(M-1 downto 0);
  DATA_IN: in std_logic_vector(M-1 downto 0);
  DATA_OUT1: out std_logic_vector(M-1 downto 0);
  DATA_OUT2: out std_logic_vector(M-1 downto 0));
end component Register_File;

component ALU is                     -- COMPONENT ALU --
generic (WIDTH: positive :=32); 

Port ( 
SrcA: in std_logic_vector(WIDTH-1 downto 0);
SrcB: in std_logic_vector(WIDTH-1 downto 0);
ALUResult: out std_logic_vector(WIDTH-1 downto 0);
ALUControl: in std_logic_vector(2 downto 0);
shamt5: in std_logic_vector(4 downto 0);
NZCV: out std_logic_vector(3 downto 0));
end component ALU;

component Extend is  -- COMPONENT EXTEND --
generic (WIDTH_IN: positive:=24; --12
         WIDTH_OUT: positive:=32);
  Port (
  Sorz: in std_logic;
  SZ_in: in std_logic_vector(WIDTH_IN-1 downto 0);
  SZ_out: out std_logic_vector(WIDTH_OUT-1 downto 0));
  end component Extend;


component SR is
generic (N: positive :=4);                      -- COMPONENT SR -- 
  Port ( 
  CLK: in std_logic;
  WE: in std_logic;
  RESET:in std_logic;
  Din: in std_logic_vector(N-1 downto 0);
  Dout: out std_logic_vector(N-1 downto 0));
end component SR;


component Data_Memory is
generic (
    N: positive :=5; -- address length           -- COMPONENT DATA MEMORY -- 
    M: positive:= 32); -- data word length
Port ( 
    CLK: in std_logic;
    WE: in std_logic;
    ADDR: in std_logic_vector(N-1 downto 0);
    WRITE_DATA: in std_logic_vector(M-1 downto 0);
    DATA_OUT: out std_logic_vector(M-1 downto 0));
end component Data_Memory;

component MUX32 is
  generic (WIDTH: positive :=32);                -- COMPONENT MUX32 -- 
  Port (
    A0 , A1: in std_logic_vector(WIDTH-1 downto 0);
    S: in std_logic;
    Y: out std_logic_vector(WIDTH-1 downto 0));
end component MUX32;

component REG_32 is
generic (N: positive :=32);
  Port ( 
  CLK: in std_logic;
  RESET: in std_logic;
  WE: in std_logic;
  Din: in std_logic_vector(N-1 downto 0);
  Dout: out std_logic_vector(N-1 downto 0));
end component REG_32;

signal PC_next: std_logic_vector(31 downto 0); -- PC ENTRY --
signal A_in: std_logic_vector(31 downto 0); -- EXIT FROM PC COUNTER --
signal ALUControl_in: std_logic_vector(2 downto 0); -- ALUControl --
signal Data_out_memory: std_logic_vector(31 downto 0); -- exit from INSTRUCTION MEMORY--
signal PCPLUS4_out: std_logic_vector(31 downto 0); -- exit from PCPLUS 4 --
signal PCPLUS8_out: std_logic_vector(31 downto 0); -- exit from PCPLUS 8 --
signal Extend_out: std_logic_vector(31 downto 0); -- exit from Extend --
signal Mux1_exit: std_logic_vector(3 downto 0); -- exit from MUX_1 --
signal Mux2_exit: std_logic_vector(3 downto 0); -- exit from MUX_2 --
signal Mux3_exit: std_logic_vector(3 downto 0);  -- exit from MUX_3 --
signal RegF1_exit: std_logic_vector(31 downto 0); -- exit Register file 1 --
signal RegF2_exit: std_logic_vector(31 downto 0); -- exit Register file 2 --
signal Mux32_exit: std_logic_vector(31 downto 0); -- exit from MUX_32 --
signal ALU_exit: std_logic_vector(31 downto 0); -- exit from ALU --
signal NZCV_exit: std_logic_vector(3 downto 0);  -- exit flags from ALU --
signal Data_Memory_exit: std_logic_vector(31 downto 0); -- exit Data Memory --
signal Data_exit: std_logic_vector(31 downto 0); -- exit from System --
signal PCN_exit: std_logic_vector(31 downto 0); -- exit from last MUX --
signal PCN_out: std_logic_vector(31 downto 0);     -- PCN OUT --
signal MUX24_exit: std_logic_vector(31 downto 0); -- ENTRY FOR REGISTER FILE --



begin

--A_in<=A;
ALUControl_in<=ALUControl;


U1: PC_Counter
port map(
    CLK=>CLK,
    RESET=>RESET,
    WE=>PCWrite,
    Din=>PC_next,--A,
    Dout=>A_in
    );

U2: Instruction_Memory
port map(
    ADDR=>A_in(7 downto 2),
    DATA_OUT=>Data_out_memory);
    
U3: INC4
port map(
    X=> A_in,
    Y=> PCPLUS4_out
    );
    
U4: INC4
port map(
    X=> PCPLUS4_out,
    Y=> PCPLUS8_out
    );
    
U5: Extend 
port map(
    Sorz=>ImmSrc,
    SZ_in=>Data_out_memory(23 downto 0),
    SZ_out=>Extend_out
    
    );
    
U6: MUX_n
port map(
    A0=>Data_out_memory(19 downto 16),
    A1=>"1111",
    S=>RegSrc(0),
    Y=>Mux1_exit
    );
    
U7: MUX_n
port map(
    A0=>Data_out_memory(3 downto 0),
    A1=>Data_out_memory(15 downto 12),
    S=>RegSrc(1),
    Y=>Mux2_exit
    );
    
U8: MUX_n
port map(
    A0=>Data_out_memory(15 downto 12),
    A1=>"1110",
    S=>RegSrc(2),
    Y=>Mux3_exit
    );
    
    
U9: Register_File
port map(
    CLK=>CLK,
    WE=>RegWrite,
    ADDR_R1=>Mux1_exit,
    ADDR_R2=>Mux2_exit,
    ADDR_R3=>Mux3_exit,
    R15=>PCPLUS8_out,
    DATA_IN=>MUX24_exit,  --Data_exit,
    DATA_OUT1=>RegF1_exit,
    DATA_OUT2=>RegF2_exit
    );
    
U10: MUX32
port map(
    A0=>RegF2_exit,
    A1=>Extend_out,
    S=>ALUSrc,
    Y=>Mux32_exit
    );
    
U11: ALU
port map(
    
    SrcA=>RegF1_exit,
    SrcB=>Mux32_exit,
    ALUControl=>ALUControl_in,
    shamt5=>Data_out_Memory(11 downto 7),
    ALUResult=>ALU_exit,
    NZCV=>NZCV_exit
    );
    
    
U12: SR
port map(
    
    CLK=>CLK,
    WE=>FlagsWrite,
    RESET=>RESET,
    Din=>NZCV_exit,
    Dout=>NZCV
    );
    
    
U13: Data_Memory
port map(
    CLK=>CLK,
    WE=>MemtoWrite,
    ADDR=>ALU_exit(6 downto 2),
    WRITE_DATA=>RegF2_exit,
    DATA_OUT=>Data_Memory_exit
    );
    
U14: MUX32
port map(
    A0=>ALU_exit,
    A1=>Data_Memory_exit,
    S=>MemtoReg,
    Y=>Data_exit
    );
    
U15: REG_32
port map(
    CLK=>CLK,
    RESET=>RESET,
    WE=>'1',
    Din=>Data_exit,
    Dout=>Result
    );
    
U16: MUX32
port map(
    A0=>PCPLUS4_out,
    A1=>Data_exit,
    S=>PCSrc,
    Y=>PCN_out --A_in 
    );
    
U17: REG_32 -- PC OUT --
port map(
    CLK=>CLK,
    RESET=>RESET,
    WE=>'1',
    Din=>A_in,
    Dout=>PC
    );
    
U18: REG_32 -- INSTR OUT  --
port map(
    CLK=>CLK,
    RESET=>RESET,
    WE=>'1',
    Din=>Data_out_memory,
    Dout=>Instr
    );
    
U19: REG_32 -- ALURESULT EXIT --
port map(
    CLK=>CLK,
    RESET=>RESET,
    WE=>'1',
    Din=>ALU_exit,
    Dout=>ALUResult_exit
    );
    
U20: REG_32 -- WRITE DATA EXIT --
port map(
    CLK=>CLK,
    RESET=>RESET,
    WE=>'1',
    Din=>RegF2_exit,
    Dout=>WriteData
    );
    
U21: MUX32 -- ENTRY FOR REGISTER FILE DATA IN --
port map(
    A0=>PCPLUS4_out,
    A1=>Data_exit,
    S=>RegSrc(2),
    Y=>MUX24_exit
    );
    
U22: REG_32     -- LOOP FROM THE START --
port map(
    CLK=>CLK,
    RESET=>RESET,
    WE=>PCWrite,
    Din=>PCN_out,
    Dout=>PC_next 
    );
    

end Behavioral;
