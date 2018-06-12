#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>

int main(int argc, char **argv){
(void)argc;
if(argc != 3){
	write(2,"err\n",4);
	exit(1);
}

int fd;
if((fd = open(argv[1], O_RDONLY)) == -1){
	write(2,"err\n",4);
	exit(1);
}

int mid;
int start = 0;

mid = lseek(fd, 0, SEEK_END); 
int end = mid;
char* word = malloc(sizeof(char)*1);

while( start < end){

mid = start+(end-start)/2;

char c;
lseek(fd, mid, SEEK_SET);
int counter = 0;
while(read(fd, &c, 1) &&  c != '\0'){
	lseek(fd, -2, SEEK_CUR);
}
while(read(fd, &c, 1) && c != '\n')
{
    counter++;
}

lseek(fd,-(counter+1), SEEK_CUR);
word = realloc(word, counter);

int j = 0;
while(read(fd, &c, 1) && c != '\n')
{
 word[j] = c;
 j++; 
}
word[counter] = '\0';

if(strcmp(argv[2], word) == 0){
		while(read(fd, &c, 1) && c != '\0')
		{
		   write(1, &c, 1);
		}
		free(word);
		exit(0);
}
if(strcmp(argv[2], word) < 0){
	end=mid-1;
}
if(strcmp(argv[2], word) > 0){
	start=mid+1;
}
}
write(2, "No such word\n", 13);
free(word);
close(fd);
exit(0);
}
