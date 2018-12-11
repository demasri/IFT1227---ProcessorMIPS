library IEEE; use IEEE.STD_LOGIC_1164.all;

entity proc_mips is -- single cycle MIPS processor
	port (clk, reset: in STD_LOGIC;
			pc: out STD_LOGIC_VECTOR (31 downto 0);
			instr: in STD_LOGIC_VECTOR (31 downto 0);
			memwrite: out STD_LOGIC;
			aluout, writedata: out STD_LOGIC_VECTOR (31 downto 0);
			readdata: in STD_LOGIC_VECTOR (31 downto 0));
end;

architecture struct of proc_mips is
	component controller
		port (op, funct: in STD_LOGIC_VECTOR (5 downto 0);
				zero: in STD_LOGIC;
				memtoreg, memwrite: out STD_LOGIC;
				pcsrc: out STD_LOGIC;
				regdst, regwrite: out STD_LOGIC;
				jump: out STD_LOGIC_VECTOR (1 downto 0);
				alucontrol: out STD_LOGIC_VECTOR (5 downto 0);
				alusrc: out STD_LOGIC_VECTOR (1 downto 0));
	end component;
	component datapath
		port (clk, reset: in STD_LOGIC;
				memtoreg, pcsrc: in STD_LOGIC;
				regdst: in STD_LOGIC;
				regwrite: in STD_LOGIC;
				alucontrol: in STD_LOGIC_VECTOR (5 downto 0);
				zero: out STD_LOGIC;
				pc: buffer STD_LOGIC_VECTOR (31 downto 0);
				instr: in STD_LOGIC_VECTOR (31 downto 0);
				aluout, writedata: buffer STD_LOGIC_VECTOR (31 downto 0);
				readdata: in STD_LOGIC_VECTOR (31 downto 0);
				jump, alusrc: in STD_LOGIC_VECTOR (1 downto 0));
	end component;
	signal memtoreg, regdst, regwrite, pcsrc: STD_LOGIC;
	signal zero: STD_LOGIC;
	signal jump, alusrc: STD_LOGIC_VECTOR (1 downto 0);
	signal alucontrol: STD_LOGIC_VECTOR (5 downto 0);
begin
	cont: controller port map (instr (31 downto 26), instr(5 downto 0), zero, memtoreg, memwrite, pcsrc, regdst, regwrite, jump, alucontrol, alusrc);
	dp: datapath port map (	clk, reset, memtoreg, pcsrc, regdst, regwrite, alucontrol, zero, pc, instr, aluout, writedata, readdata, jump, alusrc);
end;