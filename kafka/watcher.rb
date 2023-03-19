# frozen_string_literal: true

require 'rdkafka'
require 'logger'
require_relative '../common'

log = Logger.new($stderr)
consumer = Rdkafka::Config.new(CONSUMER_CONFIG).consumer
consumer.subscribe(KAFKA_COUNTER_TOPIC)
log.info 'Started Kafka watcher'
timestamps = []
start_clock = nil

consumer.each do |_message|
  if timestamps.empty?
    start_clock = Time.now.to_i
    log.info 'Started Kafka clock!'
  end
  timestamps << "#{Time.now.to_f * 1_000_000},#{timestamps.length}"
  next unless timestamps.length == MESSAGE_COUNT

  stop_clock = Time.now.to_i
  duration = (stop_clock - start_clock)
  log.info "Kafka took #{duration}s to complete!"
  dump_timestamps(timestamps)
end
