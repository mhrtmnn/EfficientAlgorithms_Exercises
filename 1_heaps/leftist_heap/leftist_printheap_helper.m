function G = leftist_printheap_helper(G, root)
%print a given heap
	assert(isprop(root, 'rank'))
	assert(isprop(root, 'left'))
	assert(isprop(root, 'right'))

	if ~isempty(root.left) && root.left.rank ~= 0
		fprintf("Left  child of %d:\t%d\t(Rank=%d)\n", root.key, root.left.key, root.left.rank)

		G = addnode(G, num2str(root.left.key));
		G = addedge(G, num2str(root.key), num2str(root.left.key));
		G = leftist_printheap_helper(G, root.left);

		% check heap property
		assert(root.key <= root.left.key);
	end
	if ~isempty(root.right) && root.right.rank ~= 0
		fprintf("Right child of %d:\t%d \t(Rank=%d)\n", root.key, root.right.key, root.right.rank)

		G = addnode(G, num2str(root.right.key));
		G = addedge(G, num2str(root.key), num2str(root.right.key));
		G = leftist_printheap_helper(G, root.right);

		% check heap property
		assert(root.key <= root.right.key);

		% check leftist heap property
		assert(root.left.rank >= root.right.rank);
	end
end
