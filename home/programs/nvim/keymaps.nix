{
  programs.nixvim.keymaps = [
    # Window navigation
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options.desc = "Go to left window";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options.desc = "Go to lower window";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options.desc = "Go to upper window";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options.desc = "Go to right window";
    }

    # Save & quit
    {
      mode = "n";
      key = "<leader>w";
      action = "<cmd>w<cr>";
      options.desc = "Save";
    }
    {
      mode = "n";
      key = "<leader>wa";
      action = "<cmd>wa<cr>";
      options.desc = "Save all";
    }
    {
      mode = "n";
      key = "<leader>qq";
      action = "<cmd>q<cr>";
      options.desc = "Quit";
    }

    # Diagnostics
    {
      mode = "n";
      key = "<leader>e";
      action.__raw = "vim.diagnostic.open_float";
      options.desc = "Show diagnostics";
    }
    {
      mode = "n";
      key = "[d";
      action.__raw = "vim.diagnostic.goto_prev";
      options.desc = "Previous diagnostic";
    }
    {
      mode = "n";
      key = "]d";
      action.__raw = "vim.diagnostic.goto_next";
      options.desc = "Next diagnostic";
    }
    {
      mode = "n";
      key = "<leader>dl";
      action.__raw = "vim.diagnostic.setloclist";
      options.desc = "Diagnostics list";
    }

    # Telescope
    {
      mode = "n";
      key = "<leader>f";
      action = "<cmd>Telescope find_files<cr>";
      options.desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>g";
      action = "<cmd>Telescope live_grep<cr>";
      options.desc = "Live grep";
    }
    {
      mode = "n";
      key = "<leader>b";
      action = "<cmd>Telescope buffers<cr>";
      options.desc = "Buffers";
    }

    # NvimTree
    {
      mode = "n";
      key = "<C-n>";
      action = "<cmd>NvimTreeToggle<cr>";
      options.desc = "Toggle file tree";
    }
    {
      mode = "n";
      key = "<leader>nf";
      action = "<cmd>NvimTreeFindFile<cr>";
      options.desc = "Find file in tree";
    }
    {
      mode = "n";
      key = "<leader>nr";
      action = "<cmd>NvimTreeRefresh<cr>";
      options.desc = "Refresh tree";
    }
    {
      mode = "n";
      key = "<leader>nt";
      action = "<cmd>NvimTreeFocus<cr>";
      options.desc = "Focus tree";
    }

    # Toggle relative numbers
    {
      mode = "n";
      key = "<leader>tn";
      action.__raw = "function() vim.opt.relativenumber = not vim.opt.relativenumber:get() end";
      options.desc = "Toggle relative numbers";
    }
  ];
}
