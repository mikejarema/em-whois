# em-whois

This is a container for the synchronous WHOIS gem which replaces socket communications
with the EventMachine equivalent.  The result is a gem permitting asynchronous WHOIS
lookups.

`em-whois` is EventMachine-aware, meaning that it'll use asynchronous sockets when called
inside the reactor, and fallback to original sockets outside the reactor context.


## Examples

Simple example to grab whois info within the EventMachine loop:

```ruby
EM.synchrony do  
  
  # Async domain availability lookup via WHOIS info
  whois = Whois.whois(ARGV[0] || "github.com")
  puts whois.properties[:available?] ? "Domain Available" : "Domain Taken"

  EM.stop
end
```


## TODO

* More elegant approach to reading from the EM::Synchrony::TcpSocket in Whois::Server::Adapters::Base#ask_the_socket


## License & Notes

The MIT License - Copyright (c) 2012 [Mike Jarema](http://mikejarema.com)
