module DataSyncConcern
  extend ActiveSupport::Concern

  def synchronize_old_data(request_model, topic, shop)
    DataSynchronization::Request.new.call(shop, request_model, topic)
  end
end
