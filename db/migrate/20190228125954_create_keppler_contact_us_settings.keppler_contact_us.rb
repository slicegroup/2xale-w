# This migration comes from keppler_contact_us (originally 20180925185421)
class CreateKepplerContactUsSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_contact_us_settings do |t|
      t.jsonb :messages_to

      t.timestamps
    end
  end
end
