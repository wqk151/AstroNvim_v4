-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
local progress = require "fidget.progress"

local M = {}

function M:init()
  local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestStarted",
    group = group,
    callback = function(request)
      local handle = M:create_progress_handle(request)
      M:store_progress_handle(request.data.id, handle)
    end,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestFinished",
    group = group,
    callback = function(request)
      local handle = M:pop_progress_handle(request.data.id)
      if handle then
        M:report_exit_status(handle, request)
        handle:finish()
      end
    end,
  })
end

M.handles = {}

function M:store_progress_handle(id, handle) M.handles[id] = handle end

function M:pop_progress_handle(id)
  local handle = M.handles[id]
  M.handles[id] = nil
  return handle
end

function M:create_progress_handle(request)
  local adapter_info = request.data.adapter
  local interaction = request.data.interaction or "request"
  local title = " CodeCompanion"
  if adapter_info then title = " " .. M:llm_role_title(adapter_info) end
  return progress.handle.create {
    title = title,
    message = interaction:sub(1, 1):upper() .. interaction:sub(2) .. " in progress...",
    lsp_client = {
      name = adapter_info and M:llm_role_title(adapter_info) or "CodeCompanion",
    },
  }
end

function M:llm_role_title(adapter)
  local parts = {}
  table.insert(parts, adapter.formatted_name)
  if adapter.model and adapter.model ~= "" then table.insert(parts, "(" .. adapter.model .. ")") end
  return table.concat(parts, " ")
end

function M:report_exit_status(handle, request)
  local status = request.data.status
  if status == "success" then
    handle.message = "Completed"
  elseif status == "error" then
    handle.message = " Error"
  else
    handle.message = "Done"
  end
end

---Register the module so require("plugins.fidget-spinner") returns M,
---while the file also returns a valid lazy.nvim plugin spec.
package.loaded["plugins.fidget-spinner"] = M

return {
  "j-hui/fidget.nvim",
  lazy = true,
}
