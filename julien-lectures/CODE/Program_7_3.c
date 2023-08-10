/* ****************************************************************

This is the C version of program 7.3 from page 256 of
"Modeling Infectious Disease in humans and animals"
by Keeling & Rohani.
 
It is the simple SIR epidemic on an SizexSize lattice with coupling (rho) to
4 nearest neighbour. nI defines the number of lattice sites (chosen
randomly) that start with some infection.
 
For simplicity we set MAXxMAX to be the largest number of subpopulations it is 
possible to have -- this can easily be altered.

This code is written to be simple, transparent and readily compiled.
Far more elegant and efficient code can be written.

This code can be compiled using gnu or intel C compilers:
icc -o Program_7_3  Program_7_3.c  -lm
g++ -o Program_7_3  Program_7_3.c  -lm

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
double beta=1.0;
double gamm=0.1;
double nu;
double mu=0.0001;
double rho=0.1;
double X0=0.1;
int nI=4;
double N=1.0;

double MaxTime=2910;

// Set up variables and rates of change
double t,X[MAX][MAX],Y[MAX][MAX],Pop[2*MAX*MAX];
double dPop[2*MAX*MAX];

// Initialise the equations and Runge-Kutta integration
void Diff(double Pop[2*MAX*MAX])
{
  int i,j,k;
  // Set up temporary variables to make the equations look neater
  double tmpX[MAX][MAX],tmpY[MAX][MAX], tmpdX[MAX][MAX], tmpdY[MAX][MAX];
  double tmp_N_denom[MAX][MAX];
  double FoI;

  for(i=0;i<Size;i++)
    {
      for(j=0;j<Size;j++)
	{
	  k=2*(i*Size+j);
	  tmpX[i][j]=Pop[k];
	  tmpY[i][j]=Pop[k+1];
	}
    }

  /*Calculate the denominator. Note in theory this calculation
    could just be performed once, given that N remains constant
    howwever we have included it here for completeness. */
  for(i=0;i<Size;i++)
    {
      for(j=0;j<Size;j++)
	{
	  tmp_N_denom[i][j]=(1-4*rho)*N;
	  if(i>0) {tmp_N_denom[i][j]+=rho*N;}
	  if(i<Size-1) {tmp_N_denom[i][j]+=rho*N;}
	  if(j>0) {tmp_N_denom[i][j]+=rho*N;}
	  if(j<Size-1) {tmp_N_denom[i][j]+=rho*N;}
	}
    }


  for(i=0;i<Size;i++)
    {
      for(j=0;j<Size;j++)
	{
	  // Internal Dynamics
	  tmpdX[i][j]=nu -beta*(1-4*rho)*tmpX[i][j]*tmpY[i][j]/tmp_N_denom[i][j] - mu*tmpX[i][j];
	  tmpdY[i][j]=beta*(1-4*rho)*tmpX[i][j]*tmpY[i][j]/tmp_N_denom[i][j] -(gamm+mu)*tmpY[i][j];

	  // Interactions with 4 neighours
	  if(i>0) {FoI=beta*tmpX[i][j]*rho*tmpY[i-1][j]/tmp_N_denom[i][j]; tmpdX[i][j]-=FoI; tmpdY[i][j]+=FoI;}
	  if(i<Size-1) {FoI=beta*tmpX[i][j]*rho*tmpY[i+1][j]/tmp_N_denom[i][j]; tmpdX[i][j]-=FoI; tmpdY[i][j]+=FoI;}
	  if(j>0) {FoI=beta*tmpX[i][j]*rho*tmpY[i][j-1]/tmp_N_denom[i][j]; tmpdX[i][j]-=FoI; tmpdY[i][j]+=FoI;}
	  if(j<Size-1) {FoI=beta*tmpX[i][j]*rho*tmpY[i][j+1]/tmp_N_denom[i][j]; tmpdX[i][j]-=FoI; tmpdY[i][j]+=FoI;}

	  k=2*(i*Size+j);
	  dPop[k]=tmpdX[i][j]; 
	  dPop[k+1]=tmpdY[i][j];
	}
    }

  return;
}

void Runge_Kutta(double);
void Read_in_parameters(FILE *);
void Perform_Checks();
void Output_Data(FILE *);


// The main program

int main(int argc, char** argv)
{
  char FileName[1000];
  int i,j;
  double step, Every, tmp;
  double TotalX, TotalY;
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
	   X[i][j]=X0; Y[i][j]=0;
	 }
     }
  // Now infect some random patches
  for(i=0;i<nI;i++)
    {
      Y[(int)floor(Size*drand48())][(int)floor(Size*drand48())]=0.001*X0;
    }

   /* Find a suitable time-scale for outputs */

   
  step=0.1/((beta+gamm+rho));
  Every=pow(10,floor(log10(10.0*step)));
	 
  while(MaxTime/Every>10000)
    {
      Every*=10.0;
    }
  
  if(DEBUG) printf("Using a time step of %g and outputing data every %g\n\n",step,Every);
 

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
      Runge_Kutta(step);  t+=step;
      
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
  fscanf(in,"%lf",&beta);
    
  fscanf(in,"%s",str);
  fscanf(in,"%lf",&gamm);
    
  fscanf(in,"%s",str);
  fscanf(in,"%lf",&mu);

  fscanf(in,"%s",str);
  fscanf(in,"%lf",&rho);

  fscanf(in,"%s",str);
  fscanf(in,"%lf",&X0);

  fscanf(in,"%s",str);
  fscanf(in,"%d",&nI);

  fscanf(in,"%s",str);
  fscanf(in,"%lf",&N);
  
  nu=mu*N;

  fscanf(in,"%s",str);
  fscanf(in,"%lf",&MaxTime);
  
  fclose(in);
  
}


void Perform_Checks()
{
  int i,j;

  if(X0<=0) {printf("ERROR: Initial level of susceptibles (%g) is less than or equal to zero\n",X0); exit(1);}
  
  if(nI<=0) {printf("ERROR: Initial number of infected patches (%d) is less than or equal to zero\n",nI); exit(1);}
  
  if(beta<=0) {printf("ERROR: Transmission rate beta (%g) is less than or equal to zero\n",beta); exit(1);}
  
  if(gamm<=0) {printf("ERROR: Recovery rate gamma (%g) is less than or equal to zero\n",gamm); exit(1);}
  
  if(X0>N) {printf("WARNING: Initial level of susceptibles (%g) is greater than population size (%g)\n",X0,N);}
  
  if(beta<gamm+mu) {printf("WARNING: Basic reproductive ratio (R_0=%g) is less than one\n",beta/(gamm+mu));}

  if(mu<0) {printf("ERROR: Death rate mu (%g) is less than zero\n",mu); exit(1);}
  
  if(rho<0) {printf("ERROR: Coupling level rho (%g) is less than zero\n",rho); exit(1);}

  if(rho>=0.25) {printf("ERROR: Coupling level rho (%g) is greater than or equal to one\n",rho); exit(1);}

  if(MaxTime<=0) {printf("ERROR: Maximum run time (%g) is less than or equal to zero\n",MaxTime); exit(1);}
}


void Output_Data(FILE *out)
{
  int i,j;
  double TotalX, TotalY, NumInf;

  TotalX=TotalY=0;
  for(i=0;i<Size;i++)
    {
      for(j=0;j<Size;j++)
	{
	  TotalX+=X[i][j]; TotalY+=Y[i][j];
	}
    }
  
  if(out!=stdout) 
    {
      fprintf(out,"%g \t %g %g ",t,TotalX,TotalY);
      
      //Include this bit to output infection in every cell
      /*for(i=0;i<Size;i++)
	{
	for(j=0;j<Size;j++)
	{
	fprintf(out," %g",I[i][j]);
	}
	}*/
      fprintf(out,"\n");
    }

    

  if(DEBUG) printf("%g \t %g %g\n",t,TotalX,TotalY);
   

  if(DEBUG<0) printf("%g \t %g %g\n",t,TotalX,TotalY);

}





void Runge_Kutta(double step)
{
  int i,j,k;
  double dPop1[2*MAX*MAX], dPop2[2*MAX*MAX], dPop3[2*MAX*MAX], dPop4[2*MAX*MAX];
  double tmpPop[2*MAX*MAX], initialPop[2*MAX*MAX];

  /* Integrates the equations one step, using Runge-Kutta 4
     Note: we work with arrays rather than variables to make the
     coding easier */

  for(i=0;i<Size;i++)
    {
      for(j=0;j<Size;j++)
	{
	  k=2*(j+i*Size);
	  initialPop[k]=X[i][j]; initialPop[1+k]=Y[i][j];
	}
    }
  
  Diff(initialPop);
  for(i=0;i<2*Size*Size;i++)
    {
      dPop1[i]=dPop[i];
      tmpPop[i]=initialPop[i]+step*dPop1[i]/2;
    }

  Diff(tmpPop);
  for(i=0;i<2*Size*Size;i++)
    {
      dPop2[i]=dPop[i];
      tmpPop[i]=initialPop[i]+step*dPop2[i]/2;  
    }

  Diff(tmpPop);
  for(i=0;i<2*Size*Size;i++)
    {
      dPop3[i]=dPop[i];
      tmpPop[i]=initialPop[i]+step*dPop3[i]; 
    }

  Diff(tmpPop);

  for(i=0;i<2*Size*Size;i++)
    {
      dPop4[i]=dPop[i];

      tmpPop[i]=initialPop[i]+(dPop1[i]/6 + dPop2[i]/3 + dPop3[i]/3 + dPop4[i]/6)*step;
    }

  for(i=0;i<Size;i++)
    {
      for(j=0;j<Size;j++)
	{
	  k=2*(j+i*Size);
	  X[i][j]=tmpPop[k]; Y[i][j]=tmpPop[1+k];
	}
    }
  
  return;
}
