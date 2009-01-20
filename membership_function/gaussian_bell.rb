class Logic::Membership::GaussianBell < Logic::Membership::Function
  def f(x)
    x=x.to_f
    if x < @a
      y = Math.exp((-(x-@a)**2)*@c)
    end
	
    if x >= @a && x <= @b
      y = 1
    end
    if x > @b
      y = Math.exp((-(x-@b)**2)*@c)
    end
    return y.to_f
  end
  
  def center
    return (@a+@b)/2
  end
end
