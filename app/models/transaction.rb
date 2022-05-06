class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount, :date, :name, presence: true
  validates :amount, numericality: true
end
