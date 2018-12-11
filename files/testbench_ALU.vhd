library IEEE;
use IEEE.STD_LOGIC_1164.all; use IEEE.STD_LOGIC_UNSIGNED.all;

entity testbench_ALU is
end;

architecture test of testbench_ALU is
	component alu
	port (a, b: in STD_LOGIC_VECTOR(31 downto 0);
			f: in STD_LOGIC_VECTOR (5 downto 0);
			shamt: in STD_LOGIC_VECTOR(4 downto 0);
			z, o : out STD_LOGIC;
			y: out STD_LOGIC_VECTOR(31 downto 0));
	end component;
signal a, b: STD_LOGIC_VECTOR(31 downto 0);
signal f: STD_LOGIC_VECTOR (5 downto 0);
signal shamt: STD_LOGIC_VECTOR(4 downto 0);
signal z, o : STD_LOGIC;
signal y: STD_LOGIC_VECTOR(31 downto 0);

begin
	dut: alu port map (a, b, f, shamt, z, o, y);
process begin
	a <= X"80000000";
	shamt <= "00001";
	
	-- sll
	b <= X"00000001";
	f <= "000000"; 
	wait for 10 ns;
	assert y = X"00000010";
	report "sll failed";
	
	wait for 20 ns;
	b <= X"7fffffff";
		
	-- A + B
	f <= "100000"; 
	wait for 10 ns;
	assert y = X"ffffffff";
	report "add failed";
	wait for 20 ns;
	
	-- A - B
	f <= "100010"; 
	wait for 10 ns;
	assert y = X"00000001";
	report "sub failed";
	wait for 20 ns;
	
	-- A and B
	f <= "100100"; 
	wait for 10 ns;
	assert y = X"00000000";
	report "and failed";
	wait for 20 ns;
	
	-- A or B
	f <= "100101"; 
	wait for 10 ns;
	assert y = X"ffffffff";
	report "or failed";
	wait for 20 ns;
	
	-- A xor B
	f <= "100110"; 
	wait for 10 ns;
	assert y = X"ffffffff";
	report "xor failed";
	wait for 20 ns;
	
	-- A nor B
	f <= "100111"; 
	wait for 10 ns;
	assert y = X"00000000";
	report "nor failed";
	wait for 20 ns;
	
	-- A SLTU B
	f <= "101011"; 
	wait for 10 ns;
	assert y = X"00000000";
	report "sltu failed";
	wait for 20 ns;
	
	-- A SLT B
	f <= "101010"; 
	wait for 10 ns;
	assert y = X"00000000";
	report "slt failed";
	wait for 10 ns;
	
end process;
end;