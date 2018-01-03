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

    def storage_path
      "#{self.class.storage_path}/#{@schedule.title}"
    end

    def record
      output = output_dir
      FileUtils.mkdir_p output unless Dir.exist? output
      date = DateTime.now.strftime("%Y-%m-%d-%H-%M-%S")
      file_ex = @schedule.video ? "mp4" : "mp3"
      file_name = "#{date}.#{file_ex}"
      @client.record @schedule.duration * 60, "#{output}/#{file_name}"
      return file_name
    end
  end
end
