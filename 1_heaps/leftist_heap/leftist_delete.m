function heap = leftist_delete(heap, key)
%deletes item from heap
	assert(isprop(heap, 'rank'))
	assert(isprop(heap, 'left'))
	assert(isprop(heap, 'right'))
	assert(isprop(heap, 'parent'))

	node = bfs_by_key(heap, key);
	if isempty(node)
		error('Key was not found in heap!')
	end

	%check if node is left or right child and mesh node's children and replace node by new sub tree
	if isempty(node.parent)
		% fprintf("Deleting root\n")
		heap = leftist_meld(node.left, node.right);
		return
	elseif node.parent.left == node
		node.parent.left = leftist_meld(node.left, node.right);
		if ~isempty(node.parent.left)
			node.parent.left.parent = node.parent;
		end
	elseif node.parent.right == node
		node.parent.right = leftist_meld(node.left, node.right);
		if ~isempty(node.parent.right)
			node.parent.right.parent = node.parent;
		end
	else
		error('We are not child of our parent!')
	end

	% the above could have destroyed the rank, so recalculate them
	update_ranks(node.parent);
end

%% local functions %%

function found = bfs_by_key(root, key)
%find node in heap with given key
	found = [];
	q = leftist_heap.empty;
	q(1) = root;

	while ~isempty(q)
		node = q(1);
		q = q(2:end);

		% Add children to queue
		if ~isempty(node.left)
			q = [q, node.left];
		end

		if ~isempty(node.right)
			q = [q, node.right];
		end

		% visit current node, return if it has the given key
		if visit(node) == key
			found = node;
			return;
		end
	end
end

function key = visit(root)
%visit a given node in the heap
	key = root.key;
end

function update_ranks(node)
%recalculate rank, if it did change, recurse to update parent rank also
	old_rank = node.rank;

	% recalculate right rank
	if isempty(node.right)
		% virtual nodes have rank 0
		rank_r = 1;
	else
		rank_r = node.right.rank + 1;
	end

	% recalculate left rank
	if isempty(node.left)
		% virtual nodes have rank 0
		rank_l = 1;
	else
		rank_l = node.left.rank + 1;
	end

	% recalculate node's rank
	new_rank = min(rank_l, rank_r);
	if new_rank ~= old_rank
		node.rank = new_rank;
		% fprintf("Fixed rank of node %d: %d --> %d\n", node.key, old_rank, new_rank);

		% restore leftist heap property if it is now violated
		if ~isempty(node.right) && (isempty(node.left) || node.left.rank < node.right.rank)
			% swap left and right child
			tmp = node.left;
			node.left = node.right;
			node.right = tmp;
		end

		% also fix parents rank, if any
		if ~isempty(node.parent)
			update_ranks(node.parent);
		end
	end
end
