require 'rails_helper'
include CustomerConcern

RSpec.describe CustomerConcern do

  file = File.read('lib/shopify_data/customers_create.json')
  customer_data_hash = eval(file).with_indifferent_access

  context 'Customer Create' do
    it 'should create a customer' do
      prev_count = Customer.count
      create_customer(customer_data_hash)
      expect(Customer.count).to eq(prev_count + 1)
    end
  end

  context 'Customer Update' do
    it 'should update a customer' do
      Customer.destroy_all
      new_hash = customer_data_hash.except('email').merge(email: 'new_email@example.com')
      create_customer(customer_data_hash)
      update_customer(new_hash)
      customer = Customer.find_by(shopify_customer_id: customer_data_hash.dig('id'))
      expect(customer.email).to eq('new_email@example.com')
    end
  end

  context 'Customer Delete' do
    it 'should delete a customer' do
      Customer.destroy_all
      create_customer(customer_data_hash)
      delete_customer(customer_data_hash)
      customer = Customer.find_by(shopify_customer_id: customer_data_hash.dig('id'))
      expect(customer.is_deleted).to eq true
    end
  end

  context 'Customer Params' do
    it 'should return customer updated params' do
      expect(customer_params(customer_data_hash)).to eq expected_params(customer_data_hash)
    end
  end

  def expected_params(params)
    params.slice('email', 'accepts_marketing', 'first_name', 'last_name', 'orders_count', 'state', 'total_spent', 'last_order_id',
                 'note', 'verified_email', 'multipass_identifier', 'tax_exempt', 'tags', 'last_order_name', 'currency', 'phone').merge(
      { shopify_customer_id: params.dig('id'), shopify_created_at: params.dig('created_at'),
        shopify_updated_at: params.dig('updated_at')
      }.with_indifferent_access)
  end
end
