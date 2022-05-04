import sys
from array import *
from collections import deque

filename = sys.argv[1]
myList = open(filename,'r').readlines()
mystring = myList[1].replace("\n", "")
new_list = mystring.split(" ")
str1 = myList[0].replace("\n", "")
N = int(str1)

queue = [int(i) for i in new_list]
stack = []
res = ""


init = queue, stack, res


def next(q):
    list =[]
    if q[0]:
        result = q[2] + "Q"
        list.append ((q[0][1:], q[1] + [q[0][0]], result))

    if q[1]:
        result = q[2] + "S"
        list.append((q[0] + [q[1][-1]], q[1][:-1],result))
    return list

Q = deque([init])
visited = set()
solved = False

while Q:
    q = Q.popleft()
    if sorted(q[0]) == q[0] and not q[1]:

        solved = True
        break
    for t in next(q):
        tr = tuple(t[0]), tuple(t[1])
        if hash(tr) not in visited:
            Q.append(t)
            visited.add(hash(tr))


if solved:
    if not q[2]:
        print("empty")
    else:
        print(q[2])
