-- sel  operaçao
-- 000  soma
-- 001  subtração
-- 010  multiplicação
-- 011  AND
-- 100  OR
-- 101  XOR
-- 110  NOT A
-- 111  NOT B

library ieee;
use ieee.std_logic_1164.all;

entity ULA is
port (A,B       		  : in std_logic_vector(3 downto 0);
		selection 		  : in std_logic_vector(2 downto 0);
		result    		  : out std_logic_vector(3 downto 0);
		carry_borrow_OUT : out std_logic --colocar um carry/borrow IN na ula??
);
end ULA;

architecture structure of ULA is
	
	signal result_soma, result_sub, result_mult : std_logic_vector(3 downto 0);
	signal carryOUT,borrowOUT: std_logic;
	
	component somador4bit
		port (a,b      : in std_logic_vector(3 downto 0);
				carryIN  : in std_logic;
				sum      : out std_logic_vector(3 downto 0);
				carryOUT : out std_logic
		);
	end component;
	
	component subtrator4bit
		port (a,b  		 : in std_logic_vector(3 downto 0);
				borrowIN  : in std_logic;
				diff		 : out std_logic_vector(3 downto 0);
				borrowOUT : out std_logic
		);
	end component;
	
	component multiplicador4bit
		port (a,b  : in  std_logic_vector(3 downto 0);
				mult : out std_logic_vector(3 downto 0)
		);
	end component;
	
	begin
	soma: somador4bit       port map (a, b, '0', result_soma, carryOUT);
	diff: subtrator4bit     port map (a, b, '0', result_sub,  borrowOUT);
	mult: multiplicador4bit port map (a, b, result_mult);
	

	with selection select
		result <= result_soma when "000",
					 result_sub  when "001",
					 result_mult when "010",
					 a and b     when "011",
					 a or b      when "100",
					 a xor b     when "101",
					 not a       when "110",
					 not b       when "111",
					 "0000"      when others;
		
	with selection select
		carry_borrow_OUT <= carryOUT  when "000",
								  borrowOUT when "001",
								  '0' 		when others;
	
	
	
	
	
--	case selection is
--		when "000" => result <= result_soma;
--		when "001" => result <= result_sub;
--		when "010" => result <= result_mult;
--		when "011" => result <= a and b;
--		when "100" => result <= a or b;
--		when "101" => result <= a xor b;
--		when "110" => result <= not a;
--		when "111" => result <= not b;
--		when others=> result <= "0000";
--	end case;
	
end structure;