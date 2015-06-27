module Fluent
  module Slack
    class EventParser
      def parse(event)
        Event.new(
          event[:channel],
          event[:type],
          event[:subtype]
        )
      end
    end

    class Event
      attr_reader :channel, :type, :subtype

      def initialize(channel, type, subtype)
        @channel = channel
        @type = type
        @subtype = subtype
      end
    end

    class Condition
      attr_reader :include_or_not

      def eval_with(event)
        raise "This is abstract Method"
      end
    end

    class ChannelCondition < Condition
      attr_reader :channels

      def initialize(channels, include_or_not)
        @channels = channels
        @include_or_not = include_or_not
      end
    end

    class TypeCondition < Condition
      attr_reader :types

      def initialize(types, include_or_not)
        @types = types
        @include_or_not = include_or_not
      end
    end

    class BotCondition < Condition
      def initialize(include_or_not)
        @include_or_not = include_or_not
      end
    end
  end
end
