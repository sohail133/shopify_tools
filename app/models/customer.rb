class Customer < ApplicationRecord
	has_many :addresses, dependent: :destroy
	has_many :orders, dependent: :destroy
	belongs_to :shop

	has_one :default_address, -> { where(addresses: { address_type: 'default_address' }) }, class_name: 'Address'
end
