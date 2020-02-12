require "spec_helper"

RSpec.describe Bunny::Testing do
  it "has a version number" do
    expect(Bunny::Testing::VERSION).not_to be(nil)
  end

  it "allows sending messages to RabbitMQ without running RabbitMQ" do
    expect {
      send_message_through_default_exchange
    }.not_to raise_exception
  end

  it "saves sended messages" do
    exchange = "my_exchange"

    expect {
      send_message(exchange: exchange)
    }.to change { Bunny::Testing.queue(exchange: exchange).size }.from(0).to(1)
  end
end
