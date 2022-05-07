class Api::TransactionsController < ApplicationController
  def index
    if period_in_params?
      render json: User.find(params[:user_id]).transactions_in_the_period_of(params[:from], params[:to])
    else
      render json: User.find(params[:user_id]).transactions
    end
  end

  def create
    @user = User.find(params[:user_id])
    @transaction = @user.transactions.new(transaction_params)

    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: @transaction.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @transaction = Transaction.find(params[:id])

    if @transaction.update(transaction_params)
      render json: @transaction, status: :created
    else
      render json: @transaction.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])

    if @transaction.destroy
      render json: @transaction, status: :no_content
    else
      render json: @transaction.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:date, :amount, :name)
  end

  def period_in_params?
    params.has_key?(:from) && params.has_key?(:to)
  end
end
