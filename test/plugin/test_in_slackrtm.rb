require 'helper'

class SlackRTMInputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  def create_driver(conf)
    Fluent::Test::InputTestDriver.new(Fluent::SlackRTMInput).configure(conf)
  end

  CONFIG_SUCCESS = %[
    type slackrtm
    tag test
    token hogefuga
  ]

  def test_configure_success
    d = create_driver(CONFIG_SUCCESS)

    assert_equal 'test', d.instance.tag
    assert_equal 'hogefuga', d.instance.token
  end

#   def test_configure_error_when_config_is_empty
#     assert_raise(Fluent::ConfigError) do
#       create_driver ''
#     end
#   end
end
