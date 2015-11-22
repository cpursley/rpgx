module RubyResty
  class RoutesDSL
    attr_reader :hash

    def initialize
      @hash = {}
    end

    def method_missing(method, *args, &block)
      @hash[method] = block ? RoutesDSL.build(&block) : args.first
    end

    def self.build(&block)
      routes = RoutesDSL.new
      routes.instance_eval(&block)
      routes.hash
    end
  end
end
ROUTES = RubyResty::RoutesDSL
