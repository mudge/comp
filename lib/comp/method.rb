require 'comp/proc'

class Method
  unless method_defined?(:*)
    def *(g)
      to_proc * g
    end
  end
end
