##this example is based on the example found in the MathWorks Mathlab Fuzzy 
#Logic Toolbox User's Guide at http://www.mathworks.com/access/helpdesk/help/toolbox/fuzzy/
#Read the User's Guide, it's a good and simple read. Neither I nor this code have
#any association with Mathworks, though.

$LOAD_PATH << "../"
require 'fuzzy_logic'

class FuzzyTip
  def initialize(params)
    @params = params
    @fuzzy = Logic::Fuzzy.new   
    ##inputs
    @fuzzy.new :input => :service do |input|
      input.triangular 'poor', :a => -5, :b => 0, :c => 5
      input.triangular 'good', :a => 1, :b => 5, :c => 9
      input.triangular 'excellent', :a => 5, :b => 10, :c => 15
    end

    @fuzzy.new :input => :food do |input|
      input.trapezoidal 'rancid', :a => 0, :b => 0, :c => 1, :d => 3
      input.trapezoidal 'delicious', :a => 7, :b => 9, :c => 10, :d => 10
    end

    ##outputs
    @fuzzy.new :output => :tip do |output|
      output.triangular 'cheap', :a => 0, :b => 5, :c => 10
      output.triangular 'average', :a => 10, :b => 15, :c => 20
      output.triangular 'generous', :a => 20, :b => 25, :c => 30
    end

    ##rules
    @fuzzy.new :rule => :or do |r|      
      r.input :poor => :service, :rancid => :food
      r.output :cheap => :tip
    end

    @fuzzy.new :rule => :or do |r|
      r.input :good => :service
      r.output :average => :tip
    end

    @fuzzy.new :rule => :or do |r|
      r.input :excellent => :service, :delicious => :food
      r.output :generous => :tip
    end
  
  end
 
  def result    
    service= @params[:service]
    food= @params[:food]    
    @fuzzy.crisp(:service => service, :food => food )
  end

end

  
puts FuzzyTip.new(:service => 5, :food => 5).result

