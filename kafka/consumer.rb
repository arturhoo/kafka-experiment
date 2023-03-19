# frozen_string_literal: true

require 'rdkafka'
require 'logger'
require_relative '../common'

log = Logger.new($stderr)
producer = Rdkafka::Config.new(PRODUCER_CONFIG).producer
consumer = Rdkafka::Config.new(CONSUMER_CONFIG).consumer
consumer.subscribe(KAFKA_MAIN_TOPIC)
log.info 'Subscribed to kafka topic'

consumer.each do |msg|
  duration = msg.payload.to_i
  log.info 'Going to sleep' if duration.positive?
  sleep(msg.payload.to_i)
  producer.produce(
    topic: KAFKA_COUNTER_TOPIC,
    payload: 'dummy'
  )
end
