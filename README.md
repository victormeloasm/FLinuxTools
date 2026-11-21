# FLinuxTools 🐸

**Linux utilities, tiny executables, developer tools, and security experiments.**

FLinuxTools brings together my projects in systems programming, command-line tooling, file management, and cryptography. Some are built for everyday use; others are experiments in reducing binary size, exploring algorithms, or learning how systems work.

Most projects are written in **C, C++, Assembly (FASM/x86-64), or Python**. Each one is developed in its own repository, with its own documentation and build instructions.

## Linux & command-line tools

| Project | What it does |
| --- | --- |
| [TorFrog](https://github.com/victormeloasm/TorFrog) | Minimal BitTorrent client for the Linux terminal. |
| [frogurl](https://github.com/victormeloasm/frogurl) | Lightweight HTTP/HTTPS command-line client written in C. |
| [frogx](https://github.com/victormeloasm/frogx) | Small terminal-based text editor written in C. |
| [frogkill](https://github.com/victormeloasm/frogkill) | Native Linux process and task manager. |
| [frogclean](https://github.com/victormeloasm/frogclean) | Linux cleanup utility with a GTK4 interface. |
| [frogdb](https://github.com/victormeloasm/frogdb) | SQLite workflows and queries for shell users. |
| [frogpwd](https://github.com/victormeloasm/frogpwd) | Password generator written in FASM for Linux. |
| [ffrog](https://github.com/victormeloasm/ffrog) | USB formatting utility. |
| [nntp](https://github.com/victormeloasm/nntp) | Compact SNTP time synchronization client in x86-64 assembly. |
| [whotf](https://github.com/victormeloasm/whotf) | Tiny x86-64 assembly alternative to the Unix `who` command. |
| [frogpack](https://github.com/victormeloasm/frogpack) | File compression and archiving utility. |
| [defrogwipe](https://github.com/victormeloasm/defrogwipe) | Disk wiping utility. |
| [eXpurg](https://github.com/victormeloasm/eXpurg) | File erasure utility. |

## Desktop & privacy

| Project | What it does |
| --- | --- |
| [cryptofrog](https://github.com/victormeloasm/cryptofrog) | GTK-based file encryption application. |
| [frogglass](https://github.com/victormeloasm/frogglass) | EXIF metadata inspector and cleaner with a PyQt6 interface. |
| [frogpaste](https://github.com/victormeloasm/frogpaste) | Firefox extension for pasting clipboard images into LinkedIn posts. |

## Cryptography & security research

| Project | What it does |
| --- | --- |
| [OpenFrogget](https://github.com/victormeloasm/OpenFrogget) | Hybrid file-encryption tool combining elliptic-curve cryptography and AES-GCM. |
| [froglock](https://github.com/victormeloasm/froglock) | Experimental hybrid encryption project. |
| [FrogBard](https://github.com/victormeloasm/FrogBard) | Experimental 512-bit hash design with AVX2 acceleration. |
| [FrogECCHunter](https://github.com/victormeloasm/FrogECCHunter) | Elliptic-curve auditing and structural analysis toolkit. |
| [HippoFrog](https://github.com/victormeloasm/HippoFrog) | Experimental ECDH and AES-256-GCM on a custom elliptic curve. |
| [HyperFrog](https://github.com/victormeloasm/HyperFrog) | Experimental post-quantum key encapsulation research. |
| [kyfrog](https://github.com/victormeloasm/kyfrog) | Experimental lattice-based key encapsulation project. |
| [randomtoad](https://github.com/victormeloasm/randomtoad) | Linux random-number generation library. |
| [symfrog512](https://github.com/victormeloasm/symfrog512) | Experimental authenticated-encryption scheme. |
| [frog51](https://github.com/victormeloasm/frog51) | DDoS research framework for controlled security testing. |

## Get the projects

Clone the full collection:

```bash
git clone --recurse-submodules https://github.com/victormeloasm/FLinuxTools.git
```

Already cloned it? Fetch the projects with:

```bash
git submodule update --init --recursive
```

Or follow any project link above to clone just the tool you want. For installation, dependencies, and usage, refer to that project's README.

> **Note:** Some cryptographic projects are experimental research implementations, not independently audited production cryptography. Run destructive or security-testing utilities only in environments you control.

---

Created by [Victor Melo](https://github.com/victormeloasm).
