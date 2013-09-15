class AddVerificationCode < ActiveRecord::Migration
  def change
  	add_column :users, :verification_code, :string
  end
end
