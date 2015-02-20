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

        def wrapper(job)
          job.lock ? JobWrapperWithLock : JobWrapper
        end

        def enqueue(job) #:nodoc:
          Resque.enqueue_to job.queue_name, wrapper(job), job.serialize
        end

        def enqueue_at(job, timestamp) #:nodoc:
          unless Resque.respond_to?(:enqueue_at_with_queue)
            raise NotImplementedError, "To be able to schedule jobs with Resque you need the " \
              "resque-scheduler gem. Please add it to your Gemfile and run bundle install"
          end
          Resque.enqueue_at_with_queue job.queue_name, timestamp, wrapper(job), job.serialize
        end
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