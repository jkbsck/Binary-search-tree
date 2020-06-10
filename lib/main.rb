# BINARY SEARCH TREE

require_relative 'Tree'

ary = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

#x = Time.now.to_f
tree = Tree.new(ary)
#p y = Time.now.to_f - x

#x = Time.now.to_f
#tree.insert(84)
#p y = Time.now.to_f - x

#p tree.find(324)
#p tree.find(325)

# puts "----------------------------"
# p tree.find(23)
# p tree.delete(23)
# p tree.find(23)

#p tree.level_order { |node| print "#{node.node_data} -> "}
#p tree.preorder { |node| print "#{node.node_data} -> "}
#p tree.inorder# { |node| print "#{node.node_data} -> "}
#p tree.postorder# { |node| print "#{node.node_data} -> "}

# p tree.collect_preorder
# p tree.collect_inorder
# p tree.collect_postorder

p tree.depth
