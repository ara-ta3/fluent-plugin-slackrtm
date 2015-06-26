module Fluent
  require 'fluent/mixin/config_placeholders'

  class SlackExcludeFilter < Fluent::Filter
    Fluent::Plugin.register_filter('slack_exclude', self)

    config_param :channels, :default => [] do |val|
      val.split(',').map {|v| v.strip }
    end

    config_param :types, :default => [] do |val|
      val.split(',').map {|v| v.strip }
    end

    config_param :exclude_bot, :default => false

    def filter(tag, time, record)
      r = record
      if( types.include?(record['type']) )
        r = nil
      end

      if( channels.include?(record['channel']) )
        r = nil
      end

      if( exclude_bot && record['subtype'] == :bot_message )
        r = nil
      end
      r
    end

  end
end
