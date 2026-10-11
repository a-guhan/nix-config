local M = {}

local config_file = vim.fn.stdpath("config") .. "/db-connections.lua"

local function encode(value)
	return tostring(value):gsub("[^%w%-._~]", function(char)
		return string.format("%%%02X", string.byte(char))
	end)
end

local function load_profiles()
	local ok, data = pcall(dofile, config_file)
	if not ok or type(data) ~= "table" then
		return {}
	end

	return data.profiles or data
end

local function profile_url(profile)
	local user = encode(profile.user)
	local password = profile.password and encode(profile.password) or ""
	local credentials = user
	if password ~= "" then
		credentials = credentials .. ":" .. password
	end

	return string.format(
		"%s://%s@%s:%s/%s",
		profile.type,
		credentials,
		profile.host,
		profile.port,
		encode(profile.database)
	)
end

function M.urls()
	local urls = {}
	for name, profile in pairs(load_profiles()) do
		if type(profile) == "table" then
			urls[name] = profile_url(profile)
		elseif type(profile) == "string" then
			-- Keep existing URL-style files working during the transition.
			urls[name] = profile
		end
	end

	return urls
end

local function input(prompt, default)
	return vim.fn.input(prompt, default or "")
end

function M.add()
	local name = input("Connection name: ")
	if name == "" then
		return
	end

	local db_type = input("Database (postgresql/mysql): ", "postgresql")
	if db_type ~= "postgresql" and db_type ~= "mysql" then
		vim.notify("Database must be postgresql or mysql", vim.log.levels.ERROR)
		return
	end

	local default_port = db_type == "postgresql" and "5432" or "3306"
	local profile = {
		type = db_type,
		host = input("Host: ", "localhost"),
		port = input("Port: ", default_port),
		database = input("Database: "),
		user = input("Username: "),
		password = vim.fn.inputsecret("Password (hidden): "),
	}

	if profile.host == "" or profile.database == "" or profile.user == "" then
		vim.notify("Host, database, and username are required", vim.log.levels.ERROR)
		return
	end

	local profiles = load_profiles()
	profiles[name] = profile
	local json = vim.json.encode(profiles)
	local lines = {
		"-- Local database profiles. Keep this file private.",
		"return vim.json.decode(" .. string.format("%q", json) .. ")",
	}

	vim.fn.writefile(lines, config_file)
	vim.fn.setfperm(config_file, "rw-------")
	vim.g.dbs = M.urls()
	vim.notify("Saved database connection: " .. name)
end

function M.setup()
	vim.g.dbs = M.urls()
	vim.api.nvim_create_user_command("DBAddConnection", M.add, {
		desc = "Add a database connection profile",
	})
end

return M
