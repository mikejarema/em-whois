# em-whois [![Build Status](https://secure.travis-ci.org/mikejarema/em-whois.png)](http://travis-ci.org/mikejarema/em-whois)

This is a container for the synchronous WHOIS gem which replaces socket communications
with the EventMachine equivalent.  The result is a gem permitting asynchronous WHOIS
lookups.

`em-whois` is EventMachine-aware, meaning that it'll use asynchronous sockets when called
inside the reactor, and fallback to original sockets outside the reactor context.


## Supported Ruby Versions

`em-whois` requires ruby 2.0+, with which it has been tested and used in production.


## Examples

Simple example to check domain availability via WHOIS within the EventMachine loop:

```ruby
require 'em-whois'
require 'whois-parser'

EM.synchrony do
  whois = Whois.whois(ARGV[0] || "github.com")
  puts whois.parser.available? ? "Domain Available" : "Domain Taken"
  EM.stop
end
```

Also take a look at the async examples in `examples/`.


## License & Notes

The MIT License - Copyright (c) 2012 [Mike Jarema](http://mikejarema.com)
