require_relative 'Node'
require 'pry'

module Collect
  def collect_level_order(root = @return_root)  # collects all children level order
    @queue = Array.new(1, @return_root) if defined?(@queue) == nil   
    root = @queue.shift

    unless root == nil  
      unless root.node_left == nil
        @queue << root.node_left
        @ary << root.node_left.node_data
      end
      unless root.node_right == nil
        @queue << root.node_right
        @ary << root.node_right.node_data
      end
      
      collect_level_order
    end
    @ary
  end

  def collect_preorder(root = @return_root)  # collects all children preorder
    if @i == true
      @ary = []
      @i = false
    end

    unless root.node_left == nil || @ary.any?(root.node_left.node_data)
      @ary << root.node_left.node_data
      collect_preorder(root.node_left)
    end

    unless root.node_right == nil || @ary.any?(root.node_right.node_data)
      @ary << root.node_right.node_data
      collect_preorder(root.node_right)
    end

    @ary
  end

  def collect_inorder(root = @return_root)  # collects all children inorder
    if @j == true
      @ary = []
      @j = false
    end

    collect_inorder(root.node_left) unless root.node_left == nil || @ary.any?(root.node_left.node_data)
            
    @ary << root.node_data

    collect_inorder(root.node_right) unless root.node_right == nil || @ary.any?(root.node_right.node_data)
      
    @ary
  end

  def collect_postorder(root = @return_root)  # collects all children postorder
    if @k == true
      @ary = []
      @k = false
    end

    unless root.node_left == nil || @ary.any?(root.node_left.node_data)
      collect_postorder(root.node_left)
      @ary << root.node_left.node_data
    end

    unless root.node_right == nil || @ary.any?(root.node_right.node_data)
      collect_postorder(root.node_right)
      @ary << root.node_right.node_data
    end

    @ary
  end
end

class Tree
  include Collect

  def initialize(ary)
    @ary = ary
    @root = self.build_tree(@ary)
  end

  def build_tree(ary)
    @ary = ary.uniq  # removes all duplicates
    @root = Node.new(@ary.shift)
    @return_root = @root  # return this 
    fill_tree
    @return_root
  end

  def fill_tree
    until @ary.empty?
      @root = @return_root
      expand_left(@ary.shift) if @ary[0] < @root.node_data
      expand_right(@ary.shift) if @ary[0] > @root.node_data  
    end
  end

  def expand_left(data)
    if @root.node_left == nil
      @parent_node = @root
      @root = Node.new(data)
      @parent_node.assign_left(@root)
    else
      @root = @root.node_left
      if data < @root.node_data 
        expand_left(data)
      else
        expand_right(data)
      end
    end
  end

  def expand_right(data)
    if @root.node_right == nil
      @parent_node = @root
      @root = Node.new(data)
      @parent_node.assign_right(@root)
    else
      @root = @root.node_right
      if data < @root.node_data 
        expand_left(data)
      else
        expand_right(data)
      end
    end
  end

  def insert(data)
    @ary = Array.new(1, data)
    fill_tree
    p @root.node_data
  end

  def delete(data)
    @root = find(data)
    return nil if @root == nil
    collect_preorder(@root)
    data < @parent_node.node_data ? @parent_node.assign_left(nil): @parent_node.assign_right(nil)
    fill_tree
    true
  end

  def find(data)
    @root = @return_root
    until data == @root.node_data
      @parent_node = @root
      if data < @root.node_data
        return nil if @root.node_left == nil
        @root = @root.node_left
      else data > @root.node_data
        return nil if @root.node_right == nil
        @root = @root.node_right
      end
    end
    @root
  end

  def level_order
    unless block_given?
      @ary << @return_root.node_data
      return collect_level_order
    end

    @queue = Array.new(1, @return_root) if defined?(@queue) == nil   
    @root = @queue.shift

    unless @root == nil  
      unless @root.node_left == nil
        @queue << @root.node_left
        @ary << @root.node_left.node_data
      end
      unless @root.node_right == nil
        @queue << @root.node_right
        @ary << @root.node_right.node_data
      end
      
      yield @root
      level_order {yield @root}
    end
  end

  def preorder
    unless block_given?
      @ary << @return_root.node_data
      collect_preorder
      return @ary
    end

    if defined?(@stack) == nil
      @stack = Array.new(0)
      @root = @return_root
    end

    unless @root == nil
      yield @root
      unless @root.node_right == nil
        @stack << @root.node_right
      end
      unless @root.node_left == nil
        @root = @root.node_left
      else
        @root = @stack.pop
      end
      preorder {yield @root}
    end
  end

  def inorder(root = @return_root, &block)
    unless block_given?
      collect_inorder
      return @ary
    end

    return if root.nil?
    inorder(root.node_left, &block)
    yield(root)
    inorder(root.node_right, &block)
  end

  def postorder(root = @return_root, &block)
    unless block_given?
      collect_postorder
      return @ary
    end

    return if root.nil?
    postorder(root.node_left, &block)
    postorder(root.node_right, &block)
    yield(root)
  end

  def depth(root = @return_root)
    return -1 if root.nil?
    left_depth = depth(root.node_left)
    right_depth = depth(root.node_right)
    left_depth > right_depth ? left_depth + 1 : right_depth + 1
  end
end
