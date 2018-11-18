while 1
	% create a random problem
	m = randi(20);
	n = m + randi(20);
	A = randi(100,m,n);
	c = randi(30,n,1);
	b = randi(30,m,1);

	A_start = [A, eye(m)];
	c_start = [zeros(n, 1); ones(m, 1)];

	% Make sure the first and second Phase LP is solvable (linprog returns exitflag=0) before calling own implementation
	[x_mat,fval,exitflag,output] = linprog(c_start, -eye(n+m), zeros(n+m,1), A_start, b);
	if ~exitflag || norm(fval) > 0.1 % c^T*y should be 0 for a valid start corner
		continue
	end

	[x_mat,fval,exitflag,output] = linprog(c, -eye(n), zeros(n,1), A, b);
	if ~exitflag
		continue
	end

	x_own = simplex(c, A, b);

	x_own_enum = corner_enumeration_solver(c, A, b);

	if (norm(x_own - x_mat) < 10e-8) && (norm(x_own_enum - x_mat) < 10e-8)
		disp('================== Solution appears to be correct ==================');
	else
		error('Seems like an error')
	end
end
