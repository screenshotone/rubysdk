require "test_helper"

class ScreenshotOneApiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ScreenshotOneApi::VERSION
  end
end
