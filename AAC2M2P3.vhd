library ieee;
use ieee.std_logic_1164.all;

entity FSM is
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;

architecture arch_FSM of FSM is
   type statetype is (A, B, C);
   signal currentstate, nextstate : statetype;
begin
   syncprocess: process(RST, CLK)
   begin
      if (RST = '1') then
         currentstate <= A;
      elsif (rising_edge(CLK)) then
         currentstate <= nextstate;
      end if;
   end process syncprocess;

   circuitprocess: process(currentstate, In1)
   begin
      case currentstate is
         when A =>
            Out1 <= '0';
            if (In1 = '1' ) then
            nextstate <= B;
            else
            nextstate <= A;
            end if;
         when B =>
            Out1 <= '0';
            if (In1 = '1' ) then
            nextstate <= B;
            else
            nextstate <= C;
            end if;
         when C =>
            Out1 <= '1';
            if (In1 = '1' ) then
            nextstate <= A;
            else
            nextstate <= C;
            end if;
         when others =>
            Out1 <= '0';
            nextstate <= A;
      end case;
   end process circuitprocess;
end arch_FSM;


      