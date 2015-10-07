class Wilayah < ActiveRecord::Base
  has_many :anggarans

  validates :nama,
  					presence: true

  def self.apiall(data = {})
    wilayah          = self.all
    paginate_wilayah = wilayah.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      wilayah: 	paginate_wilayah.map{|value|
                  {
                  	id: value.id,
                  	nama: value.nama
                  }
              	},
      count: paginate_wilayah.count,
      total: wilayah.count
		}
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

end
