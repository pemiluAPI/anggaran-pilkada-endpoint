class CreateWilayahs < ActiveRecord::Migration
  def change
    create_table :wilayahs do |t|
      t.string :nama

      t.timestamps
    end
  end
end
