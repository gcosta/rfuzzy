class Logic::Variable
  include Logic::Membership::Facade
  attr_accessor :name 
  attr_reader :min, :max, :mfs_indexed, :mfs
  
  def initialize(name)
    @name = name
    @mfs = {}
    @mfs_indexed=[]
  end
	
  def add(mf)
    
    @min||=mf.a
    @max||=mf.b
    
    @min=mf.a if mf.a < @min
    @max=mf.d if mf.d > @max
    
    @mfs[mf.name] = mf
    @mfs_indexed << mf
  end

  
  def [](mf_index)
    @mfs_indexed[mf_index]
  end

  def membership_of(name,x)
    @mfs[name.to_s].f(x)		
  end

  def center_of(name)
    @mfs[name.to_s].center		
  end

  def memberships(x)
    h = {}
    @mfs.each{ |mf| h[mf.name] = mf.f(x)}
    h       
  end	
  
  def centers(x)
    h = {}
    @mfs.each{ |mf| h[mf.name] = mf.center}
    h       
  end	
  
  def range
    @min..@max
  end

end
