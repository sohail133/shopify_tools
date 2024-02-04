class DataSynchronization::Request < DataSynchronization::RequestedData
  attr_reader :shop, :request_model, :topic

  def call(shop, request_model, topic)
    @shop = shop
    @request_model = request_model
    @topic = topic
    send(request_model)
  end
end