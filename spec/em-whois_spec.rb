require "spec/helper/all"
require 'whois-parser'

def throttle
  sleep 5
  yield
end

def properties_for(whois_record)
  hash = {}
  Whois::Parser::PROPERTIES.each do |p|
    hash[p] = whois_record.parser.send(p)
  end
  hash
end

describe "Asynchronous WHOIS" do

  it "should not use synchronous socket methods" do

    EM.synchrony do
      expect_any_instance_of(Whois::Server::SocketHandler).to_not receive(:orig_call)

      whois = throttle { Whois.whois("google.com") }
      expect(whois.parser).to_not be_available # Sanity check

      whois = throttle { Whois.whois("#{rand(Time.now.to_i)}-alskdjflkasjd.com") }
      expect(whois.parser).to be_available # Sanity check

      EM.stop
    end

  end

  it "should match synchronous WHOIS results" do
    async_whois = nil
    sync_whois = nil

    EM.synchrony do
      async_whois = throttle { Whois.whois("github.com") }
      EM.stop
    end

    sync_whois = throttle { Whois.whois("github.com") }

    expect(properties_for(async_whois)).to eq(properties_for(sync_whois))
  end

end

describe "Synchronous WHOIS" do

  it "should not use asynchronous socket methods" do
    expect_any_instance_of(Whois::Server::SocketHandler).to_not receive(:em_call)

    whois = throttle { Whois.whois("google.com") }
    expect(whois.parser).to_not be_available # Sanity check

    whois = throttle { Whois.whois("#{rand(Time.now.to_i)}-alskdjflkasjd.com") }
    expect(whois.parser).to be_available # Sanity check
  end

end
