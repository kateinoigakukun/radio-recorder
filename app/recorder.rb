class Recorder

  def initialize
    @scheduler = Rufus::Scheduler.new
    register_statoin Station::Radiko
    register_statoin Station::AGRadio
  end

  def run
    @scheduler.join
  end

  private
  def register_statoin(station_class)
    return if station_class.schedule_list.nil?
    station_class.schedule_list.each do |schedule|
      typed_schedule = station_class::Schedule.new schedule
      Logger.register_log typed_schedule
      @scheduler.cron typed_schedule.cron_format do
        recorder = station_class.new typed_schedule
        Logger.record_start_log typed_schedule
        recorder.record
        Logger.record_done_log typed_schedule
      end
    end
  end
end
