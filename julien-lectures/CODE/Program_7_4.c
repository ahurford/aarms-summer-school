/* ****************************************************************

This is the C version of program 7.4 from page 260 of
"Modeling Infectious Disease in humans and animals"
by Keeling & Rohani.
 
It is the forest-fire model on a grid of size SizexSize, we also
assume wrap-around boundaries.
 
For simplicity we set MAXxMAX to be the largest grid size it is 
possible to have -- this can easily be altered.

This code is written to be simple, transparent and readily compiled.
Far more elegant and efficient code can be written.

This code can be compiled using gnu or intel C compilers:
icc -o Program_7_4  Program_7_4.c  -lm
g++ -o Program_7_4  Program_7_4.c  -lm

If you have any difficulties, we suggest you set DEBUG to 1 or -1

******************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

// Maximum number of subpopulations
#define MAX 100

// Set DEBUG to 1 to output some debugging information
// Set DEBUG to -1 to output more debugging information
#define DEBUG 1

// Set up basic parameters
int Size=50;
double tau=1.0;
double gamm=0.1;
double nu=0.01;
double epsilon=1e-3;
double timestep=0.1;
double MaxTime=1000;

// Set up variables and rates of change
double t;
int Status[MAX][MAX]; // 0=Susceptible, 1=Infected, 2=Empty
double Rate[MAX][MAX];

int Is_Inf(int i, int j)
{
  if(i<0) i+=Size;
  if(i>=Size) i-=Size;

  if(j<0) j+=Size;
  if(j>=Size) j-=Size;

  if(Status[i][j]==1) return 1;
  else return 0;
}

int Num_Inf_Nbrs(int i, int j)
{
  return Is_Inf(i-1,j)+Is_Inf(i+1,j)+Is_Inf(i,j-1)+Is_Inf(i,j+1);
}


// Initialise the equations and Runge-Kutta integration
double Iterate()
{
  int i,j;
  double Step,Sum,Rand;

  if(timestep==0) // Asynchronous Updating
    {
      for(i=0;i<Size;i++)
	{
	  for(j+0;j<Size;j++)
	    {
	      Sum+=Rate[i][j];
	    }
	}
      Rand=Sum*drand48(); i=j=0;
      while(Rand>Rate[i][j])
	{
	  Rand-=Rate[i][j];
	  j++;
	  if(j==Size)
	    {
	      j=0;
	      i++;
	    }
	}
      
      // Update Status and Rates
      
      Status[i][j]++;
      if(Status[i][j]>2) Status[i][j]=0;

      if(Status[i][j]==0)
	{
	  Rate[i][j]=tau*Num_Inf_Nbrs(i,j) + epsilon;
	}
      if(Status[i][j]==1)
	{
	  Rate[i][j]=gamm;
	}
      if(Status[i][j]==2)
	{
	  Rate[i][j]=nu;
	  if(i<0) Rate[i+Size-1][j]-=tau;
	  else Rate[i-1][j]-=tau;

	  if(i>=Size) Rate[i+1-Size][j]-=tau;
	  else Rate[i+1][j]-=tau;
	  
	  if(j<0) Rate[i][j+Size-1]-=tau;
	  else Rate[i][j-1]-=tau;

	  if(j>=Size) Rate[i][j+1-Size]-=tau;
	  else Rate[i][j+1]-=tau;
	}
      Step=-log(drand48())/Sum;
    }
  else
    {
      // Do the Events
      for(i=0;i<Size;i++)
	{
	  for(j=0;j<Size;j++)
	    {
	      if(drand48()<1-exp(-Rate[i][j])) 
		{
		  Status[i][j]++;
		  if(Status[i][j]>2) Status[i][j]=0;
		}
	    }
	}
      //Now Update the Rates
       for(i=0;i<Size;i++)
	{
	  for(j=0;j<Size;j++)
	    {
	      if(Status[i][j]==0) Rate[i][j]=tau*Num_Inf_Nbrs(i,j) + epsilon;
	      if(Status[i][j]==1)  Rate[i][j]=gamm;
	      if(Status[i][j]==2)  Rate[i][j]=nu;
	    }
	}
       Step=timestep;
    }

  return Step;
}


void Read_in_parameters(FILE *);
void Perform_Checks();
void Output_Data(FILE *);


// The main program

int main(int argc, char** argv)
{
  char FileName[1000];
  int i,j;
  double step, Every, tmp;
  double TotalS, TotalI;
  FILE *in, *out;
   
  /* Find the given parameter  file name and open the file 
     otherwise use parameters set at top of program */
  if(argc>1)
    {
      strcpy(FileName, *(argv+1));  
      
      if((in = fopen(FileName,"r"))==NULL)
	{
	  printf("Cannot read file %s\n",FileName);
	  exit(1);
	}

      /* Read in the parameters */
      
      Read_in_parameters(in);

      if(DEBUG) printf("\nReading parameters from file %s\n",FileName);
    }
  else
    {
      if(DEBUG) printf("\nSetting default parameters\n");	 
    }

  /* Check all parameters are OK & set up intitial conditions */

  Perform_Checks();
  for(i=0;i<Size;i++)
     {
       for(j=0;j<Size;j++)
	 {
	   Status[i][j]=0;
	   Rate[i][j]=epsilon;
	 }
     }
  
  Every=1.0;
 
  if((out = fopen("Output","w"))==NULL)
    {
      printf("Cannot open file Output to write data\n");
      exit(1);
    }

  /* The main iteration routine */

  t=0;

  Output_Data(out);

  do
    {
      step=Iterate();  t+=step;
      
      /* If time has moved on sufficiently, output the current data */
      if( floor(t/Every) > floor((t-step)/Every) )
	{
	  Output_Data(out);
	}
      else
	{
	  if(DEBUG<0) Output_Data(stdout);
	}
      
    }
  while(t<MaxTime);

  Output_Data(out);

  fclose(out);
}



void Read_in_parameters(FILE *in)
{
  int i,j;
  char str[200];

  fscanf(in,"%s",str);
  fscanf(in,"%d",&Size);
  if(Size>MAX) {printf("Size of grid (%d x %d) exceeds the predefined maximum\n",Size,Size); exit(1);}
  
  fscanf(in,"%s",str);
  fscanf(in,"%lf",&tau);
    
  fscanf(in,"%s",str);
  fscanf(in,"%lf",&gamm);
    
  fscanf(in,"%s",str);
  fscanf(in,"%lf",&nu);

  fscanf(in,"%s",str);
  fscanf(in,"%lf",&epsilon);

  fscanf(in,"%s",str);
  fscanf(in,"%lf",&timestep);

  fscanf(in,"%s",str);
  fscanf(in,"%lf",&MaxTime);
  
  fclose(in);
  
}


void Perform_Checks()
{
  int i,j;

  if(tau<=0) {printf("ERROR: Transmission rate tau (%g) is less than or equal to zero\n",tau); exit(1);}
  
  if(gamm<=0) {printf("ERROR: Recovery rate gamma (%g) is less than or equal to zero\n",gamm); exit(1);}
  
  if(nu<=0) {printf("ERROR: Birth rate nu (%g) is less than or equal to zero\n",nu); exit(1);}

  if(epsilon<=0) {printf("ERROR: Coupling level rho (%g) is less than or equal to zero\n",rho); exit(1);}

  if(MaxTime<=0) {printf("ERROR: Maximum run time (%g) is less than or equal to zero\n",MaxTime); exit(1);}
}


void Output_Data(FILE *out)
{
  int i,j;
  int Total[3];

  Total[0]=Total[1]=Total[2]=0;
  for(i=0;i<Size;i++)
    {
      for(j=0;j<Size;j++)
	{
	  Total[Status[i][j]]++;
	}
    }
  
  if(out!=stdout) 
    {
      fprintf(out,"%g \t %d %d %d",t,Total[0],Total[1],Total[2]);
      
      //Include this bit to output infection in every cell
      /*for(i=0;i<Size;i++)
	{
	for(j=0;j<Size;j++)
	{
	fprintf(out," %d",Status[i][j]);
	}
	}*/
      fprintf(out,"\n");
    }

    
  if(DEBUG) printf("%g \t %d %d %d\n",t,Total[0],Total[1],Total[2]);
   

  if(DEBUG<0) 
    {
      for(i=0;i<Size;i++)
	{
	  for(j=0;j<Size;j++)
	    {
	      if(Status[i][j]==0) printf("S");
	      if(Status[i][j]==1) printf("I");
	      if(Status[i][j]==2) printf("E");
	    }
	  printf("\n");
	}
    }

}




