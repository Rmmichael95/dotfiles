return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"folke/lazydev.nvim",
		"nvimdev/lspsaga.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},

	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")
		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local saga = require("lspsaga")

		saga.setup({
			ui = {
				winblend = 0,
				border = "rounded",
				colors = {
					--normal_bg = "#002b36",
				},
			},
		})

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Toggle Diagnostic"
				keymap.set("n", "<leader>D", function()
					vim.diagnostic.enable(not vim.diagnostic.is_enabled())
				end, opts) -- mapping to toggle lsp diagnostic

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>sD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				-- keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
				keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["intelephense"] = function()
				lspconfig["intelephense"].setup({
					capabilities = capabilities,
					settings = {
						intelephense = {
							stubs = {
								"amqp",
								"apache",
								"apcu",
								"bcmath",
								"blackfire",
								"bz2",
								"calendar",
								"cassandra",
								"com_dotnet",
								"Core",
								"couchbase",
								"crypto",
								"ctype",
								"cubrid",
								"curl",
								"date",
								"dba",
								"decimal",
								"dom",
								"ds",
								"enchant",
								"Ev",
								"event",
								"exif",
								"fann",
								"FFI",
								"ffmpeg",
								"fileinfo",
								"filter",
								"fpm",
								"ftp",
								"gd",
								"gearman",
								"geoip",
								"geos",
								"gettext",
								"gmagick",
								"gmp",
								"gnupg",
								"grpc",
								"hash",
								"http",
								"ibm_db2",
								"iconv",
								"igbinary",
								"imagick",
								"imap",
								"inotify",
								"interbase",
								"intl",
								"json",
								"judy",
								"ldap",
								"leveldb",
								"libevent",
								"libsodium",
								"libxml",
								"lua",
								"lzf",
								"mailparse",
								"mapscript",
								"mbstring",
								"mcrypt",
								"memcache",
								"memcached",
								"meminfo",
								"meta",
								"ming",
								"mongo",
								"mongodb",
								"mosquitto-php",
								"mqseries",
								"msgpack",
								"mssql",
								"mysql",
								"mysql_xdevapi",
								"mysqli",
								"ncurses",
								"newrelic",
								"oauth",
								"oci8",
								"odbc",
								"openssl",
								"parallel",
								"Parle",
								"pcntl",
								"pcov",
								"pcre",
								"pdflib",
								"PDO",
								"pdo_ibm",
								"pdo_mysql",
								"pdo_pgsql",
								"pdo_sqlite",
								"pgsql",
								"Phar",
								"phpdbg",
								"posix",
								"pspell",
								"pthreads",
								"radius",
								"rar",
								"rdkafka",
								"readline",
								"recode",
								"redis",
								"Reflection",
								"regex",
								"rpminfo",
								"rrd",
								"SaxonC",
								"session",
								"shmop",
								"SimpleXML",
								"snmp",
								"soap",
								"sockets",
								"sodium",
								"solr",
								"SPL",
								"SplType",
								"SQLite",
								"sqlite3",
								"sqlsrv",
								"ssh2",
								"standard",
								"stats",
								"stomp",
								"suhosin",
								"superglobals",
								"svn",
								"sybase",
								"sync",
								"sysvmsg",
								"sysvsem",
								"sysvshm",
								"tidy",
								"tokenizer",
								"uopz",
								"uv",
								"v8js",
								"wddx",
								"win32service",
								"winbinder",
								"wincache",
								"xcache",
								"xdebug",
								"xhprof",
								"xml",
								"xmlreader",
								"xmlrpc",
								"xmlwriter",
								"xsl",
								"xxtea",
								"yaf",
								"yaml",
								"yar",
								"zend",
								"Zend OPcache",
								"ZendCache",
								"ZendDebugger",
								"ZendUtils",
								"zip",
								"zlib",
								"zmq",
								"zookeeper",
								"wordpress",
								"woocommerce",
								"acf-pro",
								"wordpress-globals",
								"wp-cli",
								"genesis",
								"polylang",
							},
							environment = {
								includePaths = {
									"/home/ryanm/.config/composer/vendor/php-stubs/",
									"/home/ryanm/.config/composer/vendor/wpsyntex/",
								}, -- this line forces the composer path for the stubs in case inteliphense can't find it...
								-- root_dir = vim.loop.cwd,
							},
							files = {
								maxSize = 5000000,
							},
						},
					},
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}
