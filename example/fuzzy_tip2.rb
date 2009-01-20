##this example is based on the example found in the MathWorks Mathlab Fuzzy 
#Logic Toolbox user's guide at http://www.mathworks.com/access/helpdesk/help/toolbox/fuzzy/
#Read the User's Guide, it's a good and simple read.Neither I nor this code have
#any association with Mathworks, though.

$LOAD_PATH << "../"
require 'fuzzy_logic'

fis = Logic::Fuzzy.new

##inputs
fis.new :input => :service do |input|
  input.triangular 'poor', :a => -5, :b => 0, :c => 5
  input.triangular 'good',:a => 1, :b => 5, :c => 9
  input.triangular 'excellent',:a => 5, :b => 10, :c => 15
end

fis.new :input => :food do |input|
  input.trapezoidal 'rancid',  :a => 0, :b => 0, :c => 1, :d => 3
  input.trapezoidal 'delicious', :a => 7, :b => 9, :c => 10, :d => 10
end

##outputs
fis.new :output =>  :tip do |output|
  output.triangular 'cheap',  :a => 0, :b => 5, :c => 10
  output.triangular 'average',  :a => 10, :b => 15, :c => 20
  output.triangular 'generous',  :a => 20, :b => 25, :c => 30
end

##rules
fis.new :rule => :or do |r|      
  r.input :poor => :service, :rancid => :food
  r.output :cheap => :tip
end

fis.new :rule => :or do |r|
  r.input :good => :service
  r.output :average => :tip
end

fis.new :rule => :or do |r|
  r.input :excellent => :service, :delicious => :food
  r.output :generous => :tip
end
  
 
puts fis.crisp(:service => 5, :food => 5)

