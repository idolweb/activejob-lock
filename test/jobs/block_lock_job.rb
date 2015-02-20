#require_relative '../support/job_buffer'

class BlockLockJob < ActiveJob::Base

  lock_with do |greeter|
    greeter
  end

  def perform(greeter = "David")
    JobBuffer.add("#{greeter} says hello")
  end
end