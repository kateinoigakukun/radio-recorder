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

    def record_done_log(schedule)
      Logger.log %(#{schedule.title}の録画を完了しました)
    end

    def register_log(schedule)
      days = ["日", "月", "火", "水", "木", "金", "土"]
      Logger.log %(#{schedule.start} (#{days[schedule.weekday]}) に #{schedule.title}を登録しました)
    end

    def log(text)
      @slack_client.chat_postMessage(:channel => @channel, :text => text, :as_user => true)
    end
  end
end
