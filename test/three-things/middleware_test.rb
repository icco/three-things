require "test_helper"

class MiddlewareTest < Minitest::Test
  include ::Rack::Test::Methods

  VCR.configure do |config|
    config.cassette_library_dir = "fixtures/vcr_cassettes"
    config.hook_into :webmock # or :fakeweb
  end

  def app
    statsd = Statsd.new("localhost", 8125)

    main_app = lambda do |env|
      request = Rack::Request.new(env)
      return_code, body_text =
        case request.path
        when "/" then [200, "Hello world"]
        when "/error"
          [501, ""]
        else
          [404, "Nothing here"]
        end
      [return_code, { "Content-type" => "text/plain" }, [body_text]]
    end

    builder = Rack::Builder.new
    builder.use ThreeThings::Middleware, statsd
    builder.run main_app
    builder.to_app
  end

  def test_200_logging
    get("/")
    assert_equal true, last_response.ok?
  end
end
