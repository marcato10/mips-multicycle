library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity cpu is
  port (
    clk : in    std_logic
  );
end entity cpu;

architecture rtl of cpu is

  signal instruction_reg                                    : std_logic_vector(31 downto 0);
  signal instruction_25_21_signal, instruction_20_16_signal : std_logic_vector(4 downto 0);
  signal instruction_15_0_signal                            : std_logic_vector(15 downto 0);

  signal alu_result : std_logic_vector(31 downto 0);
  signal alu_out    : std_logic_vector(31 downto 0);
  signal mem_data   : std_logic_vector(31 downto 0);

  signal funct : std_logic_vector (4 downto 0) ;
  component single_reg is
    port (
      clk     : in    std_logic;
      wdata   : in    std_logic_vector(31 downto 0);
      we      : in    std_logic;
      rddata1 : out   std_logic_vector(31 downto 0)
    );
  end component;

  component ula is
  end component;

  signal ir_write_signal      : std_logic;
  signal pc_write_signal      : std_logic;
  signal pc_write_cond_signal : std_logic;
  signal iord_signal          : std_logic;
  signal mem_read_signal      : std_logic;
  signal mem_write_signal     : std_logic;
  signal mem_to_reg_signal    : std_logic;
  signal pc_source_signal     : std_logic_vector(2 downto 0);
  signal alu_op_signal        : std_logic_vector(4 downto 0);
  signal alu_src_b_signal     : std_logic_vector(4 downto 0);
  signal alu_src_a_signal     : std_logic;
  signal reg_write_signal     : std_logic;
  signal reg_dst_signal       : std_logic;

  --Sinais do IR

  signal instruction_31_26_signal : std_logic_vector(5 downto 0);

begin

  

end architecture rtl;
