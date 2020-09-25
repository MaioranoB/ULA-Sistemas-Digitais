library ieee;
use ieee.std_logic_1164.all;

--full adder
entity somador1bit is
port (a,b,cIN : in std_logic;
		s,cOUT  :out std_logic
);
end somador1bit;

architecture behav of somador1bit is
begin
	s    <= (a xor b) xor cIN;
	cOUT <= (a and b) or (cIN and (a xor b));
end behav;

--tem q repetir dps de cada entity???
library ieee;
use ieee.std_logic_1164.all;

entity somador4bit is
port (a,b      : in std_logic_vector(3 downto 0);
		carryIN  : in std_logic;
		sum      : out std_logic_vector(3 downto 0);
		carryOUT : out std_logic
);
end somador4bit;

architecture structure of somador4bit is
	
	signal c_aux1,c_aux2,c_aux3 : std_logic; --cary's das somas parciais
	
	component somador1bit
		port (a,b,cIN : in std_logic;
				s,cOUT : out std_logic
		);
	end component;
	
	begin
	FA0: somador1bit port map (a(0), b(0), carryIN, sum(0), c_aux1);
	FA1: somador1bit port map (a(1), b(1), c_aux1,  sum(1), c_aux2);
	FA2: somador1bit port map (a(2), b(2), c_aux2,  sum(2), c_aux3);
	FA3: somador1bit port map (a(3), b(3), c_aux3,  sum(3), carryOUT);
	
end structure;