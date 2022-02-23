class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Mostjobs aresafe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
