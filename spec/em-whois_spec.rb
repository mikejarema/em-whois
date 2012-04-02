require "spec/helper/all"

describe "Asynchronous WHOIS" do

  it "should not use synchronous socket methods" do
    
    EM.synchrony do
      Whois::Server::Adapters::Base.any_instance.should_not_receive(:orig_ask_the_socket)

      whois = Whois.whois("google.com")
      whois.should_not be_available # Sanity check

      whois = Whois.whois("#{rand(Time.now.to_i)}-alskdjflkasjd.com")
      whois.should be_available # Sanity check

      EM.stop
    end

  end

  it "should match synchronous WHOIS results" do
    async_whois = nil
    sync_whois = nil

    EM.synchrony do
      async_whois = Whois.whois("github.com")
      EM.stop
    end

    sync_whois = Whois.whois("github.com")

    async_whois.properties.should == sync_whois.properties
  end

end

describe "Synchronous WHOIS" do

  it "should not use asynchronous socket methods" do
    Whois::Server::Adapters::Base.any_instance.should_not_receive(:em_ask_the_socket)

    whois = Whois.whois("google.com")
    whois.should_not be_available # Sanity check

    whois = Whois.whois("#{rand(Time.now.to_i)}-alskdjflkasjd.com")
    whois.should be_available # Sanity check
  end

end
