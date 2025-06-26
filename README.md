# toolwise.nvim
*Smarter tooling. Only when you need it.*

> **Neovim integration for Nix shells, `direnv`, and other project-scoped dev environments.**
> Dynamically attach LSPs, formatters, and tools *only if they exist in your current shell*.
> Ideal for Nix, Flakes, per-project devShells, and anyone tired of checkhealth errors.

## ⚡ At a Glance

✅ **Nix shell aware**  
✅ **direnv-friendly**  
✅ No global pollution  
✅ No “command not found”  
✅ Clean Neovim startup  
✅ Automatic fallbacks (`treefmt`, LSP, etc.)

> *If you use `conform.nvim`, `lspconfig`, or a Nix-based dev workflow — this plugin is for you.*

## ✨ Why?

You’re using Neovim inside a project that has its own shell —  
a **`shell.nix`**, a **flake**, a **`.envrc`** with tools defined.

But your editor doesn’t know what’s available *right now*.

You get this:

```
✗ black not found
✗ rustfmt missing
✗ tsserver unavailable
```

When what you want is:

> *“Use it if it’s there. Ignore it if it’s not.”*

## 🚀 What It Does

- Detects **whether tools are available** (LSPs, formatters, CLI helpers)
- Attaches or configures them **only when present**
- Enables **graceful fallback** to `treefmt`, LSP, or nothing
- Works beautifully with Nix shells, `direnv`, and dev environments

## 🧠 Key Features

✅ One-liner: "only use `black` if it's available"  
✅ Attach `lspconfig` only if binary exists  
✅ Dynamically build formatter lists for `conform.nvim`  
✅ Works with any plugin, any tool — universal runtime check  
✅ Optional logging so you know what's active  
✅ Designed for **real-world setups**, not demo-only configs

## 📦 Install

With `lazy.nvim`:

```lua
{
  "yourname/toolwise.nvim",
  config = true
}
```

With `packer`:

```lua
use { "yourname/toolwise.nvim" }
```

## 💡 Example: Formatters

```lua
local toolwise = require("toolwise")

toolwise.if_has("black", function()
  require("conform").formatters.black = {
    command = "black",
    args = { "--quiet", "-" },
    stdin = true,
  }
end)
```

Or for dynamic resolution:

```lua
require("conform").setup({
  formatters_by_ft = setmetatable({}, {
    __index = function(_, ft)
      return require("toolwise").formatters_for(ft)
    end,
  })
})
```

## 🔍 Example: LSPs

```lua
toolwise.lsp("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
    }
  }
})
```

Only attaches if `rust-analyzer` is executable.

## 🧘 Philosophy

No magic. No assumptions.

Toolwise doesn’t manage plugins, override behavior, or invent abstractions. It just answers one question:

> *“Can I use this tool right now?”*

If yes — it lets you use it.  
If not — it steps aside.

## 📍 Roadmap

- [ ] Statusline hook (`toolwise.active("black")`)
- [ ] DAP support
- [ ] Built-in profiles for known formatters/LSPs
- [ ] Project-based overrides via `.toolwise.lua`
- [ ] Integration with `treefmt.toml` for discovery

## 🔥 Author’s Note

Created out of frustration.  
Maintained out of hope.  
Tested on Nix.  
Runs anywhere.

If you’ve ever opened Neovim and thought  
*“Ugh, I don’t even have that tool in this project…”*,  
**Toolwise** is your friend.
