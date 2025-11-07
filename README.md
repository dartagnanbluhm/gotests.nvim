# gotests.nvim

This is a Neovim plugin for gotests.

## Required

- [gotests](https://github.com/cweill/gotests)

## Installation

This plugin requires **gotests** to be available in your `$PATH`. You can optionally specify the path to the **gotests** binary and a template directory via the setup options.

### Using lazy.nvim

```lua
{
  "dartagnanbluhm/gotests.nvim",
  ft = "go",
  config = function()
    require("gotests").setup({
      -- Optional: path to gotests binary (default: "gotests")
      gotests_bin = "gotests",
      -- Optional: path to custom template directory (default: "")
      gotests_template_dir = "",
      -- Optional: disable default key mappings (default: false)
      enable_mappings = true,
    })
  end,
},
```

## Usage

Command|Description
--|--
`:GoTests`| generate tests for functions at the current line or functions selected in visual mode.
`:GoTestsAll`| generate tests for all functions and methods

## Mappings

This plugin provides the following default key mappings only when `enable_mappings` is set to `true`:

- `<leader>gt` - Generate tests for the function at the current line or selected functions in visual mode.
- `<leader>gT` - Generate tests for all functions and methods in the current file.

You can customize these mappings in your Neovim configuration if desired.

