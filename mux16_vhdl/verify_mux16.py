#!/usr/bin/env python3
"""Verify the DUT's explicit Boolean equations over every binary input."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent
DUT = (ROOT / "mux16.vhd").read_text(encoding="utf-8")
TB = (ROOT / "tb_mux16.vhd").read_text(encoding="utf-8")


def require(condition, message):
    if not condition:
        raise AssertionError(message)


def assignments(source):
    source = re.sub(r"--[^\n]*", "", source)
    return dict(re.findall(r"\b(\w+)\s*<=\s*(.*?);", source, re.S))


expr = assignments(DUT)
terms = []
for block in range(1, 5):
    parts = []
    for raw in expr[f"X{block}"].split("OR"):
        m = re.fullmatch(r"\s*\(\s*I\((\d+)\)\s+AND\s+(N?A)\s+AND\s+(N?B)\s+AND\s+(N?C)\s+AND\s+(N?D)\s*\)\s*", raw)
        require(m is not None, f"Invalid term: {raw}")
        parts.append((int(m[1]), tuple(m.groups()[1:])))
    terms.append(parts)

# Review 1: structural correctness and minterm mapping.
for line in "ABCD":
    require(expr["N" + line].split() == ["NOT", line], "Invalid NOT gate")
require(expr["Y"].split() == "X1 OR X2 OR X3 OR X4".split(), "Invalid final OR")
for block, parts in enumerate(terms):
    require([n for n, _ in parts] == list(range(4 * block, 4 * block + 4)), "Invalid block membership")
    for n, literals in parts:
        expected = tuple(c if b == "1" else "N" + c for c, b in zip("ABCD", f"{n:04b}"))
        require(literals == expected, f"Wrong minterm for I({n})")
print("Review 1 PASS: 16 minterms, four blocks, NOT gates, final OR.")

# Review 2: exhaustively evaluate the extracted gates using bit-parallel truth tables.
# Bit k of a mask corresponds to the data vector whose integer value is k.
patterns = 1 << 16
ones = (1 << patterns) - 1
inputs = []
for bit in range(16):
    run = 1 << bit
    # Repeating run of zero bits followed by a run of one bits.
    mask = ones // ((1 << run) + 1) * (1 << run)
    inputs.append(mask)


def evaluate(data, selector, universe):
    values = {c: universe if b == "1" else 0 for c, b in zip("ABCD", f"{selector:04b}")}
    for c in "ABCD":
        values["N" + c] = universe ^ values[c]
    outputs = []
    for parts in terms:
        out = 0
        for n, literals in parts:
            term = data[n]
            for literal in literals:
                term &= values[literal]
            out |= term
        outputs.append(out)
    x1, x2, x3, x4 = outputs
    return outputs, x1 | x2 | x3 | x4


for selector in range(16):
    _, output = evaluate(inputs, selector, ones)
    require(output == inputs[selector], f"Truth-table mismatch at selector {selector}")
print(f"Review 2 PASS: {patterns * 16:,} binary input/selector combinations.")

# Review 3: cross-check the original exercise and testbench configuration.
original = [1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0]
vector = "".join(map(str, reversed(original)))
m = re.search(r'constant\s+EXAMPLE_INPUTS\s*:\s*STD_LOGIC_VECTOR\(15 downto 0\)\s*:=\s*"([01]{16})"', TB, re.I)
require(m is not None and m[1] == vector, "Example vector mismatch")
for line, index in zip("ABCD", (3, 2, 1, 0)):
    require(re.search(rf"\b{line}\s*=>\s*S\({index}\)", TB) is not None, "Selector mapping mismatch")
require('S <= "1010";' in TB, "Missing original selector")
require(evaluate(original, 10, 1) == ([0, 0, 1, 0], 1), "Original example mismatch")
require(re.search(r"for\s+PATTERN\s+in\s+0\s+to\s+65535\s+loop", TB, re.I) is not None, "Missing exhaustive data sweep")
require(len(re.findall(r"for\s+N\s+in\s+0\s+to\s+15\s+loop", TB, re.I)) == 2, "Missing selector sweeps")
require(len(re.findall(r"assert\s+Y\s*=\s*I\(N\)", TB, re.I)) == 2, "Missing reference checks")
print(f"Review 3 PASS: I={vector}, ABCD=1010, X=(0,0,1,0), Y=1; testbench configuration checked.")
