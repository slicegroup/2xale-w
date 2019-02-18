# This migration comes from keppler_form (originally 20170725141006)
class CreateKepplerFormResultsQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_form_results_questions do |t|
      t.string :option
      t.integer :result_id
      t.integer :question_id
      t.integer :position
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :keppler_form_results_questions, :deleted_at
  end
end
