library IEEE; use IEEE.STD_LOGIC_1164.all;

entity maindec is -- main control decoder
	port (op: in STD_LOGIC_VECTOR (5 downto 0);
			memtoreg, memwrite: out STD_LOGIC;
			branch: out STD_LOGIC;
			regdst, regwrite: out STD_LOGIC;
			jump: out STD_LOGIC_VECTOR (1 downto 0);
			aluop, alusrc: out STD_LOGIC_VECTOR (1 downto 0));
end;

architecture behave of maindec is
	signal controls: STD_LOGIC_VECTOR(10 downto 0);
begin
process(op) begin
	case op is
		when "000000" => controls <= "11000001000"; -- Rtyp
		when "100011" => controls <= "10001001000"; -- LW
		when "101011" => controls <= "00001010000"; -- SW
		when "000100" => controls <= "00000100001"; -- BEQ
		when "001000" => controls <= "10001000000"; -- ADDI
		when "000010" => controls <= "00010000100"; -- J
      when "001100" => controls <= "10000000010"; -- andi
		when others   => controls <= "-----------"; -- illegal op
	end case;
end process;

	regwrite <= controls(10);
	regdst <= controls(9);
	alusrc <= controls(8 downto 7);
	branch <= controls(6);
	memwrite <= controls(5);
	memtoreg <= controls(4);
	jump <= controls(3 downto 2);
	aluop <= controls(1 downto 0);
end;
