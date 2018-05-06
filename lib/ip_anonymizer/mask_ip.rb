module IpAnonymizer
  class MaskIp
    def initialize(app)
      @app = app
    end

    def call(env)
      req = ActionDispatch::Request.new(env)
      # TODO lazy load, like ActionDispatch::RemoteIp
      req.remote_ip = IpAnonymizer.mask_ip(req.remote_ip)
      @app.call(req.env)
    end
  end
end
