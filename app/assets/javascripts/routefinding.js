//all the code related to route finding

var routeMode=0; //set to 1 to be in routing mode
var startNode;
var endNode;
var changedRoutes = [];
var changedPois = [];
var sideBar = document.getElementById('divRightBody');


function startRoute() {//turn on route finding mode
	routeMode=1;
	startNode = -1; 
	endNode = -1;
}

function endRoute() {routeMode=0;} //turn off route finding mode


function findShortestRoute(startNode, endNode, totalNodes)
{
	//1. Assign to every node a tentative distance value: set it to zero for our initial node and to infinity for all other nodes.
	var nodeDis = [] //distances to all nodes
	var unvisited = allNodes.slice(0); //list of all unvisited nodes
	var path = [] //best path to any node
	var I = Infinity;	
	function remove(index) {unvisited.splice(unvisited.indexOf(index),1);} //remove this node from the set
	
	//2. Mark all nodes unvisited. Set the initial node as current. Create a set of the unvisited nodes called the unvisited set consisting of all the nodes except the initial node.
	unvisited.forEach(function(i)
	{//must make indexes match, i will be id from db
		nodeDis[i] = I; //default to infinite distance
	});
	nodeDis[startNode] = 0; //distance to starting node is 0
	var currentNode = startNode;
	var prevNode = 0;
	path[startNode] = startNode.toString();
	remove(currentNode);
	
	//3. For the current node, consider all of its unvisited neighbors and calculate their tentative distances. For example, if the current node A is marked with a distance of 6, and the edge connecting it with a neighbor B has length 2, then the distance to B (through A) will be 6 + 2 = 8. If this distance is less than the previously recorded tentative distance of B, then overwrite that distance. Even though a neighbor has been examined, it is not marked as "visited" at this time, and it remains in the unvisited set.
	
	while (currentNode != endNode)
	{//loop until we reach the ending node
		var toTest = connections[currentNode].split(";"); // an array of connecting nodes
		for (i = 0; i <= toTest.length-1; i++) 
		{//go through neighbors of current node, find their distances from start
			var tempDis;
			var tempAddress = currentNode+":"+toTest[i];
			tempDis = nodeDis[currentNode] + dis[tempAddress]
			if (tempDis < nodeDis[toTest[i]]) 
			{//new shortest way to a node found
				nodeDis[toTest[i]]=tempDis; //only record new distance if it's the shortest way there so far
				path[toTest[i]] = path[currentNode] + ":" + toTest[i]; //record this path
			}
		}
		
		//4. When we are done considering all of the neighbors of the current node, mark the current node as visited and remove it from the unvisited set. A visited node will never be checked again.
		
		//5. If the destination node has been marked visited (when planning a route between two specific nodes) or if the smallest tentative distance among the nodes in the unvisited set is infinity (when planning a complete traversal), then stop. The algorithm has finished.
		
		//6. Select the unvisited node that is marked with the smallest tentative distance, and set it as the new "current node" then go back to step 3.
		
		var tempShortest=I;
		for (var i=0; i<=unvisited.length-1; i++)
		{//go through all the unvisited nodes and look for closest to start
			if (nodeDis[unvisited[i]] < tempShortest)
			{//closer than previous record
				currentNode = unvisited[i]; //tentativly move here unless we find a closer one later
				tempShortest = nodeDis[unvisited[i]];
			}
		}
		//a new currentNode should have been picked
		if (currentNode == prevNode)
		{//stuck in a loop, probably an unreachable point
			return [0,0];
		}
		prevNode = currentNode;
		remove(currentNode);
	}
	//shortest route found
	//var returnTemp = nodeDis[endNode] + " ft, " + path[endNode];
	
	var returnTemp = [nodeDis[endNode], path[endNode]];
	//return path[endNode];
	return returnTemp;
}


function findClosestNode(lat, long)
{
	var closestNode;
	var smallestDis = 99999;
	var dis = 0;
	node.forEach(function(i)
	{
		dis = haversine(lat, long, i[1], i[2]);
		if (dis < smallestDis) 
		{
			smallestDis = dis;
			closestNode = i[0];
		}
	});
	return closestNode;
}

function highlightNode(nodeId)
{//given a node id find it's poi, highlight it, and record it for later resetting
	poiName=window["poi_"+node[nodeId][3]];
	HighlightOn(poiName);
	changedPois.push(poiName);
}
function unhighlightNode(nodeId)
{//given a node id find it's poi, highlight it, and record it for later resetting
	poiName=window["poi_"+node[nodeId][3]];
	HighlightOff(poiName);
	removeFromArray(changedPois, poiName);
}

function clickRoute(lat, long)
{//clicking on map while in route mode
	var results = [];
	closestNode = findClosestNode(lat, long); 
	highlightNode(closestNode); //highlight this node's poi
	
	if (startNode == -1)
	{//this is the start node
		startNode = closestNode;
		sideBar.innerHTML = "Start: "+node[startNode][4]+", "+node[startNode][1]+", "+node[startNode][2];
	}
	else
	{//this is the end node
		if (endNode >= 0) {unhighlightNode(endNode);} //turn off previous highlight
		endNode = closestNode;
		results = findShortestRoute(startNode, endNode, totalNodes);
		
		sideBar.innerHTML = "Start: "+node[startNode][4]+", "+node[startNode][1]+", "+node[startNode][2];
		sideBar.innerHTML += "<br> End: "+node[endNode][4]+", "+node[endNode][1]+", "+node[endNode][2];
		sideBar.innerHTML += "<br> Dis: "+results[0]+" ft, "+FeetToMiles(results[0])+" mi ";
		sideBar.innerHTML += "<br> Route: "+results[1];
		
		processResults(results[1]);
		highlightNode(startNode);
		highlightNode(endNode);
	}
}

function processResults(path)
{//take the string of nodes "3:4:8:9" and present it in sidebar
	unhighlightRoute();
	var nodes = path.split(":");
	for (var i=0; i<=nodes.length-1; i++)
	{
		var thisNode = node[nodes[i]];
		
		if (i>0)
		{
			var key = nodes[i]+":"+nodes[i-1];
			var thisId = pairId[key];
			var routeName = window["route_"+thisId];
			var miles = FeetToMiles(routeName.options.distance);
			routeName.setStyle({ color: '#0f0' });
			changedRoutes.push(routeName);
			
			sideBar.innerHTML += "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			sideBar.innerHTML += routeName.options.name+": "+miles+" mi";
			
		}
		sideBar.innerHTML += "<br>&nbsp;&nbsp;&nbsp;"+thisNode[0]+" "+thisNode[1]+" "+thisNode[2]+" "+thisNode[3]+" "+thisNode[4];
	}
}

function unhighlightRoute()
{//undo path highlighting
	for (var i=0; i<=changedRoutes.length-1; i++)
	{
		var routeName = changedRoutes[i];
		var tempColor = routeName.options.defaultColor;
		routeName.setStyle({ color: tempColor });
	}
	changedRoutes = []
}

function unhighlightPois()
{
	for (var i=0; i<=changedPois.length-1; i++)
	{
		var poiName = changedPois[i];
		HighlightOff(poiName);
	}
	changedPois = []
}
