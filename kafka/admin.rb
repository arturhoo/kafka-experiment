# frozen_string_literal: true

require 'rdkafka'
require 'logger'
require_relative '../common'

log = Logger.new($stderr)
admin = Rdkafka::Config.new(PRODUCER_CONFIG).admin
admin.create_topic(KAFKA_MAIN_TOPIC, 10, 1).wait
admin.create_topic(KAFKA_COUNTER_TOPIC, 1, 1).wait
log.info 'Topics created!'
