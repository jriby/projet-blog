class CreateUtilisations < ActiveRecord::Migration

def up
  create_table :utilisations do |tbl|
    tbl.integer :user_id
    tbl.integer :application_id
  end
end

  def down
    drop_table :utilisations
  end
end
