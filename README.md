# Activejob::Lock

When you want only one instance of your job queued at a time.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activejob-lock'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activejob-lock

## Usage

```ruby
require 'activejob/lock'

class MyLockedJob < ActiveJob::Base
  lock_with do |record, message|
    record
  end

  def perform(record, message)
    record.do_work
  end
end
```

There will never be two MyLockedJob for the same record enqueued at the same time.

Currently works only for resque.
Contributions are welcomed for other backends.

## Contributing

1. Fork it ( https://github.com/idolweb/activejob-lock/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
