#include <iostream>
#include <fstream>

using namespace std;

int N, M, counter = 0;

void path(int i, int j, char **maze, bool **visited, int &count)
{
    if (!visited[i][j])
        count++;
    visited[i][j] = true;
    if (j < M - 1 && maze[i][j + 1] == 'L')
        path(i, j + 1, maze, visited, count);
    if (j > 0 && maze[i][j - 1] == 'R')
        path(i, j - 1, maze, visited, count);
    if (i < N - 1 && maze[i + 1][j] == 'U')
        path(i + 1, j, maze, visited, count);
    if (i > 0 && maze[i - 1][j] == 'D')
        path(i - 1, j, maze, visited, count);
}

int main(int argc, char **argv)
{
    char **maze;
    bool **visited;
    char *ptr1;
    bool *ptr2;

    std::ifstream indata;
    indata.open(argv[1]);
    indata >> N;
    indata >> M;

    int len1 = sizeof(char *) * N + sizeof(char *) * M * N;
    int len2 = sizeof(bool *) * N + sizeof(bool *) * M * N;

    maze = (char **)malloc(len1);
    visited = (bool **)malloc(len2);

    ptr1 = (char *)(maze + N);
    ptr2 = (bool *)(visited + N);

    for (int i = 0; i < N; i++)
    {
        maze[i] = ptr1 + M * i;
        visited[i] = ptr2 + M * i;
    }

    for (int i = 0; i < N; i++)
        for (int j = 0; j < M; j++)
            indata >> maze[i][j];

    for (int i = 0; i < N; i++)
        for (int j = 0; j < M; j++)
            visited[i][j] = false;

    for (int j = 0; j < M; j++)
    {
        if (maze[0][j] == 'U')
        {
            int count_path = 0;
            path(0, j, maze, visited, count_path);
            counter = counter + count_path;
        }
        if (maze[N - 1][j] == 'D')
        {
            int count_path = 0;
            path(N - 1, j, maze, visited, count_path);
            counter = counter + count_path;
        }
    }

    for (int i = 0; i < N; i++)
    {
        if (maze[i][0] == 'L')
        {
            int count_path = 0;
            path(i, 0, maze, visited, count_path);
            counter = counter + count_path;
        }
        if (maze[i][M - 1] == 'R')
        {
            int count_path = 0;
            path(i, M - 1, maze, visited, count_path);
            counter = counter + count_path;
        }
    }

    cout << M * N - counter << endl;
    return 0;
}
