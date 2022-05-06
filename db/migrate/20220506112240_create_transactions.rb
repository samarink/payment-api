class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.date :date, null: false
      t.string :name, null: false
      t.integer :amount, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
