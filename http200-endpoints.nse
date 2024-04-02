-- http200-endpoints.nse
-- Description: Checks if endpoints return an HTTP 200 response
-- Usage: nmap -p 80,443 --script http200-endpoints <target>

local http = require("http")

-- Read URLs from a file (e.g., urls.txt)
local function read_urls(filename)
    local urls = {}
    for line in io.lines(filename) do
        table.insert(urls, line)
    end
    return urls
end

-- Check if an endpoint returns HTTP 200
local function check_endpoint(url)
    local response = http.get(url)
    if response.status == 200 then
        return true
    end
    return false
end

-- Main function
action = function(host, port)
    local urls = read_urls("urls.txt") -- Update with your file name
    for _, url in ipairs(urls) do
        if check_endpoint(url) then
            print("Endpoint " .. url .. " returned HTTP 200")
        end
    end
end
