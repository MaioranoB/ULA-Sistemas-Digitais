library ieee;
use ieee.std_logic_1164.all;

entity subtrator1bit is
port (
		a,b,bIN 	 : in  std_logic;
		diff,bOUT : out std_logic
);
end subtrator1bit;

architecture behav of subtrator1bit is
begin
	diff <= a xor b xor bIN;
	bOUT <= (not a and b) or (not a and bIN) or (b and bIN);
end behav;


library ieee;
use ieee.std_logic_1164.all;

entity subtrator4bit is
port (a,b  		 : in std_logic_vector(3 downto 0);
		borrowIN  : in std_logic;
		diff		 : out std_logic_vector(3 downto 0);
		borrowOUT : out std_logic
);
end subtrator4bit;

architecture structure of subtrator4bit is
	
	--signal borrow: std_logic_vector(4 downto 0);
	signal b_aux1,b_aux2,b_aux3 : std_logic; --borrow's parciais
	
	component subtrator1bit
		port (a,b,Bin   : in std_logic;
				diff,Bout : out std_logic
		);
	end component;
	
	begin
	FS0: subtrator1bit port map (a(0), b(0), borrowIN,  diff(0), b_aux1);
	FS1: subtrator1bit port map (a(1), b(1), b_aux1,    diff(1), b_aux2);
	FS2: subtrator1bit port map (a(2), b(2), b_aux2,    diff(2), b_aux3);
	FS3: subtrator1bit port map (a(3), b(3), b_aux3,    diff(3), borrowOUT);
	
end structure;