module Mongo::DbColumns
  extend ActiveSupport::Concern

  included do
    INTEGER_TYPE_COLUMNS = [ 'variant_id', 'shopify_variant_id', 'shopify_product_id',
        'position', 'grams', 'image_id', 'inventory_item_id', 'inventory_quantity',
        'old_inventory_quantity', 'product_id', 'total_quantity', 'shop_id'
      ]
    STRING_COLUMNS = ['title', 'sku', 'inventory_policy', 'fulfillment_service',
       'inventory_management', 'barcode', 'weight_unit', 'admin_graphql_api_id',
       'option1', 'option2', 'option3']
    DECIMAL_COLUMNS = ['price', 'compare_at_price', 'weight']
    BOOLEAN_COLUMNS =  ['taxable', 'requires_shipping']
    DATE_TIME_COLUMNS = ['shopify_created_at', 'shopify_updated_at', 'created_at', 'updated_at']
    
    MONGOID_COLUMNS = {
      'integer': HotSelling::INTEGER_TYPE_COLUMNS,
      'string': HotSelling::STRING_COLUMNS,
      'mongoid/boolean': HotSelling::DECIMAL_COLUMNS,
      'big_decimal': HotSelling::BOOLEAN_COLUMNS,
      'date_time': HotSelling::DATE_TIME_COLUMNS
    }

    HotSelling::MONGOID_COLUMNS.each do |key, values|
      values.each do |val|
        field val.to_sym, type: key.to_s.camelize.constantize
      end
    end
  end
end