-- Metronome Configuration File
--
-- Information on configuring Metronome can be found on our
-- website at http://prosody.im/doc/configure
--
-- Tip: You can check that the syntax of this file is correct
-- when you have finished by running: luac -p prosody.cfg.lua
-- If there are any errors, it will let you know what and where
-- they are, otherwise it will keep quiet.
--
-- The only thing left to do is rename this file to remove the .dist ending, and fill in the
-- blanks. Good luck, and happy Jabbering!


---------- Server-wide settings ----------
-- Settings in this section apply to the whole server and are the default settings
-- for any virtual hosts

-- This is a (by default, empty) list of accounts that are admins
-- for the server. Note that you must create the accounts separately
-- (see http://prosody.im/doc/creating_accounts for info)
admins = { "valerian@jappix.com", "julien@jappix.com" }

-- Server PID
pidfile = "/var/run/metronome/metronome.pid"

-- ulimit
metronome_max_files_soft = 200000
metronome_max_files_hard = 200000

-- HTTP ports
http_ports = { 5290 }
https_ports = { 5291 }

-- Enable use of libevent for better performance under high load
-- For more information see: http://prosody.im/doc/libevent
use_libevent = true;

-- Enable IPv6
use_ipv6 = true;

-- This is the list of modules Metronome will load on startup.
-- It looks for mod_modulename.lua in the plugins folder, so make sure that exists too.
-- Documentation on modules can be found at: http://prosody.im/doc/modules
modules_enabled = {

	-- Generally required
		--"roster"; -- Allow users to have a roster. Recommended ;)
		"saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
		"tls"; -- Add support for secure TLS on c2s/s2s connections
		"dialback"; -- s2s dialback support
		"disco"; -- Service discovery
		"discoitems"; -- Service discovery items

	-- Not essential, but recommended
		--"private"; -- Private XML storage (for room bookmarks, etc.)
		--"vcard"; -- Allow users to set vCards
	
	-- These are commented by default as they have a performance impact
		--"compression"; -- Stream compression

	-- Nice to have
		"version"; -- Replies to server version requests
		"uptime"; -- Report how long server has been running
		"time"; -- Let others know the time here on this server
		"ping"; -- Replies to XMPP pings with pongs
		--"pep"; -- Enables users to publish their mood, activity, playing music and more
		--"register"; -- Allow users to register on this server using a client and change passwords

	-- Admin interfaces
		--"admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
		"admin_telnet"; -- Opens telnet console interface on localhost port 5582
	
	-- HTTP modules
		"bosh"; -- Enable BOSH clients, aka "Jabber over HTTP"
		--"http_files"; -- Serve static files from a directory over HTTP

	-- Other specific functionality
		"posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
		--"groups"; -- Shared roster support
		--"announce"; -- Send announcement to all online users
		--"welcome"; -- Welcome users who register accounts
		--"watchregistrations"; -- Alert admins of registrations
		--"motd"; -- Send a message to users when they log in
		--"legacyauth"; -- Legacy authentication. Only used by some old clients and bots.

	-- Third-party plugins
		--"stanza_counter"; -- Provides stats on exchanged stanzas
		--"server_status"; -- Provide host-based stats
};

-- These modules are auto-loaded, but should you want
-- to disable them then uncomment them here:
modules_disabled = {
	-- "offline"; -- Store offline messages
	-- "c2s"; -- Handle client connections
	-- "s2s"; -- Handle server-to-server connections
};

-- Discovery items
disco_items = {
	{ "muc.jappix.com" },
	{ "vjud.jappix.com" },
	{ "pubsub.jappix.com" }
};

-- BOSH configuration (mod_bosh)
bosh_max_inactivity = 30
consider_bosh_secure = true
cross_domain_bosh = true

-- Stanza counter configuration (mod_stanza_counter)
--stanza_counter_basepath = "/stats/stanza"

-- Server status configuration (mod_server_status)
--server_status_basepath = "/stats/server"
--server_status_show_hosts = { "jappix.com", "anonymous.jappix.com" }
--server_status_show_comps = { "bind.jappix.com", "muc.jappix.com", "pubsub.jappix.com", "vjud.jappix.com" }

-- Disable account creation by default, for security
-- For more information see http://prosody.im/doc/creating_accounts
allow_registration = false;

-- These are the SSL/TLS-related settings. If you don't want
-- to use SSL/TLS, you may comment or remove this
ssl = {
	key = "/srv/data_jappix/certs/jappix.com.key";
	certificate = "/srv/data_jappix/certs/jappix.com_ca.crt";
}

-- Force clients to use encrypted connections? This option will
-- prevent clients from authenticating unless they are using encryption.

c2s_require_encryption = false

-- Force certificate authentication for server-to-server connections?
-- This provides ideal security, but requires servers you communicate
-- with to support encryption AND present valid, trusted certificates.
-- For more information see http://prosody.im/doc/s2s#security

s2s_secure = true

-- Many servers don't support encryption or have invalid or self-signed
-- certificates. You can list domains here that will not be required to
-- authenticate using certificates. They will be authenticated using DNS.

-- s2s_insecure_domains = { "gmail.com" }

-- Even if you leave s2s_secure disabled, you can still require it for
-- some domains by specifying a list here.

-- s2s_secure_domains = { "jabber.org" }

-- Select the authentication backend to use. The 'internal' providers
-- use Metronome's configured data storage to store the authentication data.
-- To allow Metronome to offer secure authentication mechanisms to clients, the
-- default provider stores passwords in plaintext. If you do not trust your
-- server please see http://prosody.im/doc/modules/mod_auth_internal_hashed
-- for information about using the hashed backend.

authentication = "internal_plain"

-- Select the storage backend to use. By default Metronome uses flat files
-- in its configured data directory, but it also supports more backends
-- through modules. An "sql" backend is included by default, but requires
-- additional dependencies. See http://prosody.im/doc/storage for more info.

--storage = "sql" -- Default is "internal"

-- For the "sql" backend, you can uncomment *one* of the below to configure:
--sql = { driver = "SQLite3", database = "prosody.sqlite" } -- Default. 'database' is the filename.
--sql = { driver = "MySQL", database = "prosody", username = "prosody", password = "secret", host = "localhost" }
--sql = { driver = "PostgreSQL", database = "prosody", username = "prosody", password = "secret", host = "localhost" }

-- Logging configuration
-- For advanced logging see http://prosody.im/doc/logging
log = {
	--info = "/var/log/metronome/metronome.log"; -- Change 'info' to 'debug' for verbose logging
	error = "/var/log/metronome/metronome.err";
	-- "*syslog"; -- Uncomment this for logging to syslog
	-- "*console"; -- Log to the console, useful for debugging with daemonize=false
}

----------- Virtual hosts -----------
-- You need to add a VirtualHost entry for each domain you wish Metronome to serve.
-- Settings under each VirtualHost entry apply *only* to that host.

VirtualHost "jappix.com"
	enabled = true

	modules_enabled = {
		-- Generally required
			"roster"; -- Allow users to have a roster. Recommended ;)

		-- Not essential, but recommended
			"private"; -- Private XML storage (for room bookmarks, etc.)
			"vcard"; -- Allow users to set vCards
		
		-- These are commented by default as they have a performance impact
			"privacy"; -- Support privacy lists

		-- Nice to have
			"pep"; -- Enables users to publish their mood, activity, playing music and more
			"register"; -- Allow users to register on this server using a client and change passwords
			"register_redirect"; -- Redirects users registering to the registration form

		-- Admin interfaces
			"admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
	};

	no_registration_whitelist = true
	registration_url = "https://jappix.com/"
	registration_text = "Please register your account on Jappix itself (open Jappix.com in your Web browser). Then you'll be able to use it anywhere you want."


VirtualHost "anonymous.jappix.com"
	enabled = true
	authentication = "anonymous"
	allow_anonymous_multiresourcing = true
	allow_anonymous_s2s = true
	anonymous_jid_gentoken = "Jappix Anonymous User"
	anonymous_randomize_for_loopback = true


------ Components ------
-- You can specify components to add hosts that provide special services,
-- like multi-user conferences, and transports.
-- For more information on components, see http://prosody.im/doc/components

---Set up a MUC (multi-user chat) room server on muc.jappix.com:
Component "muc.jappix.com" "muc"
	name = "Jappix Chatrooms"

	modules_enabled = {
		"muc_limits";
		"muc_log";
		"muc_log_http";
		"pastebin";
	}

	muc_event_rate = 0.5
	muc_burst_factor = 10

	muc_log_http = {
		http_port = 5290;
		show_join = true;
		show_status = false;
		theme = "metronome";
	}

	pastebin_url = "https://muc.jappix.com/paste/"
	pastebin_expire_after = 0
	pastebin_trigger = "!paste"

---Set up a PubSub server
Component "pubsub.jappix.com" "pubsub"
	name = "Jappix Publish/Subscribe"

	unrestricted_node_creation = true -- Anyone can create a PubSub node (from any server)

---Set up a VJUD service
Component "vjud.jappix.com" "vjud"
	ud_disco_name = "Jappix User Directory"

---Set up a BOSH service
Component "bind.jappix.com" "http"
	modules_enabled = { "bosh" }

Component "me.jappix.com" "http"
	modules_enabled = { "bosh" }

-- Set up a SOCKS5 bytestream proxy for server-proxied file transfers:
--Component "proxy.example.com" "proxy65"

---Set up an external component (default component port is 5347)
--
-- External components allow adding various services, such as gateways/
-- transports to other networks like ICQ, MSN and Yahoo. For more info
-- see: http://prosody.im/doc/components#adding_an_external_component
--
--Component "gateway.example.com"
--	component_secret = "password"
