require 'test_helper'

class ThreeThingsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ThreeThings::VERSION
  end
end
