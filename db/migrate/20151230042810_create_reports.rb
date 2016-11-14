class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.boolean   :resolved,      default: false
      t.timestamps
    end

    add_reference :reports, :log, index: true
  end
end
