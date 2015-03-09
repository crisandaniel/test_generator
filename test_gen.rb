require 'json'


DEFINITIONS = File.join(File.dirname(__FILE__), 'configs.json')

class TestGen
  
  
  def initialize
      #verify if config json is present
      raise "File #{DEFINITIONS} is missing." if !File.file?(DEFINITIONS)
      # parse config json
      @config_data = JSON.parse(File.read(DEFINITIONS))
  end
  
  def generate_all_input_combinations
    retVal = []
    @config_data.keys.each do |k|
      retVal << (generate_input_combinations k)
    end
    retVal = generate_combinations retVal
    puts "Found #{retVal.length} tests"
    return retVal
  end
  
  private
  def generate_input_combinations input
    retVal = []
    descriptions = @config_data[input]['descriptions']
    restrictions = @config_data[input]['restrictions']
    description_list = []
    descriptions.each do |k,v|
      d = []
      v.each do |vv|
        d << {input => {k => vv}}
      end
      description_list << d
    end
    
    all_combinations = generate_combinations description_list
    all_len = all_combinations.length
    all_combinations.each do |combination|
      valid_combination = true
      restrictions.each do |k,restriction|
        valid_combination = false if array_included? combination, restriction
        # puts "------------------------------------"
        # p combination
        # p restriction
        # puts valid_combination
        # puts "------------------------------------"
        break if !valid_combination  
      end
      retVal << combination if valid_combination
    end
    selected_len = retVal.length
    puts "For input #{input} - found #{all_len} combinations - after applying restrictions: #{selected_len}"
    return retVal
  end
  
  def generate_combinations input_array
    input_array.first.product(*input_array[1..-1])
  end
  
  def array_included? array_1, array_2
    intersection = array_1 & array_2
    if intersection.eql?(array_1) or intersection.eql?(array_2)
      return true
    else
      return false
    end 
  end
  
end

if __FILE__ == $0
  x = TestGen.new
  y = x.generate_all_input_combinations
  File.open("output.txt", 'w') do |file| 
    y.each do |line|
      p line
      file.write(line)
      file.write("\n")
    end
  end
end

