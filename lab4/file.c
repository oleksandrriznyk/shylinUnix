#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main() {
  int fdesc = open("file.txt", O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
  char buffer[10] = "text";
  write(fdesc,buffer,10);
  close(fdesc);
}
