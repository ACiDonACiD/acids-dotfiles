#include <stdio.h>
#include <stdlib.h>

int main() {
	FILE *fp;
	printf("Opening file\n");
	fp = fopen("example.txt", "r");
	if (fp == NULL) {
		printf("Error opening file\n");
		exit(EXIT_FAILURE);
	}
	fclose(fp);
	exit(EXIT_SUCCESS);
}
