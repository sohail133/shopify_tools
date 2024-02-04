class DataSynchronization::RequestedData
  def customers
    DataSynchronization::CreateRequestDataJob.new.perform(
      shop: shop, request_model: request_model.to_s, topic: topic.to_s
    )
  end

  def orders
    DataSynchronization::CreateRequestDataJob.new.perform(
      shop: shop, request_model: request_model.to_s, topic: topic.to_s
    )
  end

  def products
    DataSynchronization::CreateRequestDataJob.new.perform(
      shop: shop, request_model: request_model.to_s, topic: topic.to_s
    )
  end
end