class Logger
  class << self

    def register(token, channel)
      @channel = channel
      Slack.configure do |conf|
        conf.token = token
      end
      @slack_client = Slack::Web::Client.new
    end

    def record_start_log(schedule)
      Logger.log %(#{schedule.title}の録画を開始しました)
    end

    def record_done_log(schedule, url)
      Logger.log_with_at [schedule_attachment(schedule, url)]
    end

    def register_log(schedule)
      days = ["日", "月", "火", "水", "木", "金", "土"]
      Logger.log %(#{schedule.start} (#{days[schedule.weekday]}) に #{schedule.title}を登録しました)
    end

    def schedule_attachment(schedule, url)
      {
        title: "#{schedule.title}の録画を完了しました",
        title_link: url,
        footer: "Radio Recorder",
        color: "#F26964"
      }
    end

    def log(text)
      begin
        @slack_client.chat_postMessage(:channel => @channel, :text => text, :as_user => true)
      rescue => error
        puts "Failed to post to slack with Logger.log (#{error})"
      end
    end

    def log_with_at(attachments)
      begin
        @slack_client.chat_postMessage(:channel => @channel, :attachments => attachments, :as_user => true)
      rescue => error
        puts "Failed to post to slack with Logger.log_with_at (#{error})"
      end
    end
  end
end
