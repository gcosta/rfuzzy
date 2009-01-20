class Logic::Output < Logic::Variable
  
  def initialize(name)
    super
    @tasks=[]
    @result=0
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