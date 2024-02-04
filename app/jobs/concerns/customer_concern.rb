module CustomerConcern
  extend ActiveSupport::Concern
  include AddressConcern
  include ShopConcern

  def customer_params(params)
    allowed_params = [
      :email, :accepts_marketing, :first_name, :last_name, :orders_count, :state, :total_spent, :last_order_id,
      :note, :verified_email, :multipass_identifier, :tax_exempt, :tags, :last_order_name, :currency, :phone
    ]
    if params.class.eql? Hash
      permitted_params = params.select { |key, _| allowed_params.map{|p| p.to_s}.include?(key.to_s) }
    else
      permitted_params = params.permit(*allowed_params)
    end

    additional_params = {
      shopify_customer_id: params.dig('id'),
      shopify_created_at: params.dig('created_at'),
      shopify_updated_at: params.dig('updated_at')
    }.with_indifferent_access

    permitted_params.merge(additional_params)
  end

  def create_customer(data_hash, shop_domain)
    customer = current_shop(shop_domain).customers.new(customer_params(data_hash))
    customer_exists = Customer.find_by(shopify_customer_id: customer.shopify_customer_id)
    if customer_exists
      update_customer(data_hash)
    else
      return unless customer.save

      create_customer_addresses(data_hash.dig('addresses'), customer) if data_hash.dig('addresses').any?
    end
  end

  def update_customer(data_hash)
    customer = Customer.find_by(shopify_customer_id: data_hash.dig('id'))
    if customer.present?
      customer.update(customer_params(data_hash))
      update_customer_addresses(data_hash.dig('addresses'), customer) if data_hash.dig('addresses').any?
    end
  end

  def delete_customer(data_hash)
    customer = Customer.find_by(shopify_customer_id: data_hash.dig('id'))
    customer.update(is_deleted: true) if customer.present?
  end
end
