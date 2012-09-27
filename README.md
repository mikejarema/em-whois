# em-whois [![Build Status](https://secure.travis-ci.org/mikejarema/em-whois.png)](http://travis-ci.org/mikejarema/em-whois)

This is a container for the synchronous WHOIS gem which replaces socket communications
with the EventMachine equivalent.  The result is a gem permitting asynchronous WHOIS
lookups.

`em-whois` is EventMachine-aware, meaning that it'll use asynchronous sockets when called
inside the reactor, and fallback to original sockets outside the reactor context.


## Supported Ruby Versions

Tested and used in production with MRI 1.9+.

`em-whois` relies on Ruby Fibers and `em-synchrony`, imposing a 1.9+ requirement.


## Examples

Simple example to check domain availability via WHOIS within the EventMachine loop:

```ruby
require 'em-whois'

EM.synchrony do  
  whois = Whois.whois(ARGV[0] || "github.com")
  puts whois.properties[:available?] ? "Domain Available" : "Domain Taken"

  EM.stop
end
```

Also take a look at `examples/async_whois.rb`.


## License & Notes

The MIT License - Copyright (c) 2012 [Mike Jarema](http://mikejarema.com)
