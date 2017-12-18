module Station
  class AGRadio < Station::Base

    class Schedule
      include Station::BaseSchedule
    end

    def initialize(schedule)
      @schedule = schedule
      @client = ::AGRadio::Recorder
    end

    def output_dir
      "#{self.class.output_path}/#{@schedule.title}"
    end

    def record
      output = output_dir
      FileUtils.mkdir_p output unless Dir.exist? output
      date = DateTime.now.strftime("%Y-%m-%d-%H-%M-%S")
      file_name = "#{date}.mp3"
      @client.record @schedule.duration * 60, "#{output}/#{file_name}"
      return file_name
    end
  end
end
