require 'helper'

class SlackEventTest < Test::Unit::TestCase
  include Test::Unit::TestCasePendingSupport
  def setup
    Fluent::Test.setup
  end

  def test_filter
    pend("this is work in progress")
  end
end
