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
	component somador4bit
		port (a,b      : in std_logic_vector(3 downto 0);
				carryIN  : in std_logic;
				sum      : out std_logic_vector(3 downto 0);
				carryOUT : out std_logic
		);
	end component;
	
	signal invertedB : std_logic_vector(3 downto 0) := not b;
	signal somadorCarryOut: std_logic;
	
begin
	
	subtraction: somador4bit port map (a, invertedB, '1', diff, somadorCarryOut);
	borrowOUT <= not somadorCarryOut;
	
end structure;