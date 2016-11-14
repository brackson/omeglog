class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :url
      t.timestamps
    end
  end
end
