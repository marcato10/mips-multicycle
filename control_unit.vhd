library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity control_unit is
  port (
    clk           : in    std_logic;
    op_code       : in    std_logic_vector(5 downto 0);
    pc_write      : out   std_logic;
    pc_write_cond : out   std_logic;
    iord          : out   std_logic;
    mem_read      : out   std_logic;
    mem_write     : out   std_logic;
    mem_to_reg    : out   std_logic;
    ir_write      : out   std_logic;
    pc_source     : out   std_logic_vector(1 downto 0);
    alu_op        : out   std_logic_vector(1 downto 0);
    alu_src_b     : out   std_logic_vector(1 downto 0);
    alu_src_a     : out   std_logic;
    reg_write     : out   std_logic;
    reg_dst       : out   std_logic
  );
end entity control_unit;

architecture rtl of control_unit is

  signal   state : std_logic_vector(4 downto 0);
  constant addi  : std_logic_vector(5 downto 0) := "001000";
  constant lw    : std_logic_vector(5 downto 0) := "100011";
  constant sw    : std_logic_vector(5 downto 0) := "101011";
  constant fetch : std_logic_vector(4 downto 0) := "00000";

begin

  -- ADDI
  -- BGTZ Branch Equal to Zero

  -- TODO: SLT, LI, MOVE

  process (clk) is
  begin

    -- States Definition
    case state is

      -- 0 FETCH
      when "00000" =>

        pc_write_cond <= '1';
        pc_write      <= '1';
        iord          <= '0';
        mem_read      <= '1';
        mem_write     <= '0';
        mem_to_reg    <= '0';
        ir_write      <= '1';
        pc_source     <= "00";
        alu_op        <= "00";
        alu_src_a     <= '0';
        alu_src_b     <= "01";
        reg_write     <= '0';
        reg_dst       <= '0';

      -- 1 DECODE
      when "00001" =>

        pc_write_cond <= '0';
        pc_write      <= '0';
        mem_read      <= '0';
        mem_write     <= '0';
        ir_write      <= '0';
        alu_op        <= "00";
        alu_src_a     <= '0';
        alu_src_b     <= "11";
        reg_write     <= '0';

      -- 2 LW/SW/I-Type
      when "00010" =>

        alu_src_a <= '1';
        alu_src_b <= "10";
        alu_op    <= "00";

      -- 3 - LW Memory Access
      when "00011" =>

        iord     <= '1';
        mem_read <= '1';

      -- 4 - Write Back
      when "00100" =>

        reg_dst    <= '0';
        reg_write  <= '1';
        mem_to_reg <= '1';

      -- 5 SW Memory Access
      when "00101" =>

        mem_write <= '1';
        iord      <= '1';

      -- 6 R-Type Execution
      when "00110" =>

        alu_src_a <= '1';
        alu_src_b <= "00";
        alu_op    <= "10";

      -- 7 Write-Back R-Type
      when "00111" =>

        reg_dst    <= '1';
        reg_write  <= '1';
        mem_to_reg <= '0';

      -- 8 BEQ
      when "01000" =>

        alu_src_a     <= '1';
        alu_src_b     <= "00";
        alu_op        <= "01";
        pc_write_cond <= '1';
        pc_source     <= "01";

      -- 9 J
      when "01001" =>

        pc_write  <= '1';
        pc_source <= "10";

    end case;

    -- Instructions - State Transition
    -- FETCH/DECODE
    if (state = "00000") then
      state <= "00001";

    -- FETCH DISPATCH
    elsif (state = "00001") then
      -- LW/SW/I-Type
      state <= "00011" when op_code = lw or op_code = sw or op_code = addi else
               -- R-Type
               "00110" when op_code = "000000" else
               -- BEQ
               "01000" when op_code = "000100" else
               -- Jump
               "01001" when op_code = "000010";
    -- MEMORY ADDRESS/I-TYPE DISPATCH
    elsif (state = "00010") then
      state <= "00011" when op_code = lw else
               "00101" when op_code = sw;
    elsif (state = "00011") then
      state <= "00100";
    elsif (state = "00100") then
      state <= fetch;
    elsif (state = "00101") then
      state <= fetch;
    elsif (state = "00110") then
      state <= "00111";
    elsif (state = "00111") then
      state <= fetch;
    elsif (state = "01000") then
      state <= fetch;
    elsif (state = "01000") then
      state <= fetch;
    end if;

  end process;

end architecture rtl;
