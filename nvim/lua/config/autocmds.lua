-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function cs_foldtext()
  local start = vim.v.foldstart
  local line = vim.fn.getline(start):gsub("^%s*", "")

  -- 1. Real regions win
  local region = line:match("#region%s*(.+)")
  if region then
    return "#region " .. region
  end

  -- 2. XML summary acts like a region
  if line:match("///%s*<summary>") then
    for i = start + 1, math.min(start + 6, vim.v.foldend) do
      local l = vim.fn.getline(i)
      local text = l:match("///%s*(.+)")
      if text and not text:match("</summary>") then
        return text
      end
    end
  end

  -- 3. Fallback
  return line
end

--vim.api.nvim_create_autocmd("FileType", {
--  pattern = "cs",
--  callback = function()
--    vim.opt_local.foldmethod = "marker"
--    vim.opt_local.foldmarker = "#region,#endregion"
--    vim.opt_local.foldtext = "v:lua.cs_foldtext()"
--    vim.opt_local.foldlevel = 0
--  end,
--})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cs',
  callback = function(args)
    local root_dir = vim.fs.dirname(
      vim.fs.find({ '.sln', '.slnx', '.csproj', '.git' }, { upward = true })[1]
    )
    vim.lsp.start({
      name = 'csharp-language-server',
      cmd = { '/home/somethingfishy/.cargo/bin/csharp-language-server' },
      root_dir = root_dir,
    })
  end,
})
