class User < ApplicationRecord
  has_many :transactions, dependent: :destroy

  validates :name, presence: true
end
