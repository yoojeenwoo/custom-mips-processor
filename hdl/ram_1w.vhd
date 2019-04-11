library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library cpu_lib;
use cpu_lib.cpu_package.all;

library utils;
use utils.functions_package.all;

entity ram_1w is
generic(
	ADDR_WIDTH_C	: positive := DATA_WIDTH_C;
	MEM_WIDTH_C 	: positive := DATA_WIDTH_C
)
port(
	clk			: in std_logic;
	rst			: in std_logic;
	we			: in std_logic;
	addr		: in std_logic_vector(ADDR_WIDTH_C-1 downto 0);
	wr_data		: in std_logic_vector(MEM_WIDTH_C-1 downto 0);
	rd_data		: out std_logic_vector(MEM_WIDTH_C-1 downto 0)
);
end entity;

architecture Behavioral of ram_1w is

	type ram_type is array(0 to 2**ADDR_WIDTH_C-1) of std_logic_vector(MEM_WIDTH_C-1 downto 0);
	signal ram		: ram_type;
	signal rd_addr	: std_logic_vector(ADDR_WIDTH_C-1 downto 0);

begin

process(clk) is
begin
	if rising_edge(clk) then
		if (rst) then
			ram <= (others => (others => '0'));
			rd_addr <= (others => '0');
		else
			if (we) then
				ram(to_integer(unsigned(addr))) <= wr_data;
			end if;
			rd_addr <= addr;
		end if;
	end if;
end process;

rd_data <= ram(to_integer(unsigned(rd_addr)));

end architecture;