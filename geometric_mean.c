#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define ARRAY_SIZE 1000000

double compute_geometric_mean(double* array, int size) {
    double log_sum = 0.0;
    for (int i = 0; i < size; ++i) {
        if (array[i] > 0) {
            log_sum += log(array[i]);
        } else {
            return 0.0;
        }
    }
    return exp(log_sum / size);
}

int main() {
    double* data = (double*)malloc(sizeof(double) * ARRAY_SIZE);
    if (!data) {
        printf("Memory allocation failed\n");
        return 1;
    }

    for (int i = 0; i < ARRAY_SIZE; ++i) {
        data[i] = (rand() % 1000 + 1) / 10.0;
    }

    clock_t start = clock();
    double result = 0.0;
    for (int i = 0; i < 100; ++i) {
        result = compute_geometric_mean(data, ARRAY_SIZE);
    }
    clock_t end = clock();
    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;

    printf("Geometric mean: %.5f\n", result);
    printf("Execution time: %.5f seconds\n", time_spent);

    free(data);
    return 0;
}