class AddIndexToLogUrl < ActiveRecord::Migration
  def change
    add_index :logs, :url, :unique => true
  end
end
