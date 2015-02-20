require 'active_support/core_ext/module/aliasing.rb'
require 'active_job/queue_adapters/resque_adapter'

begin
  require 'resque/plugins/lock'
rescue LoadError
  false
end

module ActiveJob
  module QueueAdapters

    class ResqueAdapter

      class << self

        def enqueue_with_lock(job)
          if job.lock
            Resque.enqueue_to job.queue_name, JobWrapperWithLock, job.serialize
          else
            Resque.enqueue_to job.queue_name, JobWrapper, job.serialize
          end
        end
        #alias_method_chain :enqueue, :lock

      end
      class JobWrapperWithLock < JobWrapper
        extend Resque::Plugins::Lock

        def self.lock(job_data)
          job = Base.deserialize(job_data)
          job.apply_lock
        end

      end

    end
  end
end