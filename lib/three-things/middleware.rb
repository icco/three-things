module ThreeThings
  class Middleware
    def initialize app, statsd, prefix = ""
      @app = app
      @statsd = statsd

      # This is actually better dealt with using Statsd.tap, but it all depends
      # on your statsd implementation.
      @prefix = prefix
    end

    def path postfix
      if @prefix != ""
        return "#{@prefix}.#{postfix}"
      else
        return postfix
      end
    end

    def call env
      req = Rack::Request.new(env)

      # Request count
      @statsd.increment path("request.count"), {path: req.path}

      # Reqest time
      status, headers, body = @statsd.time path("request.time"), {path: req.path} do
        @app.call env
      end

      # Request errors
      if status > 308
        @statsd.increment path("request.error"), {status_code: status, path: req.path}
      end

      [status, headers, body]
    end
  end
end
