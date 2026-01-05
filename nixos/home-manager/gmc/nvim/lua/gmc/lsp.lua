-- Install Language Servers
-- Credit to Josean Martinez "How to Setup Neovim LSP Like a Pro in 2025 (v0.11+)
--
-- To override settings, create a file with the same name plus ".lua" in `.config/nvim/after/lua/`
--
vim.lsp.enable("ansiblels");
-- vim.lsp.enable("asm_lsp");
vim.lsp.enable("bashls");
vim.lsp.enable("cmake");
vim.lsp.enable("cspell_ls");
vim.lsp.enable("cssls");
vim.lsp.enable("dockerls");
vim.lsp.enable("gh_actions_ls");
vim.lsp.enable("gopls");
vim.lsp.enable("graphql");
vim.lsp.enable("helm_ls");
-- vim.lsp.enable("hls");  -- Haskell language server; broken on NixOS
vim.lsp.enable("html");
vim.lsp.enable("jinja_lsp");
vim.lsp.enable("jsonls");
vim.lsp.enable("lua_ls");   -- anything in .config/nvim/lsp/lua_ls overrides the community
vim.lsp.enable("marksman");
vim.lsp.enable("nginx_language_server");
vim.lsp.enable("postgres_lsp");
vim.lsp.enable("pyright");
vim.lsp.enable("rust_analyzer");
vim.lsp.enable("systemd_lsp");
vim.lsp.enable("terraformls");
vim.lsp.enable("yamlls");

