require 'helper'
require 'jobs/hello_job'

class LockTest < ActiveSupport::TestCase

  test 'no lock by default' do
    assert_nil HelloJob.lock
  end

  test 'uses given lock' do
    begin
      HelloJob.lock_with 'Lock'
      assert_equal 'Lock', HelloJob.new.lock
    ensure
      HelloJob.lock_with nil
    end
  end

  test 'uses given lock block' do
    begin
      proc = Proc.new { |arg| arg }
      HelloJob.lock_with(&proc)
      assert_equal proc, HelloJob.new.lock
    ensure
      HelloJob.lock_with nil
    end
  end

end