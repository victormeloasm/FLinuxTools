# 16-to-1 Multiplexer in VHDL

An educational, synthesizable implementation of a 16-to-1 multiplexer using explicit Boolean AND, OR and NOT operations. The sum-of-products expression is divided into four intermediate blocks (`X1`–`X4`), followed by a final OR operation. No clock, reset, lookup table or direct indexing is used in the DUT.

## Interface and example

- `I(15 downto 0)`: sixteen single-bit data inputs.
- `A`, `B`, `C`, `D`: select lines, from most significant to least significant bit.
- `Y`: selected single-bit output.

```text
I0  = 1    I4 = 0    I8  = 1    I12 = 0
I1  = 0    I5 = 1    I9  = 0    I13 = 1
I2  = 1    I6 = 0    I10 = 1    I14 = 1
I3  = 1    I7 = 1    I11 = 0    I15 = 0

A = 1, B = 0, C = 1, D = 0

I(0..3)   --> [X1] -- 0 --+
I(4..7)   --> [X2] -- 0 --+
                           +--> [OR] --> Y = 1
I(8..11)  --> [X3] -- 1 --+
I(12..15) --> [X4] -- 0 --+
```

All four blocks receive the same select lines. With `ABCD = 1010`, the selected index is 10, so `Y = I(10) = 1`. The VHDL input vector is `0110010110101101`, written from `I(15)` to `I(0)`.

The final equation is `Y = X1 OR X2 OR X3 OR X4`. Each block ORs four five-input AND terms; each term contains one data input and a unique selector minterm. The direct Boolean representation uses four NOT operations, sixteen five-input AND terms, four four-input OR terms and one final four-input OR term. Synthesis tools may optimize this network into a different physical implementation.

## Files

- `mux16.vhd`: combinational multiplexer.
- `tb_mux16.vhd`: self-checking VHDL testbench.
- `verify_mux16.py`: independent binary truth-table verification of the actual Boolean expressions extracted from `mux16.vhd` (Python 3 standard library only).

## Run with GHDL

On Debian/Ubuntu, install `ghdl` and optionally `gtkwave`. From this directory:

```sh
ghdl -a --std=08 mux16.vhd tb_mux16.vhd
ghdl -e --std=08 TB_MUX16
ghdl -r --std=08 TB_MUX16 --assert-level=error
```

The default testbench checks the original exercise, all 16 selectors for the original data pattern, and all 1,048,576 possible binary data/selector combinations. Expected total: 1,048,593 assertions/checks. No VCD is produced by default to avoid a large trace.

For a short waveform containing the original exercise and the 16-selector sweep:

```sh
ghdl -r --std=08 TB_MUX16 -gEXHAUSTIVE=false --assert-level=error --vcd=mux16.vcd
gtkwave mux16.vcd
```

Expected short-run total: 17 checks. The 10 ns waits in the testbench allow combinational signals to settle; they are not physical delays in the DUT.

## Independent verification

```sh
python3 verify_mux16.py
```

The Python verifier checks selector minterms, block membership, input-vector encoding and all 1,048,576 binary combinations against an independent indexing reference. It also validates the four intermediate outputs for the example. This does not replace compiling, simulating or synthesizing the VHDL; non-binary `STD_LOGIC` states are outside the binary truth-table test.

**Validation status:** all three independent review checks in `verify_mux16.py` passed during preparation. GHDL was not available in the preparation environment, and installation was blocked by unavailable DNS/network access; the supplied VHDL testbench has not been run there.
