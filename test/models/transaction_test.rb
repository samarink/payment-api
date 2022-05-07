require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  def setup
    @transaction = transactions(:one)
  end

  test 'valid with right attributes' do
    assert @transaction.valid?
  end

  test 'invalid if any of the attributes are missing' do
    @transaction.name = nil
    @transaction.date = nil
    @transaction.amount = nil
    @transaction.user = nil

    refute @transaction.valid?, 'saved invalid transaction'
    assert_not_nil @transaction.errors[:name], 'no validation error for name present'
    assert_not_nil @transaction.errors[:date], 'no validation error for date present'
    assert_not_nil @transaction.errors[:amount], 'no validation error for amount present'
    assert_not_nil @transaction.errors[:user], 'no validation error for user present'
  end

  test '#in_the_period_of' do
    filtered = Transaction.in_the_period_of('2022-04-01'.to_date..'2022-06-01'.to_date)

    assert_includes filtered, transactions(:one)
    assert_includes filtered, transactions(:two)
    refute_includes filtered, transactions(:three)
  end
end
