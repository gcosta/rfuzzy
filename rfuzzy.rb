require "mathn"
["input","output","rule","fuzzy"].each{|lib| require lib}

class RFuzzy
  attr_accessor :system, :inputs, :outputs, :rules
  def initialize(file)
    @file=file
    @system={}
    @inputs, @outputs, @rules = [], [], []
    make
  end
  
  
  def make
    
    while chunk=@file.gets("")
     
      case chunk
      when /^\[System\]/      :
          make_attributes(chunk)
      when /^\[Input(\d+)\]/  : 
          @inputs  << make_var(chunk, :input)
      when /^\[Output(\d+)\]/ : 
          @outputs << make_var(chunk, :output)
      when /^\[Rules\]/       :
          make_rules(chunk)
      end

    end

  end
  
  def make_attributes(chunk)

    chunk.split(/\n/).each do |line|
      next if line =~ /^\[System\]/
      @system.store(*line.strip.gsub("'",'').split(/=/))
      
    end

  end
  
  def make_var(text,type)
    name=text.scan(/Name=\'(.*)\'/).to_s.to_sym
    min,max=text.scan(/Range=\[([^ ]+) ([^ ]+)\]/).flatten.map{|v| eval(v)}
  
    new_var=(type == :input)?Input.new(name):Output.new(name)
    new_var.max=max
    new_var.min=min
  
    mfs=text.scan(/MF[\d]+=\'([^\']*)\':\'([^\']*)\',\[(.*)\]/)
    mfs.each do |mf_src|
      #puts "i1.addMF(:#{mf_src[0]},:#{mf_src[1]},#{mf_src[2].split(/\s/).join(',')})"
      data=mf_src[2].split(/\s/).map{|v| eval(v)}
      new_var.addMf(mf_src[0].to_sym, mf_src[1].to_sym, *data)
    end
    new_var
  end
  
  
  def make_rules(text)
    text.split("\n").each do |line|
      next if line !~ /^\d/
      #a = input, b o restante
      a,b=line.split(/, /)
      #paga a porção inputs, fatia, converte em int e dec 1, faz compatibilidade com os indices
      inps=a.split(/\s/).map{|e| e.to_i-1}
      outs=b.split(/\(/).first.split(/\s*/).map{|e| e.to_i-1}
      #pega o andor, o último int da string
      andor=line.scan(/\d$/).to_s.to_i
      andor=(andor ==1)?(:and):(:or)
      #pega o pessoa
      w=line.scan(/\((\d+)\)/).to_s.to_i
      
      rule=Rule.new(andor)
      rule.weight=w
      
      #adiciona as condições
      inps.each_with_index do |input_var,i|
        mf=@inputs[i][input_var]
        #puts "input #{mf.name.class}, #{mf.class}"
        rule.addConditionIn(mf.name =>@inputs[i])
      end
      outs.each_with_index do |output_var,i|
        mf=@outputs[i][output_var]
        #puts "output #{mf.name.class}, #{mf.class}"
        rule.addConditionOut(mf.name => @outputs[i])
      end
     
      @rules << rule
      
      
      
    end
    
  end
  
  
end
  


#text=%Q{
#[Input1]
#Name='idade'
#Range=[18 65]
#NumMFs=3
#MF1='jovem':'trapmf',[18 18 25 30]
#MF2='medio':'trapmf',[25 30 45 55]
#MF3='velho':'trapmf',[45 55 65 65]
#}

#[Rules]
#1 3, 3 3 (1) : 1
#2 2, 2 2 (1) : 1
#3 1, 1 1 (1) : 1


#f=File.open("/local/projects/ruby/ruby_fuzzy/lib/seguro_demo/seguro.fis")
#
#
#require 'pp'
#
#
#r=RFuzzy.new(f)
#puts r.rules.size
#puts r.outputs.size
#puts r.inputs.size
#pp r
