
module Logic::Membership
  
  class Function
    attr_accessor :name, :type, :a, :b, :c, :d
    # options ={:name => 'foo', :a => 30, :b => 36, :c => 43, :d => 59  }
    def initialize(options={})
      @name = options[:name]
      options.default(0)
      @a=options[:a].to_f
      @b=options[:b].to_f 
      @c=options[:c].to_f
      @d=options[:d].to_f
      
    end

    #prototypes
    def f(x)
    end
    
    def center
    end
    
  end
  
  module Facade
    def trapezoidal(name,options)
      options[:name]=name
      self.add Logic::Membership::Trapezoidal.new(options)
    end
    
    def triangular(name,options)
      options[:name]=name
      self.add Logic::Membership::Triangular.new(options)
    end
    
    def gaussian(name,options)
      options[:name]=name
    
      self.add Logic::Membership::Gaussian.new(options)
    end
    
    def gaussian_bell(name,options)
      options[:name]=name
      self.add Logic::Membership::GaussianBell.new(options)
    end
    
  end
  
  require 'membership_function/triangular'
  require 'membership_function/trapezoidal'
  require 'membership_function/gaussian'
  require 'membership_function/gaussian_bell'  
  
end

