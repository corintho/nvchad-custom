local present, glance = pcall(require, "glance")

if not present then
  return
end

local configs = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"
local servers = lspconfig.util.available_servers()
local my_attach = function(client, bufnr)
  configs.on_attach(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end
  vim.keymap.set("n", "gr", "<cmd>Glance references<cr>", opts "󰘐 References")
end

vim.schedule(function()
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = my_attach,
    }
  end
end)

local filter = function(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local filterReactDTS = function(value)
  if value.uri then
    return string.match(value.uri, "%.d.ts") == nil
  elseif value.targetUri then
    return string.match(value.targetUri, "%.d.ts") == nil
  end
end

glance.setup {
  border = {
    enable = true,
    top_char = "",
    bottom_char = "",
  },
  hooks = {
    before_open = function(results, open, jump, method)
      if #results == 1 then
        jump(results[1])
      elseif method == "definitions" then
        results = filter(results, filterReactDTS)
        open(results)
      else
        open(results)
      end
    end,
  },
}
