/* k11hex.c
   by Johnny Billquist.
   Used to convert to/from .hex files.
*/
#include <stdio.h>

$$narg=1;

main()
{
  char ifile[20],ofile[20],enc[20];
  printf("Input file:");
  gets(ifile);
  printf("Output file:");
  gets(ofile);
  do {
    printf("Encode/Decode ?");
    gets(enc);
    enc[0] = toupper( enc[0] );
  } while ( enc[0] != 'E' && enc[0] != 'D' );
  if ( enc[0] == 'E' ) encode(ifile,ofile);
  else decode(ifile,ofile);
}

encode(ifile,ofile)
char* ifile,ofile;
{
  FILE *ff,*tf;
  int tmp;
  int i;
  long int cksum;

  if (( ff = fopen(ifile,"rn")) == NULL ) {
    perror("Error opening %s",ifile);
    exit(2);
  }
  if (( tf = fopen(ofile,"w")) == NULL ) {
    perror("Error creating %s",ofile);
    exit(2);
  }

  do {
    cksum=0;
    for (i=0;i<32;i++) {
      cksum += tmp=getc(ff);
      if (feof(ff)) goto done;
      fprintf(tf,"%02X",tmp);
    }
    fprintf(tf,":%06lX\n",cksum);
  } while (TRUE);
  done:
  fclose(ff);
  fclose(tf);
  printf("Done.\n");
}

decode(ifile,ofile)
char* ifile,ofile;
{
  FILE *ff,*tf;
  long int cksum,c2sum;
  int buff[32];
  int i;
  if (( ff = fopen( ifile, "R" )) == NULL ) {
    perror("Could not open %s",ifile);
    exit(2);
  }
  if (( tf = fopen( ofile, "WN" )) == NULL ) {
    perror("Could not create %s",ofile);
    exit(2);
  }
  do {
    cksum = 0;
    for (i=0;i<32;i++) {
      fscanf(ff,"%2x",&buff[i]);
      if (feof(ff)) goto done;
      cksum += buff[i];
    }
    fscanf(ff,":%6lx\n",&c2sum);
    if (cksum != c2sum) {
      printf("Checksum error. %04lX != %04lX\n",cksum,c2sum);
      fclose(ff);
      fclose(tf);
      exit(2);
    }
    for (i=0;i<32;i++) putc(buff[i],tf);
  } while ( TRUE );
  done:
  fclose(ff);
  fclose(tf);
  printf("On RSX systems, make the .TSK file contigoius!\n");
}
