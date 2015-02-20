require 'test_helper'

class LockTest < Minitest::Test

  def test_no_lock_by_default
    assert_nil HelloJob.lock
  end

  def test_uses_given_lock
    begin
      HelloJob.lock_with 'Lock'
      assert_equal 'Lock', HelloJob.new.lock
    ensure
      HelloJob.lock_with nil
    end
  end

end