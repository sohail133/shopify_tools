class DataSynchronization::ClientRequest
  attr_reader :domain, :token, :session

  def call(shop)
    @domain = shop.shopify_domain 
    @token = shop.shopify_token

    get_requested_client
  end

  private

  def get_requested_client
    @session = ShopifyAPI::Auth::Session.new(shop: domain, access_token: token)
    requested_session_client
  end

  def requested_session_client
    ShopifyAPI::Clients::Rest::Admin.new(session: session)
  end
end