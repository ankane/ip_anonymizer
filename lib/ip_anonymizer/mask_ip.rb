module IpAnonymizer
  class MaskIp
    def initialize(app)
      @app = app
    end

    def call(env)
      req = ActionDispatch::Request.new(env)
      # get header directly to preserve ActionDispatch::RemoteIp lazy loading
      req.remote_ip = GetIp.new(req.get_header("action_dispatch.remote_ip".freeze))
      @app.call(req.env)
    end

    class GetIp
      def initialize(remote_ip)
        @remote_ip = remote_ip
      end

      def to_s
        @ip ||= IpAnonymizer.mask_ip(@remote_ip)
      end
    end
  end
end
