require 'whois'
require 'em-synchrony'

module Whois
  class Server
    class SocketHandler

      #
      # Overwrite Whois::Server::SocketHandler#call to
      # be EventMachine-aware, and send calls offs asynchronously
      # if the EM reactor is running, otherwise fallback to the
      # synchronous connection.
      #

      alias :orig_call :call

      def call(*args)
        defined?(EM) && EM.reactor_running? ? em_call(*args) : orig_call(*args)
      end

      def em_call(query, *args)
        fiber = Fiber.current
        EM::connect args[0], args[1], AsyncClient, query, fiber
        Fiber.yield
      end

    end

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

    end

  end
end
