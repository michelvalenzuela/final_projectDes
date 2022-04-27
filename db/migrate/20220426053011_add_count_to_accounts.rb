class AddCountToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :countcom, :integer
    add_column :accounts, :countpost, :integer
  end
end
