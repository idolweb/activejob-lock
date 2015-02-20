require 'helper'
require 'jobs/logging_job'
require 'active_support/core_ext/numeric/time'

class LockQueuingTest < ActiveSupport::TestCase

  setup do
    TestJob.lock_with do |arg|
      "#{@id}-#{arg % 4}"
    end
  end

  test 'should run jobs enqueued on a listening queue' do
    TestJob.perform_later @id
    wait_for_jobs_to_finish_for(5.seconds)
    assert job_executed
  end

  test 'should not run job if another one with same lock enqueued' do
    TestJob.perform_later 0
    TestJob.perform_later 4
    wait_for_jobs_to_finish_for(5.seconds, 0)
    wait_for_jobs_to_finish_for(5.seconds, 4)
    refute job_executed(4)
    assert job_executed(0)
  end

  test 'should run job if another one with different lock enqueued' do
    TestJob.perform_later 1
    TestJob.perform_later 2
    wait_for_jobs_to_finish_for(5.seconds, 2)
    assert job_executed(2)
    assert job_executed(1)
  end

  test 'should run job if another one with same lock and different class enqueued' do
    TestJob2.perform_later 7
    TestJob.perform_later 3
    wait_for_jobs_to_finish_for(5.seconds, 3)
    assert job_executed(3)
    assert job_executed(7)
  end
end
