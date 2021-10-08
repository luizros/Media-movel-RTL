-- Universidade de Brasília
--
-- Experimento 2
--
-- Disciplina: Prática de Eletrônica Digital 2 
--
-- Alunos: Luiz Felipe Rodrigues e Silva
--         Aldo Felipe Barbosa Filho


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_module is
    port (clk: in std_logic;
          ready: out std_logic;
          led: out std_logic_vector(7 downto 0)
            
    );
end top_module;

architecture Behavioral of top_module is


component operacional is
    Port (x: in std_logic_vector(7 downto 0);
          clk: in std_logic;
          clear_registraX: in std_logic;
          load_registraX: in std_logic;          
          clear_regX: in std_logic;
          load_regX: in std_logic;
          clear_regx_subtracao: in std_logic;
          load_regx_subtracao: in std_logic;          
          clear_desloc_media: in std_logic;
          load_desloc_media: in std_logic;
          clear_soma_media: in std_logic;
          load_soma_media: in std_logic;          
          media: out std_logic_vector( 7 downto 0)
                    
     );
end component;



component controle is
    Port ( clk: in std_logic;
           start: in std_logic; 
           reset: in std_logic;
           clr_registraX: out std_logic;
           load_registraX: out std_logic;           
           clr_regX: out std_logic;
           load_regX: out std_logic;
           clr_regx_subtracao: out std_logic;
           load_regx_subtracao: out std_logic;
           clr_desloc_media: out std_logic;
           load_desloc_media: out std_logic;
           clr_soma_media: out std_logic;
           load_soma_media: out std_logic;               
           ready: out std_logic          
          );
end component;

COMPONENT  vio_0
  PORT (
    clk : IN STD_LOGIC;
    probe_out0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out1 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out2 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END COMPONENT;

signal sclear_regX, sload_regX, sclear_registraX, sload_registraX, sclear_regx_subtracao, sload_regx_subtracao, sclear_desloc_media, sload_desloc_media, sclear_soma_media, sload_soma_media: std_logic;
signal sx, smedia: std_logic_vector(7 downto 0):="00000000";
signal sstart, sreset, sready: std_logic;

signal sclk : std_logic;
signal sclk_out : std_logic;
signal count : unsigned(25 downto 0);
constant preset : unsigned(25 downto 0) := "10111110101111000010000000"; --50.000.000
constant zero : unsigned(25 downto 0) := (others => '0');

begin

bloco_operacional: operacional port map(
           x => sx,
           clk => clk,
--           clk => sclk_out,
           clear_registraX => sclear_registraX,
           load_registraX => sload_registraX,
           clear_regX => sclear_regX,
           load_regX => sload_regX,
           clear_regx_subtracao => sclear_regx_subtracao,
           load_regx_subtracao => sload_regx_subtracao,     
           clear_desloc_media => sclear_desloc_media,
           load_desloc_media => sload_desloc_media,
           clear_soma_media => sclear_soma_media,
           load_soma_media => sload_soma_media,           
           media => smedia   
          );

bloco_de_controle: controle port map(
--           clk => sclk_out,
           clk => clk,
           start => sstart,
           reset => sreset,
           clr_registraX => sclear_registrax,
           load_registraX => sload_registrax,
           clr_regX => sclear_regx,
           load_regX => sload_regx,
           clr_regx_subtracao => sclear_regx_subtracao,
           load_regx_subtracao => sload_regx_subtracao,
           clr_desloc_media => sclear_desloc_media,
           load_desloc_media => sload_desloc_media,
           clr_soma_media => sclear_soma_media,
           load_soma_media => sload_soma_media,           
           ready => sready   
          );

meu_vio : vio_0
  PORT MAP (
    clk => clk,
    probe_out0 => sx,
    probe_out1(0) => sstart,
    probe_out2(0) => sreset
  );
  
 

  led <= smedia;
  ready <= sready;
  
  
--  meu_clkdiv: process(clk,sreset)
--    begin
--        if sreset='1' then
--            count <= zero;
--            sclk <= '0';
--        elsif rising_edge(clk) then
--            if (count=preset) then
--                count <= zero;
--                sclk <= not sclk; 
--            else
--                count <= count + 1;
--            end if;
--        end if;
--    end process;
  
--  sclk_out <= sclk;  

end Behavioral;