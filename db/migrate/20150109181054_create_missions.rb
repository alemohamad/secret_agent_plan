class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.string :code_name
      t.text :description
      t.string :status, :default => 'pending'
      t.integer :agent_id

      t.timestamps
    end
  end
end
