local Remap = require("uwu.keymaps")
local nnoremap = Remap.nnoremap
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local navic = require("nvim-navic")
local javaBundles = {
  vim.fn.glob(
    os.getenv("HOME")
      .. "/.local/share/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.1.jar"
  ),
}
vim.list_extend(
  javaBundles,
  vim.split(vim.fn.glob(os.getenv("HOME") .. "/.local/share/vscode-java-test/server/*.jar"), "\n")
)
local javaConfig = {
  cmd = {
    "/usr/lib/jvm/java-21-openjdk/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    os.getenv("HOME") .. "/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    "-configuration",
    os.getenv("HOME") .. "/.local/share/jdtls/config_linux",
    "-data",
    os.getenv("HOME") .. "/.local/share/eclipse-project-data/" .. project_name,
  },
  on_attach = function(client, buffer)
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, buffer)
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
  end,
  settings = {
    java = {
      -- enum ExecutionEnvironment {
      --         J2SE_1_5 = 'J2SE-1.5',
      --         JavaSE_1_6 = 'JavaSE-1.6',
      --         JavaSE_1_7 = 'JavaSE-1.7',
      --         JavaSE_1_8 = 'JavaSE-1.8',
      --         JavaSE_9 = 'JavaSE-9',
      --         JavaSE_10 = 'JavaSE-10',
      --         JavaSE_11 = 'JavaSE-11',
      --         JavaSE_12 = 'JavaSE-12',
      --         JavaSE_13 = 'JavaSE-13',
      --         JavaSE_14 = 'JavaSE-14',
      --         JavaSE_15 = 'JavaSE-15',
      --         JavaSE_16 = 'JavaSE-16',
      --         JavaSE_17 = 'JavaSE-17',
      --         JavaSE_18 = 'JavaSE-18',
      --         JAVASE_19 = 'JavaSE-19',
      --         JAVASE_20 = 'JavaSE-20',
      --         JAVASE_21 = 'JavaSE-21',
      --         JAVASE_22 = 'JavaSE-22'
      -- }
      configuration = {
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = "/usr/lib/jvm/java-8-openjdk",
          },
          {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/java-11-openjdk",
          },
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk",
          },
          -- {
          --   name = "JavaSE-21",
          --   path = "/usr/lib/jvm/java-21-openjdk",
          -- },
        },
      },
    },
  },
  init_options = {
    bundles = javaBundles,
  },
}
require("jdtls").start_or_attach(javaConfig)
nnoremap("<leader>tc", function()
  require("jdtls").test_class()
end)
nnoremap("<leader>o", function()
  require("jdtls").organize_imports()
end)
nnoremap("<leader>tm", function()
  require("jdtls").test_nearest_method()
end)
