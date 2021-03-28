#include <stdio.h>
#include <string.h>

int is_equal(const char* set_1,int element_1, const char* set_2,int element_2, int n);
int main(){
    extern int n_gram();
	int n;
	char line[1000000];
	FILE* fp = fopen("input.txt", "r");
    if (fp == NULL) return 1;
    while (fgets(line, 1000000, fp) != NULL) {
    	char str_1[1000000];
		char str_2[1000000];
		
        sscanf(line, "%d %s %s", &n, str_1, str_2);
        int result = n_gram(str_1, strlen(str_1), str_2, strlen(str_2), n);
        printf("result: %d\n", result);
    }

    fclose(fp);
    
    
	return 0;
}


int is_equal(const char* set_1,int element_1, const char* set_2,int element_2, int n){
    int equal_chars = 0;
    int c;
    for (c = 0; c < n; ++c) {
        if(set_1[element_1*n+c] == set_2[element_2*n+c]) equal_chars ++;
    }

    return equal_chars == n;
}
