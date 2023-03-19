# frozen_string_literal: true

require 'beaneater'
require 'logger'
require_relative '../common'

log = Logger.new($stderr)
beanstalkd = Beaneater.new 'beanstalkd:11300'
counter_tube = beanstalkd.tubes[BEANSTALKD_COUNTER_TUBE]
log.info 'Started beanstalkd watcher'
timestamps = []
start_clock = nil

loop do
  job = counter_tube.reserve
  if timestamps.empty?
    start_clock = Time.now.to_i
    log.info 'Started beanstalkd clock!'
  end
  job.delete
  timestamps << "#{Time.now.to_f * 1_000_000},#{timestamps.length}"
  next unless timestamps.length == MESSAGE_COUNT

  stop_clock = Time.now.to_i
  duration = (stop_clock - start_clock)
  log.info "beanstalkd took #{duration}s to complete!"
  dump_timestamps(timestamps)
end
