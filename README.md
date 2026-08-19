# homebrew-tap

Homebrew formulae for [takakix2](https://github.com/takakix2)'s tools.

```sh
brew install takakix2/tap/cozy
```

The `homebrew-` prefix is dropped by Homebrew, so `takakix2/tap` is this repository.

## What is here

| Formula | Project |
|---|---|
| `cozy` | [cozy](https://github.com/takakix2/cozy) — a Comfort First terminal text editor: type like nano, navigate like vim |

## Do not edit `Formula/` by hand

Every file under `Formula/` is **generated and pushed by CI**. Each project builds its
release binaries with [`dist`](https://github.com/axodotdev/cargo-dist), which emits the
formula pointing at that release's assets and commits it here. A hand-edit survives only
until the next release, and a hand-maintained SHA-256 per platform per release is exactly
the ledger this setup exists to avoid.

To change what a formula says, change the source project's `dist-workspace.toml` and cut
a release there.
