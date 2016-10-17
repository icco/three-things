module ThreeThings
  class Middleware
    def initialize(app, statsd, prefix = "")
      @app = app
      @statsd = statsd

      # This is actually better dealt with using Statsd.tap, but it all depends
      # on your statsd implementation.
      @prefix = prefix
    end

    def path(postfix)
      if @prefix != ""
        "#{@prefix}.#{postfix}"
      else
        postfix
      end
    end

    def call(env)
      req = Rack::Request.new(env)

      # Request count
      @statsd.increment path("request.count"), tags: ["path:#{req.path}"]

      # Reqest time
      status, headers, body = @statsd.time path("request.time"), tags: ["path:#{req.path}"] do
        @app.call env
      end

      # Request errors
      if status > 308
        @statsd.increment path("request.error"), tags: ["status_code:#{status}", "path:#{req.path}"]
      end

      [status, headers, body]
    end
  end
end
