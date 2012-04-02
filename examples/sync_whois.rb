$: << File.dirname(__FILE__) + '/../lib'
require 'em-whois'

# Synchronous WHOIS lookup -- em-whois should opt to use original TcpSocket

domain = ARGV[0] || "github.com"

r = Whois.whois(domain)

puts "\r#{domain}\n#{"-" * domain.length}"
[:available?, :status, :expires_on].each do |k|
  puts "#{k}: #{r.properties[k]}"
end
