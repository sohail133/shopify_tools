module Mongo::VariantCommonConcern
  extend ActiveSupport::Concern

  included do
    PER_PAGE = 25
    include Mongoid::Document
    
    def product
      Product.find_by(id: product_id)
    end

    def attachments
      Variant.find_by(shopify_variant_id: shopify_variant_id)&.attachments
    end

    def self.products
      Product.where(id: all.ids)
    end

    def self.ids
      all.pluck(:product_id)
    end

    def self.search(filter_params)
      selling_items = all

      if filter_params.dig('title').present?
        selling_products = selling_items.products.filter_by_title(filter_params.dig(:title))
        selling_items = selling_items.where(product_id: { '$in' => selling_products.ids })
      end
      selling_items = Variant.where(id: selling_items.pluck(:variant_id))
    end
  end
end