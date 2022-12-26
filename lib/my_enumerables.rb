module Enumerable
  # Your code goes here
  def my_each
    my_each{|el| yield element}
  end
  
  def my_each_with_index
    index = 0
    my_each do |element|
      yield element, index
      index += 1
    end
  end

  def my_select
    sel = []
    my_each do |item|
      sel << item if yield(item)
    end
    sel
  end

  def my_all?
    my_each do |item|
      return false if yield(item) == false      
    end
    true
  end
  
  def my_any?
    my_each{|item| return true if yield(item)==true}
    false
  end

  def my_none?
    my_each{|item| return false if yield(item)==true}
    true
  end

  def my_count
    return self.length unless block_given?
    c = 0
    my_each{|item| c += 1 if yield(item) == true}
    c      
  end

  def my_map
    my_each_with_index do |item, index|
      self[index] = yield(item)
    end
                              
  end

  def my_inject(initial_value=0)
    total = initial_value
    my_each{|item| total = yield total, item}
    return total
  end
    
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?
    for el in self do
      yield el
    end
    self
  end
end 
