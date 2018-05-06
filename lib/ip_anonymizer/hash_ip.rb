module IpAnonymizer
  class HashIp
    def initialize(app, key:)
      @app = app
      @key = key
    end

    def call(env)
      req = ActionDispatch::Request.new(env)
      # get header directly to preserve ActionDispatch::RemoteIp lazy loading
      req.remote_ip = GetIp.new(req.get_header("action_dispatch.remote_ip".freeze), @key)
      @app.call(req.env)
    end

    class GetIp
      def initialize(remote_ip, key)
        @remote_ip = remote_ip
        @key = key
      end

      def to_s
        @ip ||= IpAnonymizer.hash_ip(@remote_ip, key: @key)
      end
    end
  end
end
