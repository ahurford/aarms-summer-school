/* ****************************************************************

This is the C version of program 7.1 from page 241 of
"Modeling Infectious Disease in humans and animals"
by Keeling & Rohani.

It is the  SIR epidemic in a metapopulation. For simplicity we set MAX 
to be the largest number of subpopulations it is possible to have -- this 
can easily be altered.

This code is written to be simple, transparent and readily compiled.
Far more elegant and efficient code can be written.

This code can be compiled using gnu or intel C compilers:
icc -o Program_7_1  Program_7_1.c  -lm
g++ -o Program_7_1  Program_7_1.c  -lm

If you have any difficulties, we suggest you set DEBUG to 1 or -1

******************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

// Maximum number of subpopulations
#define MAX 20

// Set DEBUG to 1 to output some debugging information
// Set DEBUG to -1 to output more debugging information
#define DEBUG 0

// Set up basic parameters
int N;
double beta[MAX];
double gamm[MAX];
double mu[MAX];
double nu[MAX];
double S0[MAX];
double I0[MAX];

double m[MAX][MAX];

double MaxTime;

// Set up variables and rates of change
double t, S[MAX],I[MAX],Pop[2*MAX];
double dPop[2*MAX];

// Initialise the equations and Runge-Kutta integration
void Diff(double Pop[2*MAX])
{
  int i,j;
  // Set up temporary variables to make the equations look neater
  double tmpS, tmpI;

 
  for(i=0;i<N;i++)
    {
      tmpS=Pop[2*i]; tmpI=Pop[1+2*i];

      /* The differential equations */

       // First do within population stuff
      dPop[2*i] = nu[i] - beta[i]*tmpS*tmpI - mu[i]*tmpS;              // dS/dt
      dPop[1+2*i] = beta[i]*tmpS*tmpI - gamm[i]*tmpI -mu[i]*tmpI;        // dI/dt

      // Now do the movement rates
      for(j=0;j<N;j++)
	{
	  dPop[2*i]+=m[i][j]*Pop[2*j] - m[j][i]*tmpS;
	  dPop[1+2*i]+=m[i][j]*Pop[1+2*j] - m[j][i]*tmpI;
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
      
      printf("\nReading parameters from file %s\n",FileName);
	
    }
  else
    {
      if(DEBUG) printf("\nSetting default parameters\n");
	
      N=5;
      for(i=0;i<N;i++)
	{
	  beta[i]=1;
	  gamm[i]=0.1;
	  nu[i]=0.0001;
	  mu[i]=0.0001;
	  for(j=0;j<N;j++)
	    {
	      m[i][j]=0.01;
	    }
	  m[i][i]=0;
	  S0[i]=0.1;
	  I0[i]=0;
	}
      I0[0]=0.0001;
      MaxTime=2190;
    }

  /* Check all parameters are OK & set up intitial conditions */

  Perform_Checks();
  for(i=0;i<N;i++)
    {
      S[i]=S0[i]; I[i]=I0[i];
    }
  
  /* Find a suitable time-scale for outputs */

   step=1e100;
   for(i=0;i<N;i++)
     {
       tmp=0;
       for(j=0;j<N;j++)
	 {
	   tmp+=m[i][j];
	 }
       tmp=0.01/((beta[i]+gamm[i]+mu[i]+nu[i]+tmp)*S0[i]);

       if(tmp<step)
	 {
	   step=tmp;
	   Every=pow(10,floor(log10(100.0*tmp)));
	 }
     }
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
  char str[200];
  int i,j;

  fscanf(in,"%s",str);
  fscanf(in,"%d",&N);
  if(N>MAX) {printf("Number of subpopulations N (%d) exceeds the predefined maximum\n",N); exit(1);}
  
  fscanf(in,"%s",str);
  for(i=0;i<N;i++)
    {
      fscanf(in,"%lf",&beta[i]);
    }
  
  fscanf(in,"%s",str);
  for(i=0;i<N;i++)
    {
      fscanf(in,"%lf",&gamm[i]);
    }
  
  fscanf(in,"%s",str);
  for(i=0;i<N;i++)
    {
      fscanf(in,"%lf",&nu[i]);
    }
  
  fscanf(in,"%s",str);
  for(i=0;i<N;i++)
    {
      fscanf(in,"%lf",&mu[i]);
    }
  
  fscanf(in,"%s",str);
  for(i=0;i<N;i++)
    {
      for(j=0;j<N;j++)
	{
	  fscanf(in,"%lf",&m[i][j]);
	}
    }
  
  fscanf(in,"%s",str);
  for(i=0;i<N;i++)
    {
      fscanf(in,"%lf",&S0[i]);
    }
  
  fscanf(in,"%s",str);
  for(i=0;i<N;i++)
    {
      fscanf(in,"%lf",&I0[i]);
    }
  
  fscanf(in,"%s",str);
  fscanf(in,"%lf",&MaxTime);
  
  fclose(in);
}

void Perform_Checks()
{
  int i,j;
  
  for(i=0;i<N;i++)
    {
      if(S0[i]<=0) {printf("ERROR: Initial level of susceptibles_%d (%g) is less than or equal to zero\n",i,S0[i]); exit(1);}
      
      if(I0[i]<0) {printf("ERROR: Initial level of infecteds_%d (%g) is less than zero\n",i,I0[i]); exit(1);}
      
      if(beta[i]<=0) {printf("ERROR: Transmission rate beta_%d (%g) is less than or equal to zero\n",i,beta[i]); exit(1);}
      
      if(gamm[i]<=0) {printf("ERROR: Recovery rate gamma_%d (%g) is less than or equal to zero\n",i,gamm[i]); exit(1);}
      
      if(nu[i]<0) {printf("ERROR: Birth rate nu_%d (%g) is less than zero\n",i,nu[i]); exit(1);}

      if(mu[i]<0) {printf("ERROR: Death rate mu_%d (%g) is less than zero\n",i,mu[i]); exit(1);}
      
      if(S0[i]+I0[i]>1) {printf("WARNING: Initial level of susceptibles+infecteds (%g+%g=%g) is greater than one\n",S0[i],I0[i],S0[i]+I0[i]);}
      
      if(beta[i]<gamm[i]+mu[i]) {printf("WARNING: Basic reproductive ratio (R_0=%g) is less than one\n",beta[i]/(gamm[i]+mu[i]));}

      for(j=0;j<N;j++)
	{
	  if(m[i][j]<0) {printf("ERROR: Movement rate m_%d,%d (%g) is less than zero\n",i,j,m[i][j]); exit(1);}
	}
      if(m[i][i]!=0) {printf("WARNING: Movement rate m_%d,%d (%g) is not equal to zero\n",i,i,m[i][i]);}

    }
   if(MaxTime<=0) {printf("ERROR: Maximum run time (%g) is less than or equal to zero\n",MaxTime); exit(1);}

}

void Output_Data(FILE *out)
{
  double TotalS, TotalI;
  int i,j;
  
  if(out!=stdout)
    {
      fprintf(out,"%g \t",t);
      for(i=0;i<N;i++)
	{
	  fprintf(out," %g %g",S[i],I[i]);
	}
      fprintf(out,"\n");
    }

  if(DEBUG)
    {
      TotalS=TotalI=0;
      for(i=0;i<N;i++)
	{
	  TotalS+=S[i]; TotalI+=I[i];
	}
      printf("%g \t %g %g\n",t,TotalS,TotalI);
    }

  if(DEBUG<0)
    {
      printf("%g \t",t);
      for(i=0;i<N;i++)
	{
	  printf(" %g %g",S[i],I[i]);
	}
      printf("\n");
    }
}




void Runge_Kutta(double step)
{
  int i;
  double dPop1[2*MAX], dPop2[2*MAX], dPop3[2*MAX], dPop4[2*MAX];
  double tmpPop[2*MAX], initialPop[2*MAX];

  /* Integrates the equations one step, using Runge-Kutta 4
     Note: we work with arrays rather than variables to make the
     coding easier */

  for(i=0;i<N;i++)
    {
      initialPop[2*i]=S[i]; initialPop[1+2*i]=I[i];
    }
  
  Diff(initialPop);
  for(i=0;i<2*N;i++)
    {
      dPop1[i]=dPop[i];
      tmpPop[i]=initialPop[i]+step*dPop1[i]/2;
    }

  Diff(tmpPop);
  for(i=0;i<2*N;i++)
    {
      dPop2[i]=dPop[i];
      tmpPop[i]=initialPop[i]+step*dPop2[i]/2;  
    }

  Diff(tmpPop);
  for(i=0;i<2*N;i++)
    {
      dPop3[i]=dPop[i];
      tmpPop[i]=initialPop[i]+step*dPop3[i]; 
    }

  Diff(tmpPop);

  for(i=0;i<2*N;i++)
    {
      dPop4[i]=dPop[i];

      tmpPop[i]=initialPop[i]+(dPop1[i]/6 + dPop2[i]/3 + dPop3[i]/3 + dPop4[i]/6)*step;
    }

  for(i=0;i<N;i++)
    {
      S[i]=tmpPop[2*i]; I[i]=tmpPop[1+2*i]; 
    }
  
  return;
}
