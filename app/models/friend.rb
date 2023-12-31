class Friend < ApplicationRecord
  validates :name, :event, :balance, presence: true
end
