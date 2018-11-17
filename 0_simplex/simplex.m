function x_opt = simplex(c, A, b)
	m = size(A, 1); % rows of A
	n = size(A, 2); % cols of A
	assert(m == rank(A));

	% prepare for Phase I
	A_start = [A, eye(m)];
	x_start = b;
	B_start = (n+1):(n+m);
	c_start = [zeros(n, 1); ones(m, 1)];

	% find start corner with known start values
	[x_opt_start, B] = simplex_bare(c_start, A_start, b, x_start, B_start);

	% prepare for Phase II
	assert(norm(c_start'*x_opt_start) < 10e-5, 'Start corner is invalid: cost != 0');
	assert(all(B<=n), 'Start corner is invalid: some B > n');
	x = x_opt_start(B);

	% use calculated start corner to find the true solution
	[x_opt, ~] = simplex_bare(c, A, b, x, B);
end

function [x_opt, B] = simplex_bare(c, A, b, x, B)
	assert(size(A,1) <= size(A,2))
	assert(size(A,1) == size(b,1))
	assert(size(A,1) == size(x,1))
	m = size(A, 1); % rows of A
	n = size(A, 2); % cols of A
	assert(m == rank(A))

	while 1
		% non base indices
		N = setdiff(1:n, B);

		% reduced costs
		dn = c(N)' - c(B)' * inv(A(:, B)) * A(:, N);

		gamma = find(dn < 0, 1);
		if isempty(gamma)
			% CASE: dn componentwise >= 0
			% we should not change x(N), since this can only increase c'*x
			disp('Optimal solution found!')

			% construct solution vector
			x_opt = zeros(n,1);
			x_opt(B) = x;

			return
		end

		% CASE: at least one element of dn < 0
		% we may be able to increase the mathing x(N) for a better solution (and decrease x_B accordingly)
		gamma = N(gamma); % index mapping

		ug = A(:, B)\A(:, gamma);
		if all(ug <= 0)
			% CASE: all components of ug are <= 0
			% we can increase some x(N) without restriction, and x>=0 constraint will never be violated
			error('Problem is unbounded')
		end

		% CASE: at least one component of ug > 0
		% find lambda with: x_hat + lambda*vg = x_B - lambda*ug .= 0
		% (i.e. lambda s.t. one component is 0, all others >= 0)
		ratios = (A(:, B)\b) ./ ug;

		% disregard all non positive components in the following
		ratios(ug <= 0) = Inf;

		[~, r] = min(ratios);
		r = B(r); % index mapping

		% swap elements r and gamma
		assert(any(ismember(B,r)));
		assert(~any(ismember(B,gamma)));
		B(B==r) = gamma;

		x = A(:,B)\b;
	end
end
