----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2016 13:25:16
-- Design Name: 
-- Module Name: level_change_domain_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity level_change_domain_top is
    generic(number_of_domain_cross_regs : natural := 3);
    Port ( signal_in : in  std_logic_vector(3 downto 0);
           signal_in_bit : in  std_logic;
           SystemClk : in  std_logic;
           signal_out : out  std_logic_vector(3 downto 0);
           signal_out_bit : out  std_logic
           );
end level_change_domain_top;

architecture Behavioral of level_change_domain_top is

component level_change_domain
    generic(number_of_domain_cross_regs : natural := 2);
    Port ( signal_in : in  std_logic_vector;
           SystemClk : in  std_logic;
           signal_out : out  std_logic_vector
           );
end component;

begin

inst_level_change_domain : level_change_domain
    generic map(
            number_of_domain_cross_regs => number_of_domain_cross_regs -- : natural := 2
            )
    Port map( 
            signal_in => signal_in,         -- : in  std_logic_vector;
            SystemClk => SystemClk,         -- : in  std_logic;
            signal_out => signal_out        -- : out  std_logic_vector
           );

inst_level_change_domain_bit : level_change_domain
    generic map(
            number_of_domain_cross_regs => number_of_domain_cross_regs -- : natural := 2
            )
    Port map( 
            signal_in(0) => signal_in_bit,  -- : in  std_logic_vector;
            SystemClk => SystemClk,         -- : in  std_logic;
            signal_out(0) => signal_out_bit -- : out  std_logic_vector
           );

end Behavioral;
