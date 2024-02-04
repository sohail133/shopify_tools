module DataSynchronization
  class CreateRequestDataJob < ActiveJob::Base
    queue_as :default

    def perform(shop:, request_model:, topic:)
      client = DataSynchronization::ClientRequest.new.call(shop)
      client.get(path: request_model).body.dig(request_model).each do |data_model|
        topic.camelize.constantize.handle(topic: request_model, shop: shop.shopify_domain, body: data_model)
      end

      shop.update(data_sync_status: 'synced') if request_model == 'orders'
    end
  end
end