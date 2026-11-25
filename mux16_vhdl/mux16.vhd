library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX16 is
    port (
        I : in  STD_LOGIC_VECTOR(15 downto 0);
        A : in  STD_LOGIC;
        B : in  STD_LOGIC;
        C : in  STD_LOGIC;
        D : in  STD_LOGIC;
        Y : out STD_LOGIC
    );
end entity MUX16;

architecture Gate_Level of MUX16 is
    signal X1, X2, X3, X4 : STD_LOGIC;
    signal NA, NB, NC, ND : STD_LOGIC;
begin
    -- Select lines: A is the MSB, D is the LSB.
    NA <= NOT A;
    NB <= NOT B;
    NC <= NOT C;
    ND <= NOT D;

    -- Block X1: inputs 0 through 3.
    X1 <= (I(0) AND NA AND NB AND NC AND ND) OR
          (I(1) AND NA AND NB AND NC AND D ) OR
          (I(2) AND NA AND NB AND C  AND ND) OR
          (I(3) AND NA AND NB AND C  AND D );

    -- Block X2: inputs 4 through 7.
    X2 <= (I(4) AND NA AND B AND NC AND ND) OR
          (I(5) AND NA AND B AND NC AND D ) OR
          (I(6) AND NA AND B AND C  AND ND) OR
          (I(7) AND NA AND B AND C  AND D );

    -- Block X3: inputs 8 through 11.
    X3 <= (I(8)  AND A AND NB AND NC AND ND) OR
          (I(9)  AND A AND NB AND NC AND D ) OR
          (I(10) AND A AND NB AND C  AND ND) OR
          (I(11) AND A AND NB AND C  AND D );

    -- Block X4: inputs 12 through 15.
    X4 <= (I(12) AND A AND B AND NC AND ND) OR
          (I(13) AND A AND B AND NC AND D ) OR
          (I(14) AND A AND B AND C  AND ND) OR
          (I(15) AND A AND B AND C  AND D );

    -- Final OR gate.
    Y <= X1 OR X2 OR X3 OR X4;
end architecture Gate_Level;
