# Purely for comparison's sake vs. async_whois.rb

require 'whois'

# Sync WHOIS lookup
domain = ARGV[0] || "github.com"
r = Whois.whois(domain)
puts "\r#{domain}\n#{"-" * domain.length}"
[:available?, :status, :expires_on].each do |k|
  puts "#{k}: #{r.properties[k]}"
end

