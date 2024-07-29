#include <stdio.h>
#include <stddef.h>

typedef struct {
    int a;
    int b;
    int c;
    size_t d;
} ExampleStruct;

int main() {
    printf("Size of ExampleStruct: %zu bytes\n", sizeof(ExampleStruct));
    printf("Offset of 'a': %zu\n", offsetof(ExampleStruct, a));
    printf("Offset of 'b': %zu\n", offsetof(ExampleStruct, b));
    printf("Offset of 'c': %zu\n", offsetof(ExampleStruct, c));
    printf("Offset of 'd': %zu\n", offsetof(ExampleStruct, d));
    return 0;
}
