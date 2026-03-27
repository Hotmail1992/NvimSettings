------------------------------------------
--- ОБЩИЕ НАСТРОЙКИ
------------------------------------------
local opt = vim.opt

	opt.number = true
	opt.tabstop = 2
	opt.shiftwidth = 2
	opt.softtabstop = 2
	opt.smarttab = true
	opt.encoding = 'utf-8'
	opt.fileencoding = 'utf-8'
	opt.modifiable = true
	opt.autochdir = true
	opt.syntax = on

-- Рекомендуемые настройки оболочки для Windows
if vim.fn.has("win32") == 1 then
    opt.shell = "pwsh"
    opt.shellcmdflag = "-NoLogo -Binary -NoProfile -ExecutionPolicy RemoteSigned -Command"
    opt.shellquote = ""
    opt.shellxquote = ""
end
