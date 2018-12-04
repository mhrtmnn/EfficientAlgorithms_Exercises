function heap1 = leftist_mesh(heap1, heap2)
%inserts item into heap
	assert(isprop(heap1, 'rank'))
	assert(isprop(heap1, 'left'))
	assert(isprop(heap1, 'right'))
	assert(isprop(heap2, 'rank'))
	assert(isprop(heap2, 'left'))
	assert(isprop(heap2, 'right'))

	if heap1.key > heap2.key
		% swap heap1 and heap2
		tmp = heap1;
		heap1 = heap2;
		heap2 = tmp;
	end

	if isempty(heap1.right)
		heap1.right = heap2;
	else
		heap1.right = leftist_mesh(heap1.right, heap2);
	end

	if isempty(heap1.left) || heap1.left.rank < heap1.right.rank
		% swap left and right child
		tmp = heap1.left;
		heap1.left = heap1.right;
		heap1.right = tmp;
	end
	
	if isempty(heap1.right)
		% virtual nodes have rank 0
		heap1.rank = 1;
	else
		heap1.rank = heap1.right.rank + 1;
	end
end
