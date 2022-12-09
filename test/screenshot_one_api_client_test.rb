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

    assert_equal 'https://api.screenshotone.com/take?url=https%3A%2F%2Fexample.com&full_page=true&delay=2&geolocation_latitude=48.857648&geolocation_longitude=2.294677&geolocation_accuracy=50&access_key=access_key&signature=25b0d22fe445597ec09d34e484ecddb647b31460b6de90c73f7fc193b79ac1cf',
      client.generate_take_url(options)
  end
end