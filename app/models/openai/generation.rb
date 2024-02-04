class Openai::Generation < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :shop, optional: true
end
