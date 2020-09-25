--	 					  a3  a2   a1   a0
-- 	 				  b3  b2   b1   b0	 X		
--             ---------------------------
--                a3b0 a2b0 a1b0 a0b0
--           a3b1 a2b1 a1b1 a0b1
--      a3b2 a2b2 a1b2 a0b2
-- a3b3 a2b3 a1b3 a0b3                    +
-------------------------------------------
-- mul6 mul5 mul4 mul3 mul2 mul1 mul0

--mul0 = a0b0
--mul1 = a1b0 + a0b1
--mul2 = a2b0 + a1b1 + a0b2 + (carry da soma anterior)
--mul3 = a3b0 + a2b1 + a1b2 + a0b3 + (os possiveis carry's da soma anterior)


library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all; --so pra debugar

entity multiplicador4bit is 
port( a,b  : in  std_logic_vector(3 downto 0);
		mult : out std_logic_vector(3 downto 0)
		--real_mult:out std_logic_vector(7 downto 0);  --debug da mult
);
end multiplicador4bit;

architecture behavior of multiplicador4bit is

	signal c1, c2_1, c2_2, c2_3 : std_logic := '0'; --sinal dos carry's temporarios
	signal aux1, aux2       	 : std_logic := '0';
	
begin
	mult(0) <= a(0) and b(0);
	
	mult(1) <= (a(1) and b(0)) xor (a(0) and b(1));
	c1 <= a(1) and b(0) and a(0) and b(1);
	
	mult(2) <= (((a(2) and b(0)) xor (a(1) and b(1))) xor (a(0) and b(2))) xor c1;
	
	aux1 <= ((a(2) and b(0)) xor (a(1) and b(1)));
	aux2 <= ((a(0) and b(2)) xor c1);
	c2_1 <= (a(2) and b(0) and a(1) and b(1));
	c2_2 <= (a(0) and b(2) and c1);
	c2_3 <= aux1 and aux2;
	
	mult(3) <= ((((a(3) and b(0)) xor
					(a(2) and b(1))) xor
					(a(1) and b(2))) xor
					(a(0) and b(3))) xor
					c2_1 xor c2_2 xor c2_3;
									
	--real_mult <= a* b;
end behavior;