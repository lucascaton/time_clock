class CreatePunches < ActiveRecord::Migration
  def change
    create_table :punches do |t|
      t.string :origin_ip
      t.datetime :punched_at

      t.timestamps
    end
  end
end
