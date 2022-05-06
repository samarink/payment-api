class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount, :date, :name, presence: true
  validates :amount, numericality: true

  scope :in_the_period_of, ->(period) { where date: period }
end
