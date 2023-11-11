library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity regbank is
  port (
    clk     : in    std_logic;
    reset   : in    std_logic;
    rdaddr1 : in    std_logic_vector(4 downto 0);
    rdaddr2 : in    std_logic_vector(4 downto 0);
    wraddr  : in    std_logic_vector(4 downto 0);
    wdata   : in    std_logic_vector(31 downto 0);
    we      : in    std_logic;

    rddata1 : out   std_logic_vector(31 downto 0);
    rddata2 : out   std_logic_vector(31 downto 0)
  );
end entity regbank;

architecture rtl of regbank is

  type regs_array is array(0 to 31) of std_logic_vector(31 downto 0);
  
  signal regs : regs_array;

begin

  rddata1 <= regs(to_integer(unsigned(rdaddr1)));
  rddata2 <= regs(to_integer(unsigned(rdaddr2)));

  process (clk) is
  begin

    if rising_edge(clk) then
      if (reset = '1') then

        for i in 0 to 31 loop

          regs(i) <= (others => '0');

        end loop;

      end if;
      if (we = '1') then
        regs(to_integer(unsigned(wraddr))) <= wdata;
      end if;
    end if;

  end process;

end architecture rtl;
