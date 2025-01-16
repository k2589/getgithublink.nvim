# GetGithubLink.nvim

A Neovim plugin that generates GitHub URLs for your code, supporting both branch-based links and permalinks. Perfect for sharing code references with your team!

## Features

- Generate GitHub URLs for selected code
- Support for both branch-based URLs and permalinks (commit-based)
- Automatic clipboard copying
- Supports both SSH and HTTPS git remote URLs
- Visual mode commands

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "k2589/getgithublink.nvim",
    config = function()
      require("getgithublink").setup()
    end,
}
```

## Usage

The plugin provides two main commands:

- `:GetGithubUrl` - Generate a branch-based URL for the selected lines
- `:GetGithubPermalink` - Generate a permanent (commit-based) URL for the selected lines

### Examples

Branch-based URL:
```
https://github.com/username/repo/blob/main/file.txt#L1-L5
```

Permalink:
```
https://github.com/username/repo/blob/a1b2c3d4e5f6g7h8i9j0/file.txt#L1-L5
```

## Configuration

The plugin works out of the box with default settings.

```lua
require("github-url").setup({
    -- Coming soon: customization options
})
```

## Requirements

- Git installed and accessible in PATH
- Repository must have a GitHub remote

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

Distributed under the MIT License. See `LICENSE` file for more information.

## Acknowledgments

- Inspired by the need to easily share GitHub links during code reviews
- Thanks to the Neovim community for the amazing plugin ecosystem
