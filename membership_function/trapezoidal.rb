
class Logic::Membership::Trapezoidal < Logic::Membership::Function
  
  def f(x)
    x=x.to_f
    if x < @a
      y=0
    end
			
    if x >=@a && x < @b
      m = -1.0 / (@a-@b)
      o = 1-m*@b
      y = m*x+o
    end
				
    if x >= @b && x <= @c
      y = 1
    end

    if x > @c && x <= @d
      m = 1.0 /(@c - @d)
      o = 1-m*@c
      y = m*x+o
    end
				
    if x > @d
      y = 0
    end
    return y.to_f
  end
  
  def center
    (@a+@d)/2
  end
end
