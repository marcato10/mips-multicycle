library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity data_memory is
  port (
    clk       : in    std_logic;
    memread   : in    std_logic;
    memwrite  : in    std_logic;
    address   : in    std_logic_vector(31 downto 0);
    writedata : in    std_logic_vector(31 downto 0);
    memdata   : out   std_logic_vector(31 downto 0)
  );
end entity data_memory;

architecture behavior of data_memory is

  -- 8192 BYTES (8 KB)

  type memory_map is array(0 to 2047) of std_logic_vector(31 downto 0);

  signal internal_memory : memory_map := (others => (others => '0'));

begin

  process (clk) is

    variable address_index : natural;

  begin

    if rising_edge(clk) then
      address_index := to_integer(unsigned(address and x"000007FF"));
      if (memread = '1') then
        memdata <= internal_memory(address_index);
      elsif (memwrite = '1') then
        internal_memory(address_index) <= writedata;
      end if;
    end if;

  end process;

end architecture behavior;
