module Station
  class Radiko < Station::Base

    class Schedule
      include Station::BaseSchedule
    end

    def initialize(schedule)
      @schedule = schedule
      @client = ::Radiko::Client.new
    end

    def output_dir
      "#{self.class.output_path}/#{@schedule.station_id}/#{@schedule.title}"
    end

    def record
      output = output_dir
      FileUtils.mkdir_p output unless Dir.exist? output
      date = DateTime.now.strftime("%Y-%m-%d-%H-%M-%S")
      file_name = "#{date}.mp3"
      @client.record @schedule.station_id, @schedule.duration * 60, "#{output}/#{file_name}"
      return file_name
    end
  end
end
