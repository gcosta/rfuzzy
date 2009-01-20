class Logic::Fuzzy
  attr_accessor :outputs, :rules
  def initialize
    @outputs = []
    @inputs = []
    @rules=[]
    @tasks={}
    
  end
	
  def addRule(re)
    @rules.concat re
  end

  def addOutput(o)
    @outputs.concat o
  end	


  def new(options)
    case options.to_a.first.first
    when :input
      i=Logic::Input.new(options[:input])
      yield i
      @inputs << i
    when :output
      out=Logic::Output.new(options[:output])
      yield out
      @outputs << out
      
    when :rule
      r=Logic::Rule.new(options[:rule])
      yield r
      @rules << r
    
    end
  end
  
  
  def crisp(values)
    @results = {}		
    cnum = []
    cden = []
    i = 0
    @outputs.each do |output|
      cnum[i] = 0
      cden[i] = 0
      @rules.each do |rule|	
        #inf = rule.inferencia(values)
        inf = inferencia(rule,values)
        rule.output.each do |nome, coutput|						
          if coutput.to_s == output.name.to_s
            cnum[i] += inf*output.center_of(nome)*rule.weight
            cden[i] += inf*rule.weight
          end							
        end		
      end
      @results[output.name] = cnum[i]/cden[i]
      i += 1
    end
    @results
  end

  def inferencia(rule,values)	
    
    results = []
    rule.input.each do  |nome,input|
      
      values.each do |vinput,value| 
        if input == vinput
          selected=@inputs.detect{  |e| e.name.to_s == vinput.to_s }
          results << selected.membership_of(nome, value)
        end
      end
    end
    if rule.operator == :and
      return results.min
    else
      return results.max
    end
			
  end	
  
  def with_result(output_name)
    @last_result=output_name
    yield @results[output_name],self
    
  end
  #task.new
  def add(description, options,&block)
    (@tasks[@last_result]||=[]) << Logic::Task.new(description, options,&block) 
  end
  def execute
    @results.each do |k,value|
      #@tasks.each{|k,v| t.run(value)}
      @tasks[k].each{|t| t.run(value)  }
    end
  end
  def self.mathlab_source(filename)
    #f=File.open("/local/projects/ruby/ruby_fuzzy/lib/seguro_demo/seguro.fis")
    file=File.open(filename)
    rf=RFuzzy.new(file)
    #rf.rules.each{|v| puts v.conditionIn.inspect}
    fuzzy=Fuzzy.new
    fuzzy.addRule(rf.rules )
    fuzzy.addOutput(rf.outputs)
    fuzzy
  end
			
end
