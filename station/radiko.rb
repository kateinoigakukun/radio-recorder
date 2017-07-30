module Station
  class Radiko < Station::Base

    class Schedule
      include Station::BaseSchedule
    end

    def initialize(schedule)
      @schedule = schedule
      @client = ::Radiko::Client.new
    end

    def record
      output = "#{self.class.output_path}/#{@schedule.station_id}/#{@schedule.title}"
      date = DateTime.now.strftime("%Y-%m-%d-%H-%M-%S")
      unless Dir.exist? output
        FileUtils.mkdir_p output
      end

      @client.record @schedule.station_id, @schedule.duration * 60, "#{output}/#{date}.mp3"
    end
  end
end
