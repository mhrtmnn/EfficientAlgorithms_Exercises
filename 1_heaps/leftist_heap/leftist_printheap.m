function leftist_printheap(root, p)
%print a given heap
	assert(isprop(root, 'rank'))
	assert(isprop(root, 'left'))
	assert(isprop(root, 'right'))

	G = graph;
	G = addnode(G, num2str(root.key));
	
	fprintf("--> Root:  %d (Rank=%d)\n", root.key, root.rank)
	G = leftist_printheap_helper(G, root);
	
	subplot(p(1), p(2), p(3));
	plot(G);
end
