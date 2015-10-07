class CreateAnggarans < ActiveRecord::Migration
  def change
    create_table :anggarans do |t|
    	t.integer :wilayah_id
      t.float :diajukan
      t.float :disetujui
      t.float :digunakan
      t.string :no_surat_nphd
      t.string :dokumen_nphd

      t.timestamps
    end
  end
end
