return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"folke/lazydev.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	opts = {
		-- options for vim.diagnostic.config()
		---@type vim.diagnostic.Opts
		diagnostics = {
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "icons",
				-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
				-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
				-- prefix = "icons",
			},
			severity_sort = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		},
		-- Enable lsp cursor word highlighting
		document_highlight = {
			enabled = true,
		},
	},
	config = function(_, opts)
		-- diagnostics signs
		if vim.fn.has("nvim-0.10.0") == 0 then
			if type(opts.diagnostics.signs) ~= "boolean" then
				for severity, icon in pairs(opts.diagnostics.signs.text) do
					local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
					name = "DiagnosticSign" .. name
					vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
				end
			end
		end

		if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
			opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
				or function(diagnostic)
					local icons = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
					for d, icon in pairs(icons) do
						if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
							return icon
						end
					end
				end
		end

		vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["svelte"] = function()
				-- configure svelte server
				lspconfig["svelte"].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								-- Here use ctx.match instead of ctx.file
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end,
				})
			end,
			["graphql"] = function()
				-- configure graphql language server
				lspconfig["graphql"].setup({
					capabilities = capabilities,
					filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
				})
			end,
			["html"] = function()
				lspconfig["html"].setup({
					capabilities = capabilities,
					filetypes = { "html", "templ", "php" },
				})
			end,
			["emmet_ls"] = function()
				-- configure emmet language server
				lspconfig["emmet_ls"].setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
					init_options = {
						html = {
							options = {
								-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
								["bem.enabled"] = true,
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
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})
	end,
}
