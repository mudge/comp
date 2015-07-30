class Proc
  unless method_defined?(:*)
    def *(g)
      if lambda?
        lambda { |*args, &blk| call(g.call(*args, &blk)) }
      else
        proc { |*args, &blk| call(g.call(*args, &blk)) }
      end
    end
  end
end
