class Anggaran < ActiveRecord::Base
  belongs_to :wilayah

  validates :wilayah_id,
            presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }
  scope :by_wilayah, lambda{ |wilayah_id| where("wilayah_id = ?", wilayah_id) unless wilayah_id.nil? }

  def self.apiall(data = {})
    anggaran          = self.by_id(data[:id]).by_wilayah(data[:id_wilayah])
    paginate_anggaran = anggaran.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      anggaran: paginate_anggaran.map{|value| value.construct},
      count: paginate_anggaran.count,
      total: anggaran.count
		}
  end

  def construct
    return {
      id: id,
      wilayah: (wilayah.construct if wilayah),
      diajukan: diajukan,
      disetujui: disetujui,
      digunakan: digunakan,
      no_surat_nphd: no_surat_nphd,
      dokumen_nphd: dokumen_nphd
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end
end
