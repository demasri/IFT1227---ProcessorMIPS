library IEEE;
use IEEE.STD_LOGIC_1164.all; use IEEE.STD_LOGIC_UNSIGNED.all;

entity testbench is
end;

architecture test of testbench is
	component alu
	port (a, b: in STD_LOGIC_VECTOR(31 downto 0);
			f: in STD_LOGIC_VECTOR (5 downto 0);
			shamt: in STD_LOGIC_VECTOR(4 downto 0);
			z, o : out STD_LOGIC;
			y: out STD_LOGIC_VECTOR(31 downto 0));
	end component;
	signal writedata, dataadr: STD_LOGIC_VECTOR(31 downto 0);
	signal clk, reset, memwrite: STD_LOGIC;
begin
-- instantiate device to be tested
	dut: alu port map (a, b, f, shamt, z, o, y);
-- Generate clock with 10 ns period
--process begin
--	clk <= '1';
--	wait for 5 ns;
--	clk <= '0';
--	wait for 5 ns;
--end process;

---- Generate reset for first two clock cycles
--process begin
--	reset <= '1';
--	wait for 22 ns;
--	reset <= '0';
--	wait;
--end process;

---- check that 7 gets written to address 84
---- at end of program
--process (clk) begin
--	if (clk'event and clk = '0' and memwrite = '1') then
--		if (conv_integer(dataadr) = 84 and conv_integer(writedata) = 7) then
--			report "Simulation succeeded";
--		elsif (dataadr /= 80) then
--			report "Simulation failed";
--		end if;
--	end if;
--end process;
--end;

process begin
	shamt <= "00001";
	b <= X"00000001";
	wait for 5 ns;
	assert s <= X"00000010"