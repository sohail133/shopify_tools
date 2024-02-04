module ApplicationHelper
  def shopify_product_url(shopify_domain, product_id)
    store_name = shopify_domain.match(/^(.*?)\.myshopify\.com$/)[1]
    "#{ENV['SHOPIFY_ADMIN_URL']}/store/#{store_name}/products/#{product_id}"
  end
end
