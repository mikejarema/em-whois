$: << File.dirname(__FILE__) + '/../lib'
require 'em-whois'
require 'atomic'

# Asynchronous, parallel multi-domain WHOIS lookup
domains = ARGV.empty? ? ["github.com", "google.com", "bing.com", "yahoo.com", "mikejarema.com"] : ARGV
whois   = {}

EM.synchrony do  
  
  # Progress indicator
  EM.add_periodic_timer(0.1) do
    STDERR.print "."
  end

  # Exit condition
  EM.add_periodic_timer(0.1) do
    if domains.size == whois.keys.size
      puts ""
      whois.each do |k,v|
        if v.properties[:available?]
          puts "#{k}: available"
        else
          puts "#{k}: taken, expires #{v.properties[:expires_on]}"
        end
      end

      EM.stop
    end
  end

  # Async WHOIS lookup - fire and forget via parallel fibers
  domains.each do |i|
    Fiber.new do
      whois[i] = Whois.whois(i)
    end.resume
  end

end
