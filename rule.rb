class Logic::Rule

  attr_accessor :weight, :operator
  attr_reader :input, :output
  
  def initialize(operator)
    @weight = 1
    @operator =  operator
    @input,@output = {},{}
  end
	
	
  def input(inp=nil)
    if inp 
      @input.merge!(inp)
    else
      @input
    end
  end

  def output(out=nil)
    if out
      @output.merge!(out)
    else
      @output
    end
  end

  def inferencia(values)	
    
    results = []
    @input.each do  |nome,input|
      values.each do |vinput,value| 
        if input == vinput
          results << input.membership_of(nome,value)
        end
      end
    end
    if @operator == :and
      return results.min
    else
      return results.max
    end
			
  end	

  def to_s
    "Conditions: in #{@input.inspect}\tout: #{@output.inspect}"
  end

end
