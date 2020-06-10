module Comparable
  def which_less?(left, right)
    left < right ? left : right
  end
end
  
class Node
  include Comparable

  attr_accessor :node_data, :node_left, :node_right

  def node_data; @data; end
  def node_left; @left; end
  def node_right; @right; end

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def assign_left(node)
    @left = node
  end

  def assign_right(node)
    @right = node
  end
end
