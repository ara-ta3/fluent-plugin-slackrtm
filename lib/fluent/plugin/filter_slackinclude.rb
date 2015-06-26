module Fluent
  require 'fluent/mixin/config_placeholders'

  class SlackIncludeFilter < Fluent::Filter
    Fluent::Plugin.register_filter('slack_include', self)

    config_param :channels, :default => [] do |val|
      val.split(',').map {|v| v.strip }
    end

    config_param :types, :default => [] do |val|
      val.split(',').map {|v| v.strip }
    end

    config_param :include_bot, :default => false

    def filter(tag, time, record)
      r = nil
      if( types.include?(record['type']) )
        r = record
      end

      if( channels.include?(record['channel']) )
        r = record
      end

      if( include_bot && record['subtype'] == :subtype_bot )
        r = record
      end

      r
    end
  end
end
