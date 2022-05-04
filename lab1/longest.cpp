#include <iostream>
#include <fstream>

// Algorithm inspired by
// www.geeksforgeeks.org/longest-subarray-having-average-greater-than-or-equal-to-x-set-2/

using namespace std;

int main(int argc, char* argv[])
{
  ifstream indata;
  int M, N;
  indata.open(argv[1]);
  indata >> M ;
  int count = 1;
  while(count < 2)
  {
    indata >> N;
    count++;
  }
  int a[M];
  int i = 0;
  while(i < M)
  {
    indata >> a[i];
    i++;
  }
  indata.close();

  int size = M;
  int prefix[size];
  int b[size];
  for (int i = 0; i < size; i ++)
    b[i] = -a[i] - N;
  for (int i = 0; i < size; i++)
    prefix[i] = (i == 0 ? b[i] : prefix[i-1] + b[i]);


  int max_from_start = 0;

  for (int i = 0; i < size; i++)
    if (prefix[i] >= 0)
      max_from_start = i + 1;

  int left[size];

  for (int i = 0; i < size; i++)
    left[i] = ((i == 0) ? prefix[i] : min(prefix[i], left[i-1]));

  int right[size];

  for (int i = size-1; i > -1; i--)
    right[i] = ((i == size - 1) ? prefix[i] : max(prefix[i], right[i+1]));

  int index_1 = 0, index_2 = 0;
  int max_so_far = 0;

  while( index_1 != size - 1 || index_2 != size - 1 )
  {
    if (left[index_1] >= right[index_2])
       ++index_1;
    else
    {
      max_so_far = max(index_2 - index_1 , max_so_far);
      if (index_2 == size -1)
        ++index_1;
      else
        ++index_2;
    }
  }

  cout << max(max_so_far,max_from_start)<< "\n";
  return 0;
}
