module DelayedJobAdapterMonkeyPatch
  def perform
    if tenant_account
      ActsAsTenant.with_tenant(tenant_account) do
        super
      end
    else
      super
    end
  end

  def tenant_account
    @tenant_account ||= begin
      account = job_data.delete("acts_as_tenant")
      return unless account

      account["tenant_class"].constantize.find(account["tenant_id"])
    end
  end
end

ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper.prepend(DelayedJobAdapterMonkeyPatch)
