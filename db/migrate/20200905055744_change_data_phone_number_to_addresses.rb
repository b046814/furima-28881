class ChangeDataPhoneNumberToAddresses < ActiveRecord::Migration[6.0]
  def change
    change_column :addresses, :phone_number, :string
  end
end
