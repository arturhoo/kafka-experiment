# frozen_string_literal: true

require 'beaneater'
require 'logger'
require_relative '../common'

log = Logger.new($stderr)
beanstalkd = Beaneater.new 'beanstalkd:11300'
main_tube = beanstalkd.tubes[BEANSTALKD_MAIN_TUBE]
counter_tube = beanstalkd.tubes[BEANSTALKD_COUNTER_TUBE]
log.info 'Connected to beanstalkd'

loop do
  job = main_tube.reserve
  duration = job.body.to_i
  log.info 'Going to sleep' if duration.positive?
  sleep(duration)
  counter_tube.put('dummy')
  job.delete
end
