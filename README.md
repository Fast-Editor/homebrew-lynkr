# Homebrew Tap for Lynkr

Homebrew formula for [Lynkr](https://github.com/Fast-Editor/Lynkr) — a self-hosted LLM gateway and tier-routing proxy for Claude Code, Cursor, and Codex.

## Install

```bash
brew tap fast-editor/lynkr
brew install lynkr
lynkr --version
```

## Upgrade

```bash
brew update
brew upgrade lynkr
```

The formula installs the published [`lynkr` npm package](https://www.npmjs.com/package/lynkr) and links the `lynkr` CLI into your Homebrew prefix.
