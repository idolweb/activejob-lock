require 'active_support'
require 'active_job/base'
require 'activejob/lock/version'
require 'activejob/lock/queue_adapters'
require 'active_support/concern'

module ActiveJob
  module Lock
    extend ActiveSupport::Concern

    module ClassMethods

      def lock_with(lock = nil, &block)
        if block_given?
          self.lock = block
        else
          self.lock = lock
        end
      end
    end

    included do
      class_attribute :lock
    end

    def apply_lock
      suffix = if lock.is_a?(Proc)
        deserialize_arguments_if_needed
        lock.call(*arguments)
      else
        lock
      end
      "#{self.class.name}-#{suffix}"
    end
  end
  Base.include(Lock)
end

