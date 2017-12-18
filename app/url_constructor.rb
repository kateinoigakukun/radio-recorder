module URLConstructor
  STORAGE_URL = "https://bangohan.xyz"

  class << self
    def storage_url(station_class, file_name)
      "#{STORAGE_URL}#{station_class.storage_path}/#{file_name}"
    end
  end
end
