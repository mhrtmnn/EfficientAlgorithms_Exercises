keys = randperm(1000, 20);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numelem = length(keys);
H1 = leftist_heap;
Q = [];

for i=1:numelem
	% add items to heap H and itemqueue Q
	item.key = keys(i);
	Q = [Q, item];
	H1 = leftist_insert(item, H1);
end

% print the iteratively generated heap
leftist_printheap(H1, [1,2,1]);
title('Iterative');
fprintf('\n\n');

% make heap from item list
H2 = leftist_makeheap(Q);
leftist_printheap(H2, [1,2,2]);
title('Makeheap');
