class AddNewFiled < ActiveRecord::Migration
  def change
  	add_column :anggarans, :tanggal, :date, after: :wilayah_id
  	add_column :anggarans, :parpol_pendukung, :string, after: :dokumen_nphd
  end
end
