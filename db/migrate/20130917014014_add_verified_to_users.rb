class AddVerifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verified, :boolean, :default => false
    add_column :users, :notifications, :boolean, :default => true

  end
end
