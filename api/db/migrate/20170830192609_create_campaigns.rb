class CreateCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :description
      t.integer :goal
      t.integer :pledged

      t.timestamps
    end
  end
end
