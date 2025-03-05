local Remap = require("uwu.keymaps")
local nnoremap = Remap.nnoremap
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local navic = require("nvim-navic")
local javaBundles = {
	vim.fn.glob(
		os.getenv("HOME")
			.. "/.local/share/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.43.0.jar"
	),
}
vim.list_extend(
	javaBundles,
	vim.split(vim.fn.glob(os.getenv("HOME") .. "/.local/share/vscode-java-test/server/*.jar"), "\n")
)
local javaConfig = {
	cmd = {
		"/usr/lib/jvm/java-17-openjdk/bin/java",
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
			configuration = {
				runtimes = {
					{
						name = "JavaSE-1.8",
						path = "/usr/lib/jvm/jdk8u282-b08",
					},
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
