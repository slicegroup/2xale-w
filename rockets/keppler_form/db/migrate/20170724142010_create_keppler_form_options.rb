class CreateKepplerFormOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_form_options do |t|
      t.string :name
      t.integer :position
      t.integer :question_id
      t.integer :position
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :keppler_form_options, :deleted_at
  end
end
