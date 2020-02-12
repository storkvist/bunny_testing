module BunnyHelpers
  def send_message_through_default_exchange
    with_channel do |channel|
      queue = channel.queue("send_message_through_default_exchange")
      queue.publish("Hello World!")
    end
  end

  def send_message(exchange:, exchange_type: :direct, routing_key: "routing_key")
    with_exchange(exchange: exchange, exchange_type: exchange_type) do |exchange|
      exchange.publish("Hello World!", routing_key: routing_key)
    end
  end

  private

  def with_channel(&block)
    connection = Bunny.new
    connection.start
    channel = connection.create_channel

    yield(channel)

    connection.stop
  end

  def with_exchange(exchange:, exchange_type: :direct, &block)
    with_channel do |channel|
      exchange = channel.send(exchange_type, exchange)

      yield(exchange)
    end
  end
end
