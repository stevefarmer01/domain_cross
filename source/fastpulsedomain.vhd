----------------------------------------------------------------------------------
-- Engineer: 			Steve Farmer
-- 
-- Design Name: 		Sparten6G
-- Module Name:    	FastPulseDomain 
-- Project Name: 
-- Target Devices: 	xc6slx100-2fgg484, xc6slx150-2fgg484
-- Tool versions: 	ISE 13.2(nt)
-- Description: 		Captures fast pulses from a fast clock domain into a pulse in a slow clk domain.
--							Designed to capture pulses from 'auxdataextractent' onto doubled OscClk fo 54MHz.
--							These pulses can be one every 4 clk cycles at 148MHz(3G) or 74Mhz(HD) or one every..
--							..3 clk cycles at 27 MHz(SD).
--							Max performance (in simulation) is 216MHz at one pulse every 4 clk cycles.
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

entity fastpulsedomain is
    Port ( InPulse : in  STD_LOGIC;
           InClk : in  STD_LOGIC;
           SystemClk : in  STD_LOGIC;
           SystemPulse : out  STD_LOGIC);
end fastpulsedomain;

architecture Behavioral of fastpulsedomain is

	signal PulseOut : std_logic := '0';
	signal DomainOut : std_logic_vector(2 downto 0) := (others => '0');
	signal SystemPulseOut : std_logic := '0';

	attribute ASYNC_REG : string;
	attribute ASYNC_REG of DomainOut: signal is "TRUE";
	
begin

	InPulseProc : process(InClk)		-- Pulse in changed into a level change of register output
	begin
		if rising_edge(InClk) then
			if InPulse = '1' then
				PulseOut <= not PulseOut;
			end if;
		end if;
	end process;
	
	DomainCrossProc : process(SystemClk)		-- Domain cross level change from In clock to System clock
	begin
		if rising_edge(SystemClk) then
			DomainOut <= DomainOut(DomainOut'left-1 downto DomainOut'right) & PulseOut;
		end if;
	end process;
	
	XOR_Proc : process(SystemClk)
	begin
		if rising_edge(SystemClk) then
			SystemPulseOut <= DomainOut(DomainOut'left) xor DomainOut(DomainOut'left-1);
		end if;
	end process;

	SystemPulse <= SystemPulseOut;

end Behavioral;

