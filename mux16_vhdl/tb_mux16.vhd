library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_MUX16 is
    generic (
        EXHAUSTIVE : BOOLEAN := TRUE
    );
end entity TB_MUX16;

architecture Simulation of TB_MUX16 is
    -- Vector order: I(15) ... I(0).
    constant EXAMPLE_INPUTS : STD_LOGIC_VECTOR(15 downto 0)
        := "0110010110101101";
    signal I : STD_LOGIC_VECTOR(15 downto 0) := EXAMPLE_INPUTS;
    signal S : STD_LOGIC_VECTOR(3 downto 0) := "1010";
    signal Y : STD_LOGIC;
begin
    DUT : entity work.MUX16(Gate_Level)
        port map (
            I => I,
            A => S(3),
            B => S(2),
            C => S(1),
            D => S(0),
            Y => Y
        );

    stimulus : process
        variable checks : NATURAL := 0;
    begin
        -- Reproduce the original exercise.
        I <= EXAMPLE_INPUTS;
        S <= "1010";
        wait for 10 ns;
        assert Y = '1'
            report "Original exercise failed: expected Y = 1"
            severity failure;
        checks := checks + 1;

        -- Check all 16 selector values for the original input pattern.
        for N in 0 to 15 loop
            S <= STD_LOGIC_VECTOR(TO_UNSIGNED(N, 4));
            wait for 10 ns;
            assert Y = I(N)
                report "Example failed at selector " & INTEGER'IMAGE(N)
                severity failure;
            checks := checks + 1;
        end loop;

        -- Optional exhaustive binary test: 2^16 data patterns x 2^4 selectors.
        if EXHAUSTIVE then
            for PATTERN in 0 to 65535 loop
                I <= STD_LOGIC_VECTOR(TO_UNSIGNED(PATTERN, 16));
                for N in 0 to 15 loop
                    S <= STD_LOGIC_VECTOR(TO_UNSIGNED(N, 4));
                    wait for 10 ns;
                    assert Y = I(N)
                        report "Exhaustive test failed: data=" &
                               INTEGER'IMAGE(PATTERN) & ", selector=" &
                               INTEGER'IMAGE(N)
                        severity failure;
                    checks := checks + 1;
                end loop;
            end loop;
        end if;

        report "PASS: " & INTEGER'IMAGE(checks) & " checks completed."
            severity note;
        wait;
    end process stimulus;
end architecture Simulation;
