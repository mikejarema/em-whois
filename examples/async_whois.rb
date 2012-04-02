require 'em-synchrony'

$: << File.dirname(__FILE__) + '/../lib'
require 'em-whois'

EM.synchrony do  
  r = Whois.whois(ARGV[0] || "github.com")
  puts r.to_s

  EM.stop
end
