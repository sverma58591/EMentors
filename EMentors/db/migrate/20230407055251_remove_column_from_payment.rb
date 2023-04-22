class RemoveColumnFromPayment < ActiveRecord::Migration[6.1]
  def change
    remove_column :payments, :payment_date, :date
  end
end
