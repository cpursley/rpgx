class Routes

  def self.build(&block)
    hb = Routes.new
    hb.instance_eval(&block)
    hb.hash
  end

  attr_reader :hash

  def initialize
    @hash = {}
  end

  def method_missing(meth, *args, &block)
    @hash[meth] = block ? Routes.build(&block) : args.first
  end
end
