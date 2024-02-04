# frozen_string_literal: true

class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorageWithScopes
  include WebhooksConcern
  include DataSyncConcern

  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :qr_codes, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  has_many :openai_generations, :class_name => 'Openai::Generation'
  after_create :create_webhooks
  after_commit :data_sync, on: [:create]

  def data_sync
    SyncDataWorker.perform_async(self.id)
  end

  def api_version
    ShopifyApp.configuration.api_version
  end

  def formatted_name
    shopify_domain&.split('.')[0]&.split('-')&.map(&:capitalize)&.join(' ')
  end

  def descriptions_count
    openai_generations.where(request_type: 'descriptions').count
  end

  def descriptions_published_count
    products.where(description_published: true).count
  end

  def generations_count_array
    counts = []
    Constant::MARKETING_REQUEST_TYPES.each do |type|
      counts << openai_generations.where(request_type: type).count
    end

    counts
  end
end
