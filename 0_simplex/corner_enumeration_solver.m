function min_x = corner_enumeration_solver(c, A, b)
	m = size(A, 1); % rows of A
	n = size(A, 2); % cols of A
	assert(m == rank(A));

	min_x = [];
	min_cost = Inf;

	% enumerate all basic solutions
	C = nchoosek(1:n,m);
	for i=1:size(C,1)
		I = C(i,:);
		x = zeros(n,1);
		x(I) = A(:,I)\b;

		% check if basic solution is a basic feasible solution
		if all(x >= 0)
			cost = c'*x;
			if cost < min_cost
				min_cost = cost;
				min_x = x;
			end
		end
	end
end
