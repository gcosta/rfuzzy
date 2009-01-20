# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

class Logic::Membership::Gaussian < Logic::Membership::Function
  def f(x)
     return Math.exp((-(x.to_f-@a)**2)*@b)
  end
  
  def center
    return @a
  end
end
