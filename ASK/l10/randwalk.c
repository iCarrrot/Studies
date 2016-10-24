/*
 * Random walk optimized to make branch predictor less miserable.
 *
 * $ ./randwalk -n 7 -s 15 -t 14 -v 0
 * Time elapsed: 5.788484 seconds.
 * $ ./randwalk -n 7 -s 15 -t 14 -v 1
 * Time elapsed: 3.687406 seconds.
 */

#include "common.h"

void fill(uint8_t *dst, int n) {
  for (int i = 0; i < n * n; i++)
    dst[i] = rand();
}

int randwalk1(uint8_t *arr, int n, int len) {
  int i, j, k = 0;
  int sum = 0;
  uint64_t dir = 0;

  i = fast_random() % n;
  j = fast_random() % n;

  do {
    k -= 2;
    /* This branch is quite predictable. Don't bother optimizing it! */
    if (k < 0) {
      k = 62;
      dir = fast_random();
    }

    sum += arr[i * n + j];

    /* 
     * We must avoid unpredictable branches in tight loops!
     *
     * GCC is not smart enough to translate following code using cmov
     * instructions. If that's not done, then branch predictor will suffer. 
     */
    switch ((dir >> k) & 3) {
      case 0:
        if (i > 0)
          i--;
        break;
      case 1:
        if (i < n - 1)
          i++;
        break;
      case 2:
        if (j > 0)
          j--;
        break;
      case 3:
        if (j < n - 1)
          j++;
        break;
    }
  } while (--len);

  return sum;
}

int randwalk2(uint8_t *arr, int n, int len) {
  int i, j, k = 0;
  int sum = 0;
  uint64_t dir = 0;

  i = fast_random() & (n - 1);
  j = fast_random() & (n - 1);

  do {
    k -= 2;
    if (k < 0) {
      k = 62;
      dir = fast_random();
    }

    sum += arr[i * n + j];
//czas bez optymalizacji:4.34s, po optymalizacji: 2,61s
   /* i-=(((dir==0 ) + (i>0))&2)>>1;
    i+=(((dir==1)+(i<n-1))&2)>>1;
    j-+(((dir==2)+(j>0))&2)>>1;
    j+=(((dir==3)+(j<n-1))&2)>>1;*/


 //Druga wersja, wydaje się że może być szybsza, ale (przynajmniej u mnie) nie jest (5.40s)
		asm("nop;nop");
		int x = n - 1 ;
		int y = (dir >> k) & 3;

		int a[4]= {i > 0, i < x, j > 0, j < x};
		int b[4] = { y == 0, y == 1, y == 2, y == 3};

		i -= a[0]&b[0];
		i += a[1]&b[1];
		j -= a[2]&b[2];
		j += a[3]&b[3];
		asm("nop;nop");
		

  } while (--len);

  return sum;
}

int main(int argc, char **argv) {
  int opt, size = -1, steps = -1, times = -1, var = -1;
  bool err = false;

  while ((opt = getopt(argc, argv, "n:s:t:v:")) != -1) {
    if (opt == 'n')
      size = 1 << atoi(optarg);
    else if (opt == 's')
      steps = 1 << atoi(optarg);
    else if (opt == 't')
      times = 1 << atoi(optarg);
    else if (opt == 'v')
      var = atoi(optarg);
    else
      err = true;
  }

  if (err || size < 0 || steps < 0 || times < 0 || var < 0 || var >= 2) {
    fprintf(stderr, "Usage: %s -n log2(size) -l log2(length) -t log2(times) "
                    "-v variant\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  uint8_t *array = NULL;

  posix_memalign((void **)&array, getpagesize(), size * size);

  printf("Generate matrix %d x %d (%d KiB)\n", size, size, size * size >> 10);

  fill(array, size);
  flush_cache();

  printf("Performing %d random walks of %d steps.\n", times, steps);

  _timer_t timer;
  timer_reset(&timer);
  timer_start(&timer);
  for (int i = 0; i < times; i++) {
    if (var == 0)
      randwalk1(array, size, steps);
    else
      randwalk2(array, size, steps);
  }
  timer_stop(&timer);
  timer_print(&timer);

  free(array);

  return EXIT_SUCCESS;
}
