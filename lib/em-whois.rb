require 'whois'
require 'em-synchrony'

module Whois
  class Server
    module Adapters
      class Base
        private

          # This method handles the lowest connection
          # to the WHOIS server.
          #
          # This is for internal use only!
          #
          # @api internal
          
          alias :orig_ask_the_socket :ask_the_socket

          def ask_the_socket(*args)
            defined?(EM) && EM.reactor_running? ? em_ask_the_socket(*args) : orig_ask_the_socket(*args)
          end # ask_the_socket

          def em_ask_the_socket(query, *args)
            client = EventMachine::Synchrony::TCPSocket.new(*args)
            client.write("#{query}\r\n")    # I could use put(foo) and forget the \n
                                            # but write/read is more symmetric than puts/read
                                            # and I really want to use read instead of gets.

            response = ""

            # Synchrony TCPSocket behaves a little differently, seems to require
            # polling until an IO exception is thrown.
            # TODO: There's gotta be a more elegant way to achieve this.
            while true do
              begin
                response += client.read
              rescue IOError => e
                break
              end
            end

            response

          ensure
            client.close if client          # If != client something went wrong.
          
          end # em_ask_the_socket

      end
    end
  end
end
