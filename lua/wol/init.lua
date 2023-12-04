local Popup = require('nui.popup')
local event = require('nui.utils.autocmd').event

local M = {}

local function lines(str)
  local result = {}
  for line in str:gmatch '[^\n]+' do
    table.insert(result, line)
  end
  return result
end

M.search_bible = function (ref)
    local buf_lines = lines(vim.fn.system({
        'wol',
        'bible',
        ref
    }))

    local popup = Popup({
        enter = true,
        focusable = true,
        border = {
            style = 'rounded',
        },
        position = "50%",
        relative = "editor",
        size = {
            width = "80",
            height = "60%"
        },
    })

    popup:mount()

    popup:on(event.BufLeave, function ()
        popup:unmount()
    end)

    vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, buf_lines)
end

return M
