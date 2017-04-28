""" Node is defined as
class node:
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None
"""

def check_binary_search_tree_(root):
    nodes = []
    tree_to_list(root, nodes)
    return is_sorted(nodes)

def is_sorted(nodes):
    index = 1
    result = True
    while index < len(nodes):
        if nodes[index] <= nodes[index-1]: return False
        index+=1
    return result

def tree_to_list(root, nodes):
    if root.left is None:
        nodes.append(root.data)
        return None

    tree_to_list(root.left, nodes)
    nodes.append(root.data)
    tree_to_list(root.right, nodes)

    return None