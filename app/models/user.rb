class User < ApplicationRecord
  has_many :transactions, dependent: :destroy

  validates :name, presence: true

  def balance
    # Having balance as one of the columns on user table has a number of possible drawbacks
    # To name a few:
    # Handling concurent requests that require balance being changed
    # It's error prone to manipulate and could be easily set incorrectly
    #
    # The current implementation is subject to scailing issues
    # However that could easily be hanled by introducting caching for example
    transactions.sum(:amount)
  end

  def balance_at_point_in_time(time)
    transactions.in_the_period_of(50.years.ago..time).sum(:amount)
  end

  def transactions_in_the_period_of(from, to)
    {
      balance_at_start_of_the_period: balance_at_point_in_time(from.to_date),
      balance_at_end_of_the_period: balance_at_point_in_time(to.to_date),
      transactions: transactions.in_the_period_of(from.to_date..to.to_date)
    }
  end
end
