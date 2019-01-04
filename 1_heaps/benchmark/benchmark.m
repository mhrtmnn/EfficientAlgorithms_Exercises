%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
max_elem = 100;
step = 1;
maxkey = 1000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% timer results
timer_iter = zeros(1, max_elem/step);
timer_makeheap = zeros(1, max_elem/step);

for numelem = step:step:max_elem
	idx = numelem/step;

	keys = randperm(maxkey, numelem);
	Q = [];
	for i=1:numelem
		% add items to heap H and itemqueue Q
		item.key = keys(i);
		Q = [Q, item];
	end

	%%%%%%%%%% create heap iteratively %%%%%%%%%%

	tic
	H1 = leftist_heap;
	for i=1:numelem
		H1 = leftist_insert(Q(i), H1);
	end
	timer_iter(idx) = toc;

	% Print for verification
	leftist_printheap(H2, [1,2,1]);
	title('Iterative');

	%%%%%%%%%% create heap from item list %%%%%%%%%%

	tic
	H2 = leftist_makeheap(Q);
	timer_makeheap(idx) = toc;

	% Print for verification
	leftist_printheap(H2, [1,2,2]);
	title('Makeheap');
end

close all
X = 1:step:max_elem;
plot(X, timer_iter, X, timer_makeheap);
legend('iterative insert', 'makeheap')
title('Break Even Point of iterative insert vs makeheap algorithm')
xlabel('Elements in Heap')
ylabel('Elapsed time')
