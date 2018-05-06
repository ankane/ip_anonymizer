module IpAnonymizer
  class HashIp
    def initialize(app, key:)
      @app = app
      @key = key
    end

    def call(env)
      req = ActionDispatch::Request.new(env)
      # TODO lazy load, like ActionDispatch::RemoteIp
      req.remote_ip = IpAnonymizer.hash_ip(req.remote_ip, key: @key)
      @app.call(req.env)
    end
  end
end
