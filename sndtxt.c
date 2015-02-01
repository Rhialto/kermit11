#include <stdio.h>

main()
{
  FILE *f1,*f2,*f3;
  char line[80];
  int i;

  if ((f1=fopen("k11pos.hex","r")) == NULL) {
    printf("Error opening input file...\n");
    exit(2);
  }
  if ((f2=fopen("TT55:","w")) == NULL) {
    printf("Error opening terminal for output.\n");
    exit(2);
  }
  if ((f3=fopen("TT55:","r")) == NULL) {
    printf("Error opening terminal for input.\n");
    exit(2);
  }

  i=0;

  while (!feof(f1)) {
    fgets(line,80,f1);
    fputs(line,f2);
    fgets(line,80,f3);
    printf("%d lines sent.\n",i++);
  }
  fclose(f1);
  fclose(f2);
  fclose(f3);
}
