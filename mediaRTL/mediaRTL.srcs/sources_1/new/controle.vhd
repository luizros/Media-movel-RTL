    
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


entity controle is
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
end controle;

architecture Behavioral of controle is

type tipo_estado is (e0, e1, e2, e3, e4, e5, e6);
signal estado_atual, proximo_estado: tipo_estado:= e0; 
signal sready: std_logic:='0';
signal ssready: std_logic:='0';
signal sstart: std_logic:='0';
begin

    -- processo sequencial para registrar estados
    process(clk, reset)
    begin
        if reset = '1' then
            estado_atual <= e0;
        elsif rising_edge(clk) then
            estado_atual <= proximo_estado;
        end if;
    end process;
      
    -- processo combinacional para transição de estados
 
    process(estado_atual, start)
    begin
        case estado_atual is
            when e0 => -- inicialização
                proximo_estado <= e1;
            when e1 => -- registra o valor de x                 
                if start = '1' then
                    proximo_estado <= e2;
                else 
                    proximo_estado <= e1;
                end if;
            when e2 => -- deslocamento
                proximo_estado <= e3;               
            when e3 => -- registra a subtração
                proximo_estado <= e4;               
            when e4 => -- registra o deslocamento
                proximo_estado <= e5;
                
            when e5 => -- registra a media
                proximo_estado <= e6;            
            when e6 => -- mostra a saída
                if start = '1' then
                    proximo_estado <= e6;
                else
                    proximo_estado <= e1;
                end if;            
            when others =>
                proximo_estado <= e1;
                
        end case;
    end process;
    
    
    -- processo combinacional para saídas
    
    process(estado_atual)
    begin
        case estado_atual is
            when e0 =>
                clr_regX        <= '1';
                load_regX       <= '0';
                clr_registraX <= '1';
                load_registraX <= '0';                  
                clr_regx_subtracao   <= '1'; 
                load_regx_subtracao  <= '0';
                clr_desloc_media  <= '1'; 
                load_desloc_media <= '0';
                clr_soma_media  <= '1';  
                load_soma_media <= '0';                
                sready <= '0';                                        
            when e1 =>
                clr_regX        <= '0';
                load_regX       <= '0';
                clr_registraX <= '0';
                load_registraX <= '1';                   
                clr_regx_subtracao   <= '0'; 
                load_regx_subtracao  <= '0';
                clr_desloc_media  <= '0'; 
                load_desloc_media <= '0';
                clr_soma_media  <= '0';  
                load_soma_media <= '0';                
                sready <= '0';                                                                        
            when e2 =>
                clr_regX        <= '0';
                load_regX       <= '1';
                clr_registraX <= '0';
                load_registraX <= '0';                   
                clr_regx_subtracao   <= '0'; 
                load_regx_subtracao  <= '0';
                clr_desloc_media  <= '0'; 
                load_desloc_media <= '0';
                clr_soma_media  <= '0';  
                load_soma_media <= '0';                
                sready <= '0';    
            when e3 =>
                clr_regX        <= '0';
                load_regX       <= '0';
                clr_registraX <= '0';
                load_registraX <= '0';                   
                clr_regx_subtracao   <= '0'; 
                load_regx_subtracao  <= '1';
                clr_desloc_media  <= '0'; 
                load_desloc_media <= '0';
                clr_soma_media  <= '0';  
                load_soma_media <= '0';                
                sready <= '0';  
            when e4 =>
                clr_regX        <= '0';
                load_regX       <= '0';
                clr_registraX <= '0';
                load_registraX <= '0';                   
                clr_regx_subtracao   <= '0'; 
                load_regx_subtracao  <= '0';
                clr_desloc_media  <= '0'; 
                load_desloc_media <= '1';
                clr_soma_media  <= '0';  
                load_soma_media <= '0';                
                sready <= '0';
            when e5 =>
                clr_regX        <= '0';
                load_regX       <= '0';
                clr_registraX <= '0';
                load_registraX <= '0';                   
                clr_regx_subtracao   <= '0'; 
                load_regx_subtracao  <= '0';
                clr_desloc_media  <= '0'; 
                load_desloc_media <= '0';
                clr_soma_media  <= '0';  
                load_soma_media <= '1';                
                sready <= '0';  
            when e6 =>
                clr_regX        <= '0';
                load_regX       <= '0';
                clr_registraX <= '0';
                load_registraX <= '0';                   
                clr_regx_subtracao   <= '0'; 
                load_regx_subtracao  <= '0';
                clr_desloc_media  <= '0'; 
                load_desloc_media <= '0';
                clr_soma_media  <= '0';  
                load_soma_media <= '0';                
                sready <= '1';                                                                                                         
            when others =>
                clr_regX        <= '0';
                load_regX       <= '0';
                clr_registraX <= '0';
                load_registraX <= '1';                   
                clr_regx_subtracao   <= '0'; 
                load_regx_subtracao  <= '0';
                clr_desloc_media  <= '0'; 
                load_desloc_media <= '0';
                clr_soma_media  <= '0';  
                load_soma_media <= '0';                
                sready <= '0';                                                                      
        end case;
    end process;
    
    
    process(sready, reset)
    variable cnt: integer range 0 to 8:=8; 
    begin
    if reset = '1' then
        cnt:= 8;
        ssready <= '0';
    elsif rising_edge(sready) then
        cnt := cnt - 1;
        if cnt = 0 then
            cnt := 8;
            ssready <= '1';
        else
            ssready <= '0';
        end if;
    end if;
    end process;
    ready <= ssready;
end Behavioral;
