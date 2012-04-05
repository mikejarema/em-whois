require 'whois'
require 'em-synchrony'

module Whois
  class Server
    module Adapters

      class Base

        private

          #
          # Overwrite Whois::Server::Adapters::Base#ask_the_socket to 
          # be EventMachine-aware, and send calls offs asynchronously
          # if the EM reactor is running, otherwise fallback to the
          # synchronous connection.
          #
          
          alias :orig_ask_the_socket :ask_the_socket

          def ask_the_socket(*args)
            defined?(EM) && EM.reactor_running? ? em_ask_the_socket(*args) : orig_ask_the_socket(*args)
          end # ask_the_socket

          def em_ask_the_socket(query, *args)
            fiber = Fiber.current
            EM::connect args[0], args[1], AsyncClient, query, fiber
            Fiber.yield
          end # em_ask_the_socket

      end # Base

      class AsyncClient < EventMachine::Connection

        def initialize *args
          @query, @fiber = args[0..1]
          @data = ""
          super
        end

        def post_init
          send_data "#{@query}\r\n"
        end

        def receive_data(data)
          @data << data
        end

        def unbind
          @fiber.resume @data
        end

      end # AsyncClient

    end
  end
end
