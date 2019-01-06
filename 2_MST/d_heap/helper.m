%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numVerts = 10;
edgeProp = 0.5;
startNode = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

G = graph();

for i=1:numVerts
	G = addnode(G, num2str(i));
end

for i=1:numVerts
	for j=i+1:numVerts		
		if rand() < edgeProp
			G = addedge(G, i, j, 100*rand());
		end
	end
end

H = plot(G, 'EdgeLabel',G.Edges.Weight, 'LineWidth', 5);
title('Randomly generated graph with MST highlighted in red')
blue = dheap_MST(G, startNode);

MST_size = height(blue);
for i=1:MST_size
	% Blue contains MST edges for i != s
	if i == startNode
		continue
	end

	edge = blue(i,:);
	highlight(H,edge.EndNodes(1), edge.EndNodes(2), 'EdgeColor', 'r')
end
