library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity single_reg is
  port (
    clk     : in    std_logic;
    wdata   : in    std_logic_vector(31 downto 0);
    we      : in    std_logic;
    rddata1 : out   std_logic_vector(31 downto 0)
  );
end entity single_reg;

architecture rtl of single_reg is

  signal reg : std_logic_vector(31 downto 0);

begin

  process (clk) is
  begin

    if rising_edge(clk) then
      if (we = '1') then
        reg <= wdata;
      end if;
    end if;

  end process;

  rddata1 <= reg;

end architecture rtl;
