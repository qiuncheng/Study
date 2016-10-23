#include <stdio.h>


/**
	相关操作：
		1. initList
		2. ListEmpty
		3. ClearList
		4. GetElem
*/
#define MAXSIZE 200
typedef int DataType;
typedef int Status;
#define OK 1
#define ERROR 0

typedef struct {
	int length;
	DataType data[MAXSIZE];
}Sqlist;

Status initList(Sqlist *L) {
	L->length = 0
	return OK;
}
int location(Sqlist L, DataType x) {
	int i = 1;
	while (L.data[i-1] != x) {
		i++;
	}
	if (i < L.length)
		return i;
	else 
		return ERROR;	
}

void insertList(Sqlist L, DataType x, int i) {
	if (i < 1 || i > L.length + 1) {
		return ERROR;
	}
	int j;
	for (j = L.length - 1; j >= i; j--) {
		L.data[j] = L.data[j - 1];
		L.data[i - 1] = x;
	}
	++ L.length;
	return OK;
}



int main(int argc, char *argv[]) {
	
}