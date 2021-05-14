#include <stdio.h>
#include <stdlib.h>

float libseno(float);
float libcoseno(float);

int main(int argc, char** argv) {
    float x = 1.0;
    printf("El valor de sen(%f) es: %f\n",x,libseno(x));
    printf("El valor de cos(%f) es: %f\n",x,libcoseno(x));
    
    return (EXIT_SUCCESS);
}
