# This migration comes from keppler_form (originally 20170725140847)
class CreateKepplerFormResults < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_form_results do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :poll_id
      t.integer :position
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :keppler_form_results, :deleted_at
  end
end
