module Fluent
  require 'fluent/mixin/config_placeholders'
  require 'slack-rtmapi'

  class SlackRTMInput < Fluent::Input
    Fluent::Plugin.register_input('slackrtm', self)

    config_param :tag, :string
    config_param :token, :string

    def start
      super
      @messages_thread = Thread.new do
        url = SlackRTM.get_url token: token
        client = SlackRTM::Client.new websocket_url: url
        client.on(:message) do |data|
          emit(data)
        end
        client.main_loop
      end
      @messages_thread.abort_on_exception = true
    end

    def shutdown
      Thread.kill(@messages_thread)
    end

    def emit(data)
      time = Time.now.to_i
      Fluent::Engine.emit(tag, time, data)
    end

  end
end
