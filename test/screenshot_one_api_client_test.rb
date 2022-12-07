require "test_helper"

class ScreenshotOneApiClientTest < Minitest::Test
  def test_generate_take_url
    client = ScreenshotOneApi::Client.new('access_key', 'secret_key')
    options = ScreenshotOneApi::TakeOptions.new(url: "https://example.com").
              full_page(true).
              delay(2).
              geolocation_latitude(48.857648).
              geolocation_longitude(2.294677).
              geolocation_accuracy(50)

    assert_equal client.generate_take_url(options),
      'https://api.screenshotone.com/take?access_key=access_key&url=https%3A%2F%2Fexample.com&full_page=true&delay=2&geolocation_latitude=48.857648&geolocation_longitude=2.294677&geolocation_accuracy=50&signature=617c66eeedd9ebffac97e5c9429be10471632362da96e796be54911987c47ff0'
  end
end