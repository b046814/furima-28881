class RemoveCheckedFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :checked, :boolean
  end
end
