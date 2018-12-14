library IEEE;
use IEEE.STD_LOGIC_1164.all; use IEEE.STD_LOGIC_UNSIGNED.all;

entity testbench is
end;

architecture test of testbench is
	component mips
		port(	clk, reset: in STD_LOGIC;
				writedata, dataadr: out STD_LOGIC_VECTOR(31 downto 0);
				memwrite: out STD_LOGIC);
	end component;
	signal writedata, dataadr: STD_LOGIC_VECTOR(31 downto 0);
	signal clk, reset, memwrite: STD_LOGIC;
begin
-- instantiate device to be tested
	dut: mips port map (clk, reset, writedata, dataadr, memwrite);
-- Generate clock with 10 ns period
process begin
	clk <= '1';
	wait for 5 ns;
	clk <= '0';
	wait for 5 ns;
end process;

-- Generate reset for first two clock cycles
process begin
	reset <= '1';
	wait for 22 ns;
	reset <= '0';
	wait;
end process;

-- check that 7 gets written to address 84
-- at end of program
process (clk) begin
	if (clk'event and clk = '0' and memwrite = '1') then
	  case conv_integer(dataadr) is
	    when 80 => if(conv_integer(writedata) = 7) then
			             report "test 1 r�ussi";
	               else
	                  report "test 1 echou�";
	               end if;
	    when 60 => if(conv_integer(writedata) = 7) then
			             report "test 2 r�ussi";
	               else
	                  report "test 2 echou�";
	               end if;
	    when 56 => if(conv_integer(writedata) = 7) then
			             report "test 3 r�ussi";
	               else
	                  report "test 3 echou�";
	               end if;  
		  when 64 => if(writedata = X"00007FFF") then
			             report "test 4 r�ussi";
	               else
	                  report "test 4 echou�";
	               end if;
		  when 68 => if(conv_integer(writedata) = 127) then
			             report "test 5 r�ussi";
	               else
	                  report "test 5 echou�";
	               end if;
		  when 72 => if(conv_integer(writedata) = 24) then
			             report "test 6 r�ussi";
	               else
	                  report "test 6 echou�";
	               end if;
		  when 76 => if(conv_integer(writedata) = 0) then
			             report "test 6 r�ussi";
	               else
	                  report "test 6 echou�";
	               end if;
		when 84 => if(conv_integer(writedata) = 1) then
			             report "test 7 r�ussi";
	               else
	                  report "test 7 echou�";
	               end if;
	    when others => report "";
	  end case;       
	end if;
end process;
end;