class Friend < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  validates :event, presence: true, length: { minimum: 5 }
  validates :balance, presence: true
  validates_numericality_of :balance, only_numeric: true, allow_nil: true
end
