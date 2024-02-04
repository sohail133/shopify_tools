module AddressConcern
  extend ActiveSupport::Concern

  def address_params(params)
    allowed_params = [
      :first_name, :last_name, :company, :address1, :address2, :city, :province, :country,
      :zip, :phone, :name, :province_code, :country_code, :country_name
    ]

    if params.class.eql? Hash
      permitted_params = params.select { |key, _| allowed_params.map{|p| p.to_s}.include?(key.to_s) }
    else
      permitted_params = params.permit(*allowed_params)
    end

    additional_params = {
      shopify_addr_id: params.dig('id'),
      shopify_customer_id: params.dig('customer_id')
    }.with_indifferent_access

    permitted_params.merge(additional_params)
  end

  def set_address_params(address)
    return address_params(address).merge(address_type: 'default_address') if address.dig('default')

    address_params(address)
  end

  def create_customer_addresses(addresses, customer)
    addresses.each do |address|
      customer.addresses.create(set_address_params(address))
    end
  end

  def update_customer_addresses(addresses, customer)
    addresses.each do |address|
      existing_address = customer.addresses.find_by(shopify_addr_id: address.dig('id'))
      if existing_address.present?
        existing_address.update(address_params(address))
      else
        customer.addresses.create(set_address_params(address))
      end
    end
  end

  def create_default_address(data_hash, customer)
    address = customer.addresses.new(address_params(data_hash))
    address.address_type = 'default_address'
    address.save

    customer
  end

  def create_shipping_address(address, order)
    address = order.addresses.create(address)
    address.address_type = 'shipping_address'
    address.save
  end

  def create_billing_address(address, order)
    address = order.addresses.create(address)
    address.address_type = 'billing_address'
    address.save
  end

  def create_order_addresses(data_hash, order)
    create_shipping_address(data_hash.dig('shipping_address').except('name').as_json, order) if data_hash.dig('shipping_address').present?
    create_billing_address(data_hash.dig('billing_address').as_json, order) if data_hash.dig('billing_address').present?
  end

  def update_shipping_address(shipping_addr_data, order)
    order.shipping_address.update(address_params(shipping_addr_data)) if order.shipping_address.present?
  end
end