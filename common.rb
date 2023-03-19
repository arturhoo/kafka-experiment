# frozen_string_literal: true

SLEEP_DURATION = 10
MESSAGE_COUNT =  100
SLEEP_MODULO = 25

KAFKA_MAIN_TOPIC = 'main'
KAFKA_COUNTER_TOPIC = 'counter'
CONSUMER_CONFIG = {
  'bootstrap.servers': 'kafka:9092',
  'group.id': 'main-group',
  'enable.partition.eof': false,
  'auto.offset.reset': 'earliest'
}.freeze
PRODUCER_CONFIG = { 'bootstrap.servers': 'kafka:9092' }.freeze

BEANSTALKD_MAIN_TUBE = 'main'
BEANSTALKD_COUNTER_TUBE = 'counter'

def dump_timestamps(timestamps)
  File.write('/tmp/timestamps.csv', timestamps.join("\n"))
end
