# This migration comes from keppler_form (originally 20170719151413)
class CreateKepplerFormQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_form_questions do |t|
      t.string :sentence
      t.string :description
      t.string :ask_type
      t.integer :poll_id
      t.integer :position
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :keppler_form_questions, :deleted_at
  end
end
