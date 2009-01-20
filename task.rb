# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

class Logic::Task
  def initialize(description, options,&block)
    @description=description
    @condition=options[:condition]
    @block=block
  end
  
  def run(value)
    
    @block.call(value) if @condition
  end
end


#  output.execute do |value|
#    task "redirect to main", :condition => value > 1 do
#      puts "Main"
#    end
#   
#    task "redirect to close call", :condition => value == 0.5 do
#      puts "Close call"
#    end
#
#    task "nothing", :condition => value < 0 do
#      puts "nothing!!"
#    end
#  end