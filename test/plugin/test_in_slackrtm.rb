require 'helper'

class SlackRTMInputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  def create_driver(conf)
    Fluent::Test::InputTestDriver.new(Fluent::SlackRTMInput).configure(conf)
  end

  def test_configure_success
    conf = %[
      tag test
      token hogefuga
    ]
    d = create_driver(conf)

    assert_equal 'test', d.instance.tag
    assert_equal 'hogefuga', d.instance.token
  end

  def test_configure_fail_when_token_is_empty
    conf = %[
      tag test
    ]

    assert_raise(Fluent::ConfigError) do
      create_driver conf
    end
  end

  def test_configure_fail_when_tag_is_empty
    conf = %[
      token hogehoge
    ]

    assert_raise(Fluent::ConfigError) do
      create_driver conf
    end
  end

  def test_configure_error_when_config_is_empty
    assert_raise(Fluent::ConfigError) do
      create_driver ''
    end
  end

end
