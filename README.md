# acts_as_tenant-delayed_job

Delayed Job support for ActsAsTenant gem



## Getting started

```
bundle add acts_as_tenant-delayed_job
```

## Usage

Without this gem, DelayedJob would raise

```
Job ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper (id=2) (queue=default) RUNNING
[Worker(host:Waqass-MBP.cust.communityfibre.co.uk pid:6058)] Job ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper (id=2) (queue=default) FAILED (2 prior attempts) with ActsAsTenant::Errors::NoTenantSet: ActsAsTenant::Errors::NoTenantSet
```

This gem allows for a worker to run a job in the scope of the tenant that enqueued it. To do so, use the ActiveJob notation like

```ruby
MyMailer.notification(user).deliver_later
```

The other notation is not supported:
```ruby
MyMailer.delay.notification(user)
```


Contributing to this gem
------------------------

1. Fork the repo
2. Make changes
3. Run test suite with `bundle exec rspec`
4. Run `bundle exec standardrb` to standardize code formatting
5. Submit a PR

Author & Credits
----------------

acts_as_tenant-delayed_job is written by Nuno Costa.

This gem was extracted from https://github.com/ErwinM/acts_as_tenant/pull/316

License
-------

Copyright (c) 2023 Nuno Costa, released under the MIT license
