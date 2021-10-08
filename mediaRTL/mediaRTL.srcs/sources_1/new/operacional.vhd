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


entity operacional is
    Port (x: in std_logic_vector(7 downto 0);
          clk: in std_logic;
          clear_regX: in std_logic;
          load_regX: in std_logic;
          clear_registraX: in std_logic;
          load_registraX: in std_logic;
          clear_regx_subtracao: in std_logic;
          load_regx_subtracao: in std_logic;          
          clear_desloc_media: in std_logic;
          load_desloc_media: in std_logic;
          clear_soma_media: in std_logic;
          load_soma_media: in std_logic;          
          media: out std_logic_vector(7 downto 0)
                    
     );
end operacional;

architecture Behavioral of operacional is

type array1D is array (0 to 8) of std_logic_vector(7 downto 0);
signal sregX: array1D:=(others=>(others=>'0')); -- Array que contem os valores das entradas
signal regx: std_logic_vector(7 downto 0):=(others=>'0'); -- Registra o valor total das entradas
signal subtracao: std_logic_vector(7 downto 0):=(others=>'0'); -- Registra a soma dos elementos
signal smedia: std_logic_vector(7 downto 0):=(others=>'0'); -- Registra a média
signal preAvg: std_logic_vector(7 downto 0):=(others=>'0'); 
signal soma_media: std_logic_vector(7 downto 0):=(others=>'0');
signal registraX: std_logic_vector(7 downto 0):=(others=>'0');
begin

    -- processo para deslocar array
    
    deslocador: process(clear_regX, clk, x)
    begin
        if clear_regX = '1' then
            sregX(0) <= x;
            sregX(1) <= x;
            sregX(2) <= x;
            sregX(3) <= x;
            sregX(4) <= x;
            sregX(5) <= x;
            sregX(6) <= x;
            sregX(7) <= x;
            sregX(8) <= x;
        elsif rising_edge(clk) then
            if load_regX = '1' then
                sregX(0) <= sregx(1);
                sregX(1) <= sregX(2);
                sregX(2) <= sregX(3);
                sregX(3) <= sregX(4);
                sregX(4) <= sregX(5);
                sregX(5) <= sregX(6);
                sregX(6) <= sregX(7);
                sregX(7) <= sregX(8);
                sregX(8) <= registrax;
            end if;
        end if;
    end process;
    
    --processo para armazenar o valor de x
    
    registra_x: process(clk,clear_registraX)
    begin
        if clear_registraX = '1' then
            registraX <= (others=>'0'); 
        elsif rising_edge(clk) then
            if load_registraX = '1' then
               registraX <= x;
            end if;
        end if;
    end process;
    
    -- processo somar os valores 
    
    soma_x: process(clk, clear_regx_subtracao)
    begin
        if clear_regx_subtracao = '1' then
            subtracao <= (others=>'0'); 
        elsif rising_edge(clk) then
            if load_regx_subtracao = '1' then
                subtracao <= std_logic_vector(signed(sregX(8)) - signed(sregX(0)));
            end if;
        end if;
    end process;
    
    -- processo para deslocar os valores
    
    desloca_soma: process(clk, clear_desloc_media)
    begin
        if clear_desloc_media = '1' then
            smedia <= (others=>'0');
        elsif rising_edge(clk) then
            if load_desloc_media = '1' then
                smedia <= subtracao(7) & subtracao(7) & subtracao(7) & subtracao(7 downto 3);
            end if;
        end if;    
    end process;
    
    --processo para somar a média anterior
    
    process(clk, clear_soma_media, x)
    begin
        if clear_soma_media = '1' then
            soma_media <= x;
        elsif rising_edge(clk) then
            if load_soma_media = '1' then
                soma_media <= std_logic_vector(signed(preAvg) + signed(smedia));
            end if;    
        end if; 
    end process;
  
    preAvg <= soma_media;
    media <= preAvg;
end Behavioral;
