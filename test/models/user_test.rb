require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test 'valid with name' do
    assert @user.valid?
  end

  test 'invalid without name' do
    @user.name = nil
    refute @user.valid?, 'saved user without a name'
    assert_not_nil @user.errors[:name], 'no validation error for name present'
  end

  test '#transactions' do
    assert_equal 3, @user.transactions.size
  end

  test '#balance' do
    assert_equal 3, @user.balance
  end

  test '#balance_at_point_it_time' do
    assert_equal 3, @user.balance_at_point_in_time('2022-05-06'.to_date)
    assert_equal 0, @user.balance_at_point_in_time('1900-01-01'.to_date)
  end

  test '#transactions_in_the_period_of' do
    result = @user.transactions_in_the_period_of('2022-04-01', '2022-06-01')

    assert_equal 1, result[:balance_at_start_of_the_period]
    assert_equal 3, result[:balance_at_end_of_the_period]
    assert_equal 2, result[:transactions].size
  end
end
