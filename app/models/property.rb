class Property < ApplicationRecord
  belongs_to :status
  has_many :notes
end
