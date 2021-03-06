import Grid;

class Pathfinding
{	
	static public function findPath(start: Node, end: Node, grid: Grid):Array<Node>
	{
		var frontier = [start];
		var visited = [];
		var goal = end;
		var path:Array<Node> = [];
		var current;

		while (frontier.length > 0)
		{
			current = getMinF(frontier);
			frontier.remove(current);

			for (neib in grid.getNeighbors(current))
			{
				if (neib.walkable && !neib.isInArray(visited))
				{
					neib.parentNode = current;
					neib.G = neib.parentNode.G + 10;
					neib.H = heuristic(goal, neib);
					neib.F = neib.G + neib.H;
					frontier.push(neib);
				}
			}

			visited.push(current);

			if (goal.isInArray(frontier) || frontier.length == 0)
			{	
				var node = current;
				while (node != null)
				{
					path.push(node);
					node = node.parentNode;
				}
				return path;
				break;
			}
		}
		return path;
	}

	//  Approximate cost of path from current node to end node
	static private function heuristic(node: Node, goal: Node)
	{	
		var D = 10;
		var dx = Math.abs(node.x - goal.x);
		var dy = Math.abs(node.y - goal.y);
		return D * (dx + dy);
	}

	// Get node with minimum F value
	static private function getMinF(nodes: Array<Node>)
	{	
		nodes.sort(function(a: Node, b: Node):Int {
            if (a.F == b.F)
                return 0;
            if (a.F > b.F)
                return 1;
            else
                return -1;
        });

        return nodes[0];
	}
}