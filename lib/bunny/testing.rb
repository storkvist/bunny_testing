require "bunny/testing/version"

require "bunny"
require "singleton"

module Bunny
  class Testing
    include Singleton

    attr_reader :exchanges

    class << self
      def exchanges
        instance.exchanges
      end

      def queue(exchange:, routing_key: nil)
        instance.queue(exchange: exchange, routing_key: routing_key)
      end

      def reset_queue!
        instance.reset_queue!
      end
    end

    def initialize
      reset_queue!
    end

    def queue(exchange:, routing_key: nil)
      messages = exchanges[exchange]

      return messages.find_all { |message| message[:routing_key] == routing_key } unless routing_key.nil?

      messages
    end

    def reset_queue!
      @exchanges = Hash.new { |hash, key| hash[key] = [] }
    end
  end

  class Session
    def connected?
      true
    end

    def open?
      true
    end

    def next_channel_id
      @bunny_testing_channel_id = (@bunny_testing_channel_id || 0) + 1
    end

    def start
      self
    end
  end

  class Exchange
    def declare!
      true
    end
  end

  class Channel
    def basic_publish(payload, exchange, routing_key, opts = {})
      Bunny::Testing.exchanges[exchange] << {payload: payload, routing_key: routing_key, opts: opts}
    end

    def open
      @status = :open

      self
    end

    def register_exchange(exchange)
      Bunny::Testing.exchanges[exchange.name] = []
    end
  end

  class Queue
    def declare!
      @name
    end
  end
end
