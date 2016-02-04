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

entity level_change_domain is
    generic(number_of_domain_cross_regs : natural := 2)
    Port ( signal_in : in  STD_LOGIC;
           SystemClk : in  STD_LOGIC;
           signal_out : out  STD_LOGIC);
end level_change_domain;

architecture Behavioral of level_change_domain is

  signal DomainOut : std_logic_vector(number_of_domain_cross_regs-1 downto 0) := (others => '0');

  attribute ASYNC_REG : string;
  attribute ASYNC_REG of DomainOut: signal is "TRUE";
  
begin
  
  DomainCrossProc : process(SystemClk)    -- Domain cross level change from In clock to System clock
  begin
    if rising_edge(SystemClk) then
      DomainOut <= DomainOut(DomainOut'left-1 downto DomainOut'right) & signal_in;
    end if;
  end process;
  
  signal_out <= DomainOut(number_of_domain_cross_regs-1);

end Behavioral;

