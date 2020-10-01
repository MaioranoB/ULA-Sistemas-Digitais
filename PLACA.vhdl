library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

entity PLACA is
port (CLOCK_50 : in std_logic; 
		V_BT     : in  std_logic_vector(1 downto 0);  --V_BT(0)=reset V_BT(1)=selecao (carrega A e B simultaneamente)
		V_SW		: in  std_logic_vector(17 downto 9); --switches A:17ate14 / B:12ate9
		G_HEX7	: out std_logic_vector(6 downto 0);  --display7seg -> entradaA 
		G_HEX6	: out std_logic_vector(6 downto 0);  --display7seg -> entradaB
		G_HEX5	: out std_logic_vector(6 downto 0);  --display7seg -> resultado
		G_LEDG	: out std_logic_vector(0 downto 0);  --greenLED carry/borrow out
		G_LEDR	: out std_logic_vector(2 downto 0)   --redLED mostra operaçao atual
);
end PLACA;

architecture behav of PLACA is

	component interface
		port (clk, reset, botaoSEL : in std_logic; --botaoSEL carrega A e B simultaneamente
				entradaA, entradaB   : in std_logic_vector (3 downto 0); -- switches 
				resultadoDISPLAY	   : out std_logic_vector(3 downto 0); --display pra A e B tbm
				carry_borrowLED      : out std_logic;
				operacaoLED          : out std_logic_vector(2 downto 0)
		);
	end component;
	
	component decodificador7seg
		port (data_in  :in std_logic_vector (3 downto 0); --V_SW   : in std_logic_vector(3 downto 0);
				data_out :out std_logic_vector (6 downto 0) --G_HEX0 : out std_logic_vector(6 downto 0)
		);
	end component;
	
	component divisorFREQ
		port (clk	: in std_logic;
				reset	: in std_logic;
				saida : out std_logic
		);
	end component;
		
	signal clk1seg  : std_logic;
	signal resultado:std_logic_vector(3 downto 0) := "0000";
	
begin

	DIVfreq: divisorFREQ port map (CLOCK_50,V_BT(0),clk1seg); -- entradas: clock 50 Mhz, Botao de Reset, saida: clock de 1 seg
	
	ITERF  : interface port map (clk1seg,V_BT(0),V_BT(1), -- entrada: clock de 1 seg, reset, botao de seleção 
										  V_SW(17 downto 14),V_SW(12 downto 9), -- entrada: A,B
										  resultado,G_LEDG(0),G_LEDR);  -- saida: result,carry/borrowOUT,operacao
										  
	DECOD0 : decodificador7seg port map (V_SW(17 downto 14),G_HEX7); --entrada: A, saida: display 7 seg entrada A
	DECOD1 : decodificador7seg port map (V_SW(12 downto 9) ,G_HEX6); --entrada: B, saida: display 7 seg entrada B
	DECOD2 : decodificador7seg port map (resultado,G_HEX5); --entrada: resultado, saida: display 7 seg resultado
	
end behav;