from math import inf


def measure(b1, b2, goal, start_bucket):
    '''
    Create a graph, each node is a state of buckets
    and is linked to reachable states with allowed operations
    search the shortest path from the initial node do the
    goal node, which is a node that contains the goal
    quantity either in bucket one or two.
    '''
    # start state
    if start_bucket == 'one':
        start = (b1, 0)
        # the oposite state is not allowed
        remove = (0, b2)
    else:
        start = (0, b2)
        remove = (b1, 0)

    states = ((i, j) for i in range(b1+1) for j in range(b2+1) if (i, j) != remove)
    # adjacency list
    graph = {state: possible_states(state, b1, b2, remove) for state in states}
    not_visited = list(graph.keys())
    visited = []
    # {node: [distance, from]...}
    distances = {node: (inf, None) for node in graph}
    # distance to start from start is 1 because first step is to fill it
    distances[start] = (1, None)
    # calculate distances from start using dijkstra
    result = dijkstra(graph, start, not_visited, visited, distances)
    # filter out irrelevant nodes
    goal_nodes = [(node, distance) for node, distance in result.items()
                  if (node[0] == goal
                  or node[1] == goal)]
    # min by distance
    buckets, distance = min(goal_nodes, key=lambda e: e[1][0])
    # print the path used to reach the result
    print(get_path(result, buckets))
    if buckets[0] == goal:
        return (distance[0], 'one', buckets[1])
    return (distance[0], 'two', buckets[0])


def dijkstra(graph, current, not_visited, visited, distances):
    '''
    Calculate shortest distance to every
    other node from the starting point
    '''
    if current in not_visited:
        visited.append(not_visited.pop(not_visited.index(current)))
        distance = distances[current][0] + 1
        for node in graph[current]:
            if distance < distances[node][0]:
                distances[node] = (distance, current)
        neighbors = [node for node in graph[current] if node in not_visited]
        for neighbor in neighbors:
            dijkstra(graph, neighbor, not_visited, visited, distances)
    return distances


def possible_states(current_state, b1_size, b2_size, remove):
    b1, b2 = current_state
    states = [(0, b2),  # empty b1
              (b1, 0),  # emty b2
              (b1_size, b2),  # fill b1
              (b1, b2_size),  # fill b2
              transfer(b1, b2, b2_size),
              transfer(b2, b1, b1_size)[::-1]]
    return [(i, j) for i, j in states if (i, j) not in [remove, current_state]]


def transfer(b1, b2, b2_size):
    '''
    transfer from b1 to b2
    everything or all that's possible
    '''
    total = b1 + b2
    if total // b2_size:
        b2 = b2_size
        b1 = total - b2_size
    else:
        b2 = total
        b1 = 0
    return (b1, b2)


def get_path(distances, node):
    result = [node]
    _, prev_node = distances[node]
    while prev_node:
        result.append(prev_node)
        _, prev_node = distances[prev_node]
    return result[::-1]
