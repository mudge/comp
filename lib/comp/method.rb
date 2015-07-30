require 'comp/proc'

class Method
  def *(g)
    to_proc * g
  end
end
