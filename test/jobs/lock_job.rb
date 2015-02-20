#require_relative '../support/job_buffer'

class LockJob < ActiveJob::Base

  lock_with 'Lock'

  def perform(greeter = "David")
    JobBuffer.add("#{greeter} says hello")
  end
end