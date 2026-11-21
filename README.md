# FLinuxTools

A central hub for independent tools and projects maintained by [victormeloasm](https://github.com/victormeloasm).

This repository groups **41 original repositories as Git submodules**, preserving their original URLs, commit histories, issues, and releases. Each submodule points to a specific commit of its source repository.

- **17 detected Linux tools:** see [TOOLS.md](TOOLS.md#detected-linux-tools-17).
- **24 additional candidates:** see [TOOLS.md](TOOLS.md#additional-projects-to-review-24). These were flagged for manual review and are not all guaranteed to be Linux utilities.

## Clone the complete collection

```bash
git clone --recurse-submodules https://github.com/victormeloasm/FLinuxTools.git
```

For an existing clone:

```bash
git submodule update --init --recursive
```

## Updating references

The projects remain independent. When a source project gets new commits, this repository's tracked submodule commit does not automatically change. To update references deliberately:

```bash
git submodule update --remote
git add .gitmodules .
git commit -m "Update submodule references"
git push
```

See [TOOLS.md](TOOLS.md) for the full project index. Project-specific licensing and documentation are maintained within each source repository.
