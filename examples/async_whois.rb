$: << File.dirname(__FILE__) + '/../lib'
require 'em-whois'
require 'whois-parser'

# Asynchronous WHOIS lookup -- em-whois should opt to use EM-based TcpSocket

EM.synchrony do

  # EM pulse
  EM.add_periodic_timer(0.1) do
    STDERR.print "."
  end

  # Async WHOIS lookup
  domain = ARGV[0] || "github.com"

  r = Whois.whois(domain)

  puts "\r#{domain}\n#{"-" * domain.length}"
  [:available?, :status, :expires_on].each do |k|
    puts "#{k}: #{r.parser.send(k)}"
  end

  EM.stop
end
