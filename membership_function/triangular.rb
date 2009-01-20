# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

class Logic::Membership::Triangular < Logic::Membership::Function
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
				
    if x == @b
      y = 1
    end

    if x > @b && x <= @c
      m = 1.0 /(@b - @c)
      o = 1-m*@b
      y = m*x+o
    end
				
    if x > @c
      y = 0
    end
    return y.to_f
  end
  
  def center
    return (@a+@c)/2
  end
end
