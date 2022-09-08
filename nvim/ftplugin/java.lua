local Remap = require("uwu.keymaps")
local nnoremap = Remap.nnoremap
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local javaBundles = {
    vim.fn.glob("/home/ivan/.local/share/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.39.0.jar"),
};
vim.list_extend(javaBundles, vim.split(vim.fn.glob("/home/ivan/.local/share/vscode-java-test/server/*.jar"), "\n"))
local javaConfig = {
    cmd = {
        '/usr/lib/jvm/java-17-openjdk/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', '/home/ivan/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration', '/home/ivan/.local/share/jdtls/config_linux',
        '-data', '/home/ivan/.local/share/eclipse-project-data/' .. project_name
    },
    on_attach = function(client, buffer)
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })
        require("jdtls.dap").setup_dap_main_class_configs()
    end,

    settings = {
        java = {
        }
    },
    init_options = {
        bundles = javaBundles
    }
}
require('jdtls').start_or_attach(javaConfig)
nnoremap('<leader>tc', function() require 'jdtls'.test_class() end)
nnoremap('<leader>tm', function() require 'jdtls'.test_nearest_method() end)
