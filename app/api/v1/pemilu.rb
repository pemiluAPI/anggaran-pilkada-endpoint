module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :wilayah do
      desc "Return all wilayah"
      get do
        {
          results: Wilayah.apiall(params)
        }
      end
    end

    resource :anggaran do
      desc "Return all anggaran"
      get do
        {
          results: Anggaran.apiall(params)
        }
      end
    end
  end
end