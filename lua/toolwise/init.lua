local M = {}

local function has(bin)
    return vim.fn.executable(bin) == 1
end

M.setup = function(opts)
    M.log = opts and opts.log or false
end

M.if_has = function(bin, on_yes, on_no)
    if has(bin) then
        if M.log then vim.notify("toolwise: found " .. bin) end
        if on_yes then on_yes() end
    else
        if on_no then on_no() end
    end
end

return M
