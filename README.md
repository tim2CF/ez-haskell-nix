# ez-haskell-nix

<p align="center">
  <strong>Easy Haskell projects bootstrap</strong>
  <br>
  <img src="logo.png" alt="logo" width="500"/>
  <br>
  <strong>Powered by Docker and Nix</strong>
</p>

# Features

- Pure and declarative environments

- Auto-generated CI scripts

- Automated builds of thin Docker images

- Ultimate Haskell IDE

  - Syntax highlighting

  - Auto-complete

  - Auto-format

  - Auto-refactoring

  - Jump to definition

  - Compiler suggestions

  - Embedded Hoogle docs

# Prerequisites

- Docker

- Nix (optional)

# Installation

### Without Nix

```bash
git clone https://github.com/tim2CF/ez-haskell-nix.git

echo "export PATH=$(pwd)/ez-haskell-nix/:\$PATH" >> ~/.zshrc
```

### With Nix

```bash
nix-env -i -f https://github.com/tim2CF/ez-haskell-nix/archive/master.tar.gz
```
