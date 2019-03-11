class CreateKepplerContactUsSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_contact_us_settings do |t|
      t.jsonb :messages_to

      t.timestamps
    end
  end
end
