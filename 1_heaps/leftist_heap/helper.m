%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxkey = 1000;
numelem = 100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

keys = randperm(maxkey, numelem);
H1 = leftist_heap;
Q = [];

%%%%%%%%%% create heap %%%%%%%%%%

for i=1:numelem
	% add items to heap H and itemqueue Q
	item.key = keys(i);
	Q = [Q, item];
	H1 = leftist_insert(item, H1);
end

%%%%%%%%%% print heaps %%%%%%%%%%

close all

% print the iteratively generated heap
leftist_printheap(H1, [1,2,1]);
title('Iterative');

fprintf('\n\n');

% make heap from item list and print
H2 = leftist_makeheap(Q);
leftist_printheap(H2, [1,2,2]);
title('Makeheap');

%%%%%%%%%% delete keys %%%%%%%%%%

figure;

delkey = keys(randi(numelem));
fprintf("==> deleting key %d\n", delkey);
H1 = leftist_delete(H1, delkey);
H2 = leftist_delete(H2, delkey);

delkey = keys(randi(numelem));
fprintf("==> deleting key %d\n", delkey);
H1 = leftist_delete(H1, delkey);
H2 = leftist_delete(H2, delkey);

delkey = keys(randi(numelem));
fprintf("==> deleting key %d\n", delkey);
H1 = leftist_delete(H1, delkey);
H2 = leftist_delete(H2, delkey);

%%%%%%%%%% print modified heaps %%%%%%%%%%

leftist_printheap(H1, [1,2,1]);
title('del: Iterative');

fprintf('\n\n');

leftist_printheap(H2, [1,2,2]);
title('del: Makeheap');
