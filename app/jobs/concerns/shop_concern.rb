module ShopConcern
  extend ActiveSupport::Concern

  def shop_params(params)
    params.except('id', 'created_at', 'updated_at', 'controller', 'action', 'type', 'webhook').merge(
      shop_id: params.dig('id'), shopify_created_at: params.dig('created_at'),
      shopify_updated_at: params.dig('updated_at')
    )
  end

  def update_shop(data_hash)
    shop_setting = ShopSetting.find_by(shop_id: data_hash.dig('id'))
    
    return shop_setting.update(shop_params(data_hash).as_json) if shop_setting.present?
    ShopSetting.create(shop_params(data_hash).as_json)
  end


  def current_shop(shop_domain)
    Shop.find_by(shopify_domain: shop_domain) or raise ActiveRecord::RecordNotFound
  end
end


