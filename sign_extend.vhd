library ieee;
  use ieee.std_logic_1164.all;

entity sign_extend is
  port (
    input_data  : in    std_logic_vector(15 downto 0);
    output_data : out   std_logic_vector(31 downto 0)
  );
end entity sign_extend;

architecture rtl of sign_extend is

begin

  output_data <= (others => input_data(15)) & input_data;

end architecture rtl;
