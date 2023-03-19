# frozen_string_literal: true

require 'beaneater'
require 'rdkafka'
require 'logger'
require './common'

log = Logger.new($stderr)
beanstalkd = Beaneater.new 'localhost:11300'
beanstalkd_tube = beanstalkd.tubes[BEANSTALKD_MAIN_TUBE]

kafka_producer = Rdkafka::Config.new({ 'bootstrap.servers': 'localhost:29092' }).producer
delivery_handles = []

MESSAGE_COUNT.times do |i|
  log.info "Producing message #{i}"
  msg = (i % SLEEP_MODULO).zero? ? SLEEP_DURATION : 0

  beanstalkd_tube.put(msg.to_s)

  delivery_handles << kafka_producer.produce(
    topic: KAFKA_MAIN_TOPIC,
    payload: msg.to_s,
    key: "key-#{i}"
  )
end

delivery_handles.each(&:wait)
