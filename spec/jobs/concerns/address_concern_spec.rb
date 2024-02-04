require 'rails_helper'
include AddressConcern
include CustomerConcern
include OrderConcern

RSpec.describe AddressConcern do

  customer_data_hash = eval(File.read('lib/shopify_data/customers_create.json')).with_indifferent_access
  order_data_hash = eval(File.read('lib/shopify_data/customers_create.json')).with_indifferent_access

  address_hash = {
    "shopify_addr_id": 9244930965799,
    "shopify_customer_id": 6977441726759,
    "first_name": "test",
    "last_name": "order",
    "company": '',
    "address1": "test address",
    "address2": "apartment address",
    "city": "lahore",
    "province": '',
    "country": "Pakistan",
    "zip": "54000",
    "phone": '',
    "name": "test order",
    "province_code": '',
    "country_code": "PK",
    "country_name": "Pakistan",
  }

  context 'Customer Addresses' do
    customer = Customer.create(customer_params(customer_data_hash))
    address_count = customer_data_hash['addresses'].size

    it 'should create an address for customer' do
      create_customer_addresses(customer_data_hash['addresses'], customer)
      expect(customer.addresses.count).to eq(address_count)
    end

    it 'should update/create addresses for customer' do
      update_customer_addresses(customer_data_hash['addresses'], customer)
      expect(customer.addresses.count).to eq(address_count)
    end

    it 'should create default address for customer' do
      expect(create_default_address(address_hash, customer).default_address.address_type).to eq('default_address')
    end
  end

  context 'Order Addresses' do
    customer = Customer.create(customer_params(customer_data_hash))
    order = customer.orders.create(order_params(order_data_hash))

    it 'should create billing address for order' do
      create_billing_address(address_hash, order)
      expect(order.billing_address.address_type).to eq 'billing_address'
    end

    it 'should create shipping address for order' do
      create_shipping_address(address_hash, order)
      expect(order.shipping_address.address_type).to eq 'shipping_address'
    end
  end

  context 'Address Params' do
    it 'should return address updated params' do
      expect(address_params(address_hash)).to eq expected_params(address_hash)
    end
  end

  def expected_params(params)
    params.slice('first_name', 'last_name', 'company', 'address1', 'address2', 'city', 'province', 'country',
                 'zip', 'phone', 'name', 'province_code', 'country_code', 'country_name').merge(
      { shopify_addr_id: params.dig('id'), shopify_customer_id: params.dig('customer_id')
      }.with_indifferent_access)
  end
end
