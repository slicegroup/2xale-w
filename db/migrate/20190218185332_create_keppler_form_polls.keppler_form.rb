# This migration comes from keppler_form (originally 20170719131112)
class CreateKepplerFormPolls < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_form_polls do |t|
      t.string :name
      t.string :language
      t.boolean :public, default: false
      t.integer :position
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :keppler_form_polls, :deleted_at
  end
end
