local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not vim.loop.fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

pckr = require('pckr')
pckr_util = require('pckr.util')
pckr_keys = require('pckr.loader.keys')
pckr_event = require('pckr.loader.event')
pckr.setup{
  package_root        = pckr_util.join_paths(vim.fn.stdpath('data'), 'site', 'pack'),
  max_jobs            = nil, -- Limit the number of simultaneous jobs. nil means no limit
  autoremove          = false, -- Remove unused plugins
  autoinstall         = true, -- Auto install plugins
  git = {
    cmd = 'git', -- The base command for git operations
    depth = 1, -- Git clone depth
    clone_timeout = 60, -- Timeout, in seconds, for git clones
    default_url_format = 'https://github.com/%s' -- Lua format string used for "aaa/bbb" style plugins
  },
  log = { level = 'warn' }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal".
  opt_dir = ...,
  start_dir = ...,
  lockfile = {
    path = pckr_util.join_paths(vim.fn.stdpath('data'), 'site', 'lockfile.lua')
  }
}
