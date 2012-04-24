class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
    end
  end

  def down
    destroy_table :users
  end
end
