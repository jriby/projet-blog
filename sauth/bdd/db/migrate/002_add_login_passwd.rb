class AddLoginPasswd < ActiveRecord::Migration
  def up
    add_column :users, :login, :string
    add_column :users, :passwd, :string
  end

  def down
    remove_column :users, :login
    remove_column :users, :passwd
    
  end
end
