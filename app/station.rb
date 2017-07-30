module Station
  class Base
    class << self
      def config
        @config ||= YAML.load_file(File.expand_path("../../config/#{config_name}", __FILE__))
      end

      def schedule_list
        @schedule_list ||= config['schedule']
      end

      def output_path
        @output_path ||= config['config']['output']
      end

      def slack_channel
        @slack_channel ||= config['config']['output']
      end

      def config_name
        "#{name.demodulize.downcase}.yml"
      end
    end
  end

  module BaseSchedule
    def initialize(schedule_yml)
      require_params = ["start", "duration", "weekday"]
      unless schedule_yml.keys & require_params = schedule_yml.keys
        abort %(#{require_params} are required)
      end

      schedule_yml.each do |key, value|
        instance_variable_set "@#{key}", value
        self.class.class_eval { attr_reader key }
      end
    end

    def start_hour
      @start.split(':')[0]
    end

    def start_minute
      @start.split(':')[1]
    end

    def cron_format
      %(#{start_minute} #{start_hour} * * #{@weekday})
    end
  end
end