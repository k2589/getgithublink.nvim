
local M = {}

local function get_git_remote_url()
    local handle = io.popen('git config --get remote.origin.url')
    if handle == nil then
        return nil
    end
    local result = handle:read("*a")
    handle:close()

    -- Clean up the URL and convert SSH format to HTTPS if needed
    result = result:gsub("^git@github.com:", "https://github.com/")
    result = result:gsub("%.git\n$", "")
    return result
end

local function get_relative_path()
    local handle = io.popen('git rev-parse --show-toplevel')
    if handle == nil then
        return nil
    end
    local git_root = handle:read("*a"):gsub("\n$", "")
    handle:close()

    local current_file = vim.fn.expand('%:p')
    local relative_path = current_file:sub(#git_root + 2)
    return relative_path
end

local function get_current_branch()
    local handle = io.popen('git rev-parse --abbrev-ref HEAD')
    if handle == nil then
        return nil
    end
    local branch = handle:read("*a"):gsub("\n$", "")
    handle:close()
    return branch
end

local function get_current_commit()
    local handle = io.popen('git rev-parse HEAD')
    if handle == nil then
        return nil
    end
    local commit = handle:read("*a"):gsub("\n$", "")
    handle:close()
    return commit
end

function M.get_github_url(use_permalink)
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    local repo_url = get_git_remote_url()
    local relative_path = get_relative_path()
    local ref = use_permalink and get_current_commit() or get_current_branch()

    if not repo_url or not relative_path or not ref then
        print("Error: Could not get repository information")
        return
    end

    local github_url = string.format(
        "%s/blob/%s/%s#L%d-L%d",
        repo_url,
        ref,
        relative_path,
        start_line,
        end_line
    )

    vim.fn.setreg('+', github_url)
    print("GitHub URL copied to clipboard: " .. github_url)
end

function M.setup()
    vim.api.nvim_create_user_command('GetGithubUrl', function()
        M.get_github_url(false)
    end, {
        range = true,
        desc = 'Get GitHub URL for selected lines'
    })

    vim.api.nvim_create_user_command('GetGithubPermalink', function()
        M.get_github_url(true)
    end, {
        range = true,
        desc = 'Get GitHub permalink for selected lines'
    })

end

return M

