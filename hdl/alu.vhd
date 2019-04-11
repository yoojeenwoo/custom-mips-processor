library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library cpu_lib;
use cpu_lib.cpu_package.all;

library utils;
use utils.functions_package.all;

entity alu is
port(
	clk			: in std_logic;
	rst			: in std_logic;
	op			: in std_logic_vector(NUM_ALU_CTRL_C-1 downto 0);
	operand_1	: in std_logic_vector(DATA_WIDTH_C-1 downto 0);
	operand_2	: in std_logic_vector(DATA_WIDTH_C-1 downto 0);
	zero		: out std_logic;
	result		: out std_logic_vector(DATA_WIDTH_C-1 downto 0);
);
end entity;

architecture Behavioral of alu is
begin

process(all)
begin
	case op is
		when "0000" => -- AND
			result <= operand_1 and operand_2;
		when "0001" => -- OR
			result <= operand_1 or operand_2;
		when "0010" => -- add
			result <= operand_1 + operand_2;
		when "0110" => -- subtract
			result <= operand_1 - operand_2;
		when "0111" => -- set on less than
			result <= (0 => '1', others => '0') when operand_1 < operand_2 else (others => '0');
		when "1100" => -- NOR
			result <= operand_1 nor operand_2;
		when others =>
			report "Unrecognized operation control input to ALU"
				severity failure;
	end case;
end process;

end architecture;