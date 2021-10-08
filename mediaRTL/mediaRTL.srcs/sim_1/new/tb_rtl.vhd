library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_rtl is
--  Port ( );
end tb_rtl;

architecture Behavioral of tb_rtl is

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

signal sclear_regX, sload_regX, sclear_registraX, sload_registraX, sclear_regx_subtracao, sload_regx_subtracao, sclear_desloc_media, sload_desloc_media, sclear_soma_media, sload_soma_media: std_logic;
signal sx,smedia: std_logic_vector(7 downto 0):="00000000";
signal sclk,sstart, sreset,sready: std_logic:='0';
--signal  sclk, sreset, sstart, sready: std_logic:='0'; 
--signal sx, smedia: std_logic_vector(7 downto 0):="00000000";

begin

-- uut: top_module port map(
--    x => sx,
--    clk => sclk,
--    reset => sreset,
--    start => sstart,
--    ready => sready,
--    media => smedia 
-- );

bloco_operacional: operacional port map(
           x => sx,
           clk => sclk,
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
           clk => sclk,
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
 
sclk <= not sclk after 5 ns; 
-- mudou o primeiro start                                            --  
--sstart <= '0', '1' after 100ns, '0' after 110ns,'1' after 160ns, '0' after 165ns,  '1' after 185ns,'0' after 220ns, '1' after 280ns,'0' after 285ns, '1' after 340ns,'0' after 345ns, '1' after 400ns, '0' after 405ns, '1' after 462.800ns, '0' after 470ns,'1' after 540ns, '0' after 545ns;

sstart <= '0','1' after 160ns, '0' after 165ns,  '1' after 220ns,'0' after 225ns, '1' after 280ns,'0' after 285ns, '1' after 340ns,'0' after 345ns, '1' after 400ns, '0' after 405ns, '1' after 462.800ns, '0' after 470ns,'1' after 540ns, '0' after 545ns, '1' after 600ns, '0' after 605ns, '1' after 660ns, '0' after 655ns;
sx <= "00110000", "01000000" after 145 ns,  "01010000" after 185 ns, "01100000" after 230 ns, "01110000" after 290 ns, "00010000" after 350 ns, "00100000" after 410 ns, "00000100" after 470 ns, "00001000" after 595 ns, "00011000" after 650 ns;  
         

end Behavioral;
