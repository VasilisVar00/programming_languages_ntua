import sys
from array import *

maze = []
visited = []
counter = 0
filename = sys.argv[1]
myList = open(filename, "r").readlines()

N, M = map(int, myList[0].split())

for i in range(1, N + 1):
        maze.append(array('u', myList[i]))

for i in range(N):
    myList = list()
    for j in range(M):
        myList.append(0)
    visited.append(array('i', myList))

def path (n, m, maze, visited):
    dim = -1
    myList = list()
    visited[n][m] = 1
    while True:
            if m < M - 1 and maze[n][m + 1] == 'L':
                visited[n][m + 1] = 1
                myList.append((n, m + 1))
            if m > 0 and maze[n][m - 1] == 'R':
                visited[n][m - 1] = 1
                myList.append((n, m - 1))
            if n < N - 1 and maze[n + 1][m] == 'U':
                visited[n + 1][m] = 1
                myList.append((n + 1, m))
            if n > 0 and maze[n - 1][m] == 'D':
                visited[n - 1][m] = 1
                myList.append((n - 1, m))
            dim = dim + 1
            if dim >= len(myList):
                break
            myTuple = myList[dim]
            n = myTuple[0]
            m = myTuple[1]

def print_arr (n, m, arr):
    for i in range(n):
        for j in range(m):
            print(arr[i][j], end = " ")
        print()
    print()

for j in range(M):
    if maze[0][j] == 'U':
        path(0, j, maze, visited)
    if maze[N - 1][j] == 'D':
        path(N - 1, j, maze, visited)

for i in range(N):
    if maze[i][0] == 'L':
        path(i, 0, maze, visited)
    if maze[i][M - 1] == 'R':
        path(i, M - 1, maze, visited)

counter = 0

for i in range(N):
    for j in range(M):
        if visited[i][j] == 0:
            counter = counter + 1

print(counter)
print()
