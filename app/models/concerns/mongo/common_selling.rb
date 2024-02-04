class Mongo::CommonSelling
  attr_reader :selling_items, :model_name

  def call(selling_items, model_name)
    @selling_items = selling_items
    @model_name = model_name

    create_variants
  end

  private

  def create_variants
    selling_items.each do |item|
      next unless selling_item_persisted?(item).nil?
      
      create_selling_item(item)
    end
  end

  def create_selling_item(item)
    model_name.camelize.constantize.create(item.as_json.merge(
      "variant_id": item.id, 
      "shop_id": item.product.shop_id)
    )
  end

  def selling_item_persisted?(item)
    begin
      hot_selling_item = model_name.camelize.constantize.find_by(
        shopify_variant_id: item.shopify_variant_id
      )
    rescue Mongoid::Errors::DocumentNotFound
      hot_selling_item = nil
    end
  end
end
