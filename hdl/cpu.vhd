-- Top-level

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library cpu_lib;
use cpu_lib.cpu_package.all;

library utils;
use utils.functions_package.all;

entity cpu is
port(
	clk			: in std_logic;
	rst			: in std_logic;
);
end entity;

architecture Structural of cpu is

	signal pc						: integer := 0;
	
	signal c_instr_rd_addr			: std_logic_vector(DATA_WIDTH_C-1 downto 0);
	signal c_instr					: std_logic_vector(DATA_WIDTH_C-1 downto 0);
	
	signal c_rd_reg_1, c_rd_reg_2	: std_logic_vector(clog2(NUM_REGISTERS_C)-1 downto 0);
	signal c_wr_reg					: std_logic_vector(clog2(NUM_REGISTERS_C)-1 downto 0);
	signal c_reg_in					: std_logic_vector(DATA_WIDTH_C-1 downto 0);
	signal c_reg_out_1, c_reg_out_2	: std_logic_vector(DATA_WIDTH_C-1 downto 0);
	
	signal c_op						: std_logic_vector(NUM_ALU_CTRL_C-1 downto 0);
	signal c_operand_1, c_operand_2	: std_logic_vector(DATA_WIDTH_C-1 downto 0);
	signal c_zero					: std_logic;
	signal c_alu_result				: std_logic_vector(DATA_WIDTH_C-1 downto 0);
	
	signal c_data_addr				: std_logic_vector(DATA_WIDTH_C-1 downto 0);
	signal c_data_in, c_data_out	: std_logic_vector(DATA_WIDTH_C-1 downto 0);
	

begin

instr_mem : entity memory_lib.ram_1w
port map(
	clk			=> clk,
	rst			=> rst,
	we			=> '0',
	addr		=> c_instr_rd_addr,
	wr_data		=> (others => '0'),
	rd_data		=> c_instr
);

reg_bank : entity memory_lib.reg_bank
port map(
	clk			=> clk,
	rst			=> rst,
	rd_reg_1	=> c_rd_reg_1,
	rd_reg_2	=> c_rd_reg_2,
	wr_reg		=> c_wr_reg,
	wr_data		=> c_reg_in,
	rd_data_1	=> c_reg_out_1,
	rd_data_2	=> c_reg_out_2
);

alu_ctrl : entity alu_lib.alu_ctrl
port map(
	clk			=> clk,
	rst			=> rst,
);

alu : entity alu_lib.alu
port map(
	clk			=> clk,
	rst			=> rst,
	op			=> c_op,
	operand_1	=> c_operand_1,
	operand_2	=> c_operand_2,
	zero		=> c_zero,
	result		=> c_alu_result
);

data_mem : entity memory_lib.ram_1w
port map(
	clk			=> clk,
	rst			=> rst,
	we			=> '1',
	addr		=> c_data_addr,
	wr_data		=> c_data_in,
	rd_data		=> c_data_out
);

end architecture;