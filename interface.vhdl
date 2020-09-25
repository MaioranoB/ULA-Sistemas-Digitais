library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;


entity interface is
port (CLOCK_50, reset, botaoSEL : in std_logic; --botaoSEL carrega A e B simultaneamente
		entradaA, entradaB : in std_logic_vector (3 downto 0); -- switches
		resultadoDISPLAY	  : out std_logic_vector(3 downto 0); --display pra A e B tbm
		carry_borrowLED : out std_logic;
		operacaoLED : out std_logic_vector(2 downto 0)
		--ledsToShowInAndOut : out std_logic_vector (3 downto 0)); -- leds dos númerosx,y e result
);
end interface;

architecture behav of interface is

	component ULA
		port (A,B       		  : in std_logic_vector(3 downto 0);
				selection 		  : in std_logic_vector(2 downto 0);
				result    		  : out std_logic_vector(3 downto 0);
				carry_borrow_OUT : out std_logic
		);
	end component;
	
--	component decodificador7seg
--		port (data_in:    in std_logic_vector (3 downto 0); --V_SW   : in std_logic_vector(3 downto 0);
--				data_out:   out std_logic_vector (6 downto 0) --G_HEX0 : out std_logic_vector(6 downto 0)
--		);
--	end component;
	
--	component divisorFREQ
--		port (clk	: in std_logic;
--				reset	: in std_logic;
--				saida : out std_logic
--		);
--	end component;
		
	signal A, B, result: std_logic_vector(3 downto 0) := "0000";
	signal carry_borrow: std_logic := '0';
	signal operacao : std_logic_vector(2 downto 0) := "000";
	--signal estado : std_logic := '0'; --0 = selecionando A e B / 1 = A e B selecionados
	type tipo_estado is (entrada, saida);
	signal estado : tipo_estado := entrada;
	
begin
	alu: ULA port map (A, B, operacao, result, carry_borrow);
	process(CLOCK_50, botaoSEL, reset)
		--variable op: std_logic_vector(2 downto 0) := "000";
		begin
				resultadoDISPLAY <= result;
				operacaoLED <= operacao;
				carry_borrowLED <= carry_borrow;
			if reset = '1' then --ajeitar a logica do botao dps
				estado <= entrada;
				A <= "0000";
				B <= "0000";
				operacao <= "000";
			elsif (estado = entrada and botaoSEL = '1')then --botao manda 0 quando eh apertado!! mudar isso dps
				estado <= saida;
				A <= entradaA;
				B <= entradaB;
				operacao <= "000";
			elsif (estado = saida and rising_edge(CLOCK_50))then
				
					if operacao = "000" then
						operacao <= "001";
					elsif operacao = "001" then
						operacao <= "010";
					elsif operacao = "010" then
						operacao <= "011";
					elsif operacao = "011" then
						operacao <= "100";
					elsif operacao = "100" then
						operacao <= "101";
					elsif operacao = "101" then
						operacao <= "110";
					elsif operacao = "110" then
						operacao <= "111";
					elsif operacao = "111" then
						operacao <= "000";
					end if;
			end if;
	end process;
	
--resultadoDISPLAY <= result;
--operacaoLED <= operacao;
--carry_borrowLED <= carry_borrow;

end behav;