class Wilayah < ActiveRecord::Base
  has_many :anggarans

  validates :nama,
  					presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }

  def self.apiall(data = {})
    wilayah          = self.by_id(data[:id])
    paginate_wilayah = wilayah.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      wilayah: paginate_wilayah.map{|value| value.construct},
      count: paginate_wilayah.count,
      total: wilayah.count
		}
  end

  def construct
    return {
      id: id,
      nama: nama
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

end
