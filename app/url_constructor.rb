module URLConstructor
  STORAGE_URL = "https://bangohan.xyz"

  class << self
    def storage_url(station, file_name)
      "#{STORAGE_URL}#{station.storage_path}/#{file_name}"
    end
  end
end
