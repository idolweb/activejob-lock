#require_relative '../support/job_buffer'
require 'active_job/base'

class HelloJob < ActiveJob::Base
  def perform(greeter = "David")
    JobBuffer.add("#{greeter} says hello")
  end
end