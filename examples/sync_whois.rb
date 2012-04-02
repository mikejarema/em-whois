# Purely for comparison's sake vs. async_whois.rb

require 'whois'

r = Whois.whois(ARGV[0] || "github.com")
puts r.to_s
