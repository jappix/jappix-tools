-- Metronome Configuration File
--
-- Information on configuring Metronome can be found on our
-- website at http://www.lightwitch.org/metronome/documentation
--
-- Tip: You can check that the syntax of this file is correct
-- when you have finished by running: luac -p metronome.cfg.lua
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
-- Example: admins = { "valerian@jappix.com", "julien@jappix.com" }
admins = { }

-- Server PID
pidfile = "/var/run/metronome/metronome.pid"

-- ulimit
metronome_max_files_soft = 200000
metronome_max_files_hard = 200000

-- HTTP server
http_ports = { 5280 }
http_interfaces = { "127.0.0.1", "::1" }

--https_ports = { 5281 }
--https_interfaces = { "127.0.0.1", "::1" }

-- Enable IPv6
use_ipv6 = true

-- This is the list of modules Metronome will load on startup.
-- It looks for mod_modulename.lua in the plugins folder, so make sure that exists too.
modules_enabled = {

    -- Generally required
        --"roster"; -- Allow users to have a roster. Recommended ;)
        "saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
        "tls"; -- Add support for secure TLS on c2s/s2s connections
        "dialback"; -- s2s dialback support
        "disco"; -- Service discovery
        "discoitems"; -- Service discovery items
        "extdisco"; -- External Service Discovery

    -- Not essential, but recommended
        --"private"; -- Private XML storage (for room bookmarks, etc.)
        --"vcard"; -- Allow users to set vCards

    -- These are commented by default as they have a performance impact
        "compression"; -- Stream compression

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
        "websockets"; -- Enable WebSocket clients
        --"http_files"; -- Serve static files from a directory over HTTP

    -- Other specific functionality
        "posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
        "bidi"; -- Bidirectional Streams for S2S connections
        "stream_management"; -- Stream Management support
        --"groups"; -- Shared roster support
        --"announce"; -- Send announcement to all online users
        --"welcome"; -- Welcome users who register accounts
        --"watchregistrations"; -- Alert admins of registrations
        --"motd"; -- Send a message to users when they log in
        --"legacyauth"; -- Legacy authentication. Only used by some old clients and bots.
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
    { "proxy.jappix.com" },
    { "pubsub.jappix.com" },
    { "vjud.jappix.com" }
};

-- External Service Discovery (mod_extdisco)
external_services = {
    ["stun.jappix.com"] = {
        [1] = {
            port = "3478",
            transport = "udp",
            type = "stun"
        },

        [2] = {
            port = "3478",
            transport = "tcp",
            type = "stun"
        }
    }
};

-- Bidirectional Streams configuration (mod_bidi)
bidi_exclusion_list = { "jabber.org" }

-- BOSH configuration (mod_bosh)
bosh_max_inactivity = 30
consider_bosh_secure = true
cross_domain_bosh = true

-- WebSocket configuration (mod_websockets)
consider_websockets_secure = true
cross_domain_websockets = true

-- Disable account creation by default, for security
allow_registration = false

-- These are the SSL/TLS-related settings. If you don't want
-- to use SSL/TLS, you may comment or remove this
ssl = {
    key = "/srv/data_jappix/certs/jappix.com.key";
    certificate = "/srv/data_jappix/certs/jappix.com_ca.crt";
}

-- Force clients to use encrypted connections? This option will
-- prevent clients from authenticating unless they are using encryption.

c2s_require_encryption = true

-- Force servers to use encrypted connections? This option will
-- prevent servers from connecting unless they are using encryption.

s2s_require_encryption = true

-- Allow servers to use an unauthenticated encryption channel

s2s_allow_encryption = true

-- Don't require encryption for listed servers
s2s_encryption_exceptions = {
    "cisco.com",
    "gmail.com"
}

-- Select the authentication backend to use. The 'internal' providers
-- use Metronome's configured data storage to store the authentication data.
-- To allow Metronome to offer secure authentication mechanisms to clients, the
-- default provider stores passwords in plaintext. If you do not trust your
-- server please use internal_hashed below, to note that this will disable
-- DIGEST-MD5 as SASL mechanism.

authentication = "internal_hashed"

-- Logging configuration
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
            "mam"; -- Message Archive Management
            "privacy"; -- Support privacy lists

        -- Nice to have
            "lastactivity"; -- Logs the user last activity timestamp
            "pep"; -- Enables users to publish their mood, activity, playing music and more
            "message_carbons"; -- Allow clients to keep in sync with messages send on other resources
            "register"; -- Allow users to register on this server using a client and change passwords
            "register_redirect"; -- Redirects users registering to the registration form
            "public_service"; -- Provides some information about the XMPP server

        -- Admin interfaces
            --"admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
    }

    mam_stores_cap = 1000
    resources_limit = 10

    no_registration_whitelist = true
    registration_url = "https://jappix.com/"
    registration_text = "Please register your account on Jappix itself (open Jappix.com in your Web browser). Then you'll be able to use it anywhere you want."

    public_service_vcard = {
        name = "Jappix XMPP service",
        url = "https://jappix.com/",
        foundation_year = "2010",
        country = "FR",
        email = "valerian@jappix.com",
        admin_jid = "valerian@jappix.com",
        geo = "48.87,2.33",
        ca = { name = "StartSSL", url = "https://www.startssl.com/" },
        oob_registration_uri = "https://jappix.com/"
    }


VirtualHost "anonymous.jappix.com"
    enabled = true
    authentication = "anonymous"
    allow_anonymous_multiresourcing = true
    allow_anonymous_s2s = true
    anonymous_jid_gentoken = "Jappix Anonymous User"
    anonymous_randomize_for_trusted_addresses = { "127.0.0.1", "::1" }


------ Components ------
-- You can specify components to add hosts that provide special services,
-- like multi-user conferences, and transports.

---Set up a MUC (multi-user chat) room server on muc.jappix.com:
Component "muc.jappix.com" "muc"
    name = "Jappix Chatrooms"

    modules_enabled = {
        "muc_limits";
        --"muc_log";
        --"muc_log_http";
        "pastebin";
    }

    muc_event_rate = 0.5
    muc_burst_factor = 10

    muc_log_http_config = {
        url_base = "logs";
        theme = "metronome";
    }

    pastebin_url = "https://muc.jappix.com/paste/"
    pastebin_path = "/paste/"
    pastebin_expire_after = 0
    pastebin_trigger = "!paste"

---Set up a PubSub server
Component "pubsub.jappix.com" "pubsub"
    name = "Jappix Publish/Subscribe"

    --unrestricted_node_creation = true -- Anyone can create a PubSub node (from any server)

---Set up a VJUD service
Component "vjud.jappix.com" "vjud"
    ud_disco_name = "Jappix User Directory"

    synchronize_to_host_vcards = "jappix.com"

---Set up a BOSH service
Component "bind.jappix.com" "http"
    modules_enabled = { "bosh" }

---Set up a WebSocket service
Component "websocket.jappix.com" "http"
    modules_enabled = { "websockets" }

---Set up a BOSH + WebSocket service
Component "me.jappix.com" "http"
    modules_enabled = { "bosh", "websockets" }

---Set up a statistics service
Component "stats.jappix.com" "http"
    modules_enabled = { "server_status" }

    server_status_basepath = "/xmppd/"
    server_status_show_hosts = { "jappix.com", "anonymous.jappix.com" }
    server_status_show_comps = { "muc.jappix.com", "proxy.jappix.com", "pubsub.jappix.com", "vjud.jappix.com" }

---Set up an API service
Component "api.jappix.com" "http"
    modules_enabled = { "api_user", "api_muc" }

-- Set up a SOCKS5 bytestream proxy for server-proxied file transfers:
Component "proxy.jappix.com" "proxy65"
    proxy65_acl = { "jappix.com", "anonymous.jappix.com" }
