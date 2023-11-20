#include <stdio.h>
#include <stdlib.h>

int fbnc(int n) {
    if (n <= 0) {
        printf("N deve ser um número positivo.\n");
        return 0;
    }

    long long int a = 0, b = 1, temp;

    if (n == 1) {
        printf("0\n");
        return 0;
    }

    printf("0 1 ");

    for (int i = 2; i < n; ++i) {
        temp = a + b;
        if (temp >= n) {
            break;  // Sai do loop quando atinge ou ultrapassa o valor N
        }
        printf("%lld ", temp);
        a = b;
        b = temp;
    }

    printf("\n");
}
