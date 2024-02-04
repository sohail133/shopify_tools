class CustomersCreateJob < ActiveJob::Base  
  extend ShopifyAPI::Webhooks::Handler
  include CustomerConcern

  class << self
    def handle(topic:, shop:, body:)
      perform_later(topic:, shop_domain: shop, webhook: body)
    end
  end

  def perform(topic:, shop_domain:, webhook:)
    create_customer(webhook, shop_domain) if webhook.present?
  end
end