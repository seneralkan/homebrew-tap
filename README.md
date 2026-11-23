# seneralkan/homebrew-tap

Homebrew tap for [AgentAwake](https://github.com/seneralkan/agent-awake), a macOS menu bar app that keeps
your Mac awake (even with the lid closed) while AI coding agents work.

```bash
brew install --cask seneralkan/tap/agentawake
```

Update with `brew upgrade --cask agentawake`.

`brew uninstall --cask agentawake` removes the Claude Code hooks and the sudoers rule, and restores
normal sleep. Add `--zap` to also delete settings.

## Maintainers: releasing a new version

After a new `vX.Y.Z` release of agent-awake is published:

```bash
./bump.sh X.Y.Z    # downloads the release zip, updates version + sha256 in Casks/agentawake.rb
git commit -am "agentawake X.Y.Z" && git push
```
