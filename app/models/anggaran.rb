class Anggaran < ActiveRecord::Base
  belongs_to :wilayah

  validates :wilayah_id, presence: true
  
  delegate :nama, to: :wilayah, prefix: true, allow_nil: true

  scope :by_wilayah, lambda{ |wilayah_id| where("wilayah_id = ?", wilayah_id) unless wilayah_id.nil? }

  def self.apiall(data = {})
    anggaran          = self.by_wilayah(data[:id_wilayah])
    paginate_anggaran = anggaran.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      anggaran: 	paginate_anggaran.map{|value|
                  {
                  	id: value.id,
                  	id_wilayah: value.wilayah_id,
                  	nama_wilayah: value.wilayah_nama,
                  	diajukan: value.diajukan,
                  	disetujui: value.disetujui,
                  	digunakan: value.digunakan,
                  	no_surat_nphd: value.no_surat_nphd,
                  	dokumen_nphd: value.dokumen_nphd
                  }
              	},
      count: paginate_anggaran.count,
      total: anggaran.count
		}
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end
end
