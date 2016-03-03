----------------------------------------------------------------------------------
-- Engineer:      Steve Farmer
-- 
-- Design Name:     common_ip
-- Module Name:     level_change_domain 
-- Project Name: 
-- Target Devices:  
-- Tool versions:   Vivado 2014.1
-- Description:     Domain cross level change using multiple registers
--              
--              
--              
--              
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- For instantiation examples (especially for std_logic input/outputs as oppsed to std_logic_vector) see
-- - 'domain_cross\implementation\source\level_change_domain_top.vhd'

entity level_change_domain is
    generic(number_of_domain_cross_regs : natural := 2);
    Port ( signal_in : in  std_logic_vector;
           SystemClk : in  std_logic;
           signal_out : out  std_logic_vector
           );
end level_change_domain;

architecture Behavioral of level_change_domain is

  type domain_out_t is
     array (natural range <>) of std_logic_vector(number_of_domain_cross_regs-1 downto 0);

  signal DomainOut : domain_out_t(signal_in'RANGE) := (others => (others => '0'));

  attribute ASYNC_REG : string;
  attribute ASYNC_REG of DomainOut: signal is "TRUE";
  
begin

  gen : for i in signal_in'REVERSE_RANGE generate

    DomainCrossProc : process(SystemClk)    -- Domain cross level change from In clock to System clock
    begin
      if rising_edge(SystemClk) then
        DomainOut(i) <= DomainOut(i)(DomainOut(i)'left-1 downto DomainOut(i)'right) & signal_in(i);
      end if;
    end process;
  
    signal_out(i) <= DomainOut(i)(number_of_domain_cross_regs-1);

  end generate gen;

end Behavioral;

