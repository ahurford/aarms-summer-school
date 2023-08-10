/* ****************************************************************

This is the C version of program 7.2 from page 242 of
"Modeling Infectious Disease in humans and animals"
by Keeling & Rohani.
 
It is the simple SIR epidemic in a metapopulation with human movement patterns. 
For simplicity births and deaths have been ignored, and we work with numbers of individuals.
Y[i][j] refers to infected individual who are currently in i but live in j.
For simplicity we set MAX to be the largest number of subpopulations it is 
possible to have -- this can easily be altered.

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
#define DEBUG 1

// Set up basic parameters
int N_subpops;
double beta[MAX];
double gamm[MAX];
double X0[MAX];
double Y0[MAX];
double N0[MAX];

double l[MAX][MAX];
double r[MAX][MAX];

double MaxTime;

// Set up variables and rates of change
double t,X[MAX][MAX],Y[MAX][MAX],N[MAX][MAX],Pop[3*MAX*MAX];
double dPop[3*MAX*MAX];

// Initialise the equations and Runge-Kutta integration
void Diff(double Pop[3*MAX*MAX])
{
  
  int i,j,k,K,h,H;
  // Set up temporary variables to make the equations look neater
  double tmpX, tmpY, tmpN, sumY[MAX], sumN[MAX];


  //calculate number currently in subpopulation i
  for(i=0;i<N_subpops;i++)
    {
      sumN[i]=0; sumY[i]=0;
      for(j=0;j<N_subpops;j++)
	{
	  k=3*(j+i*N_subpops);
	  sumN[i]+=Pop[2+k];
	  sumY[i]+=Pop[1+k];
	}
    }


  // set all rates of change to zero
  for(i=0;i<N_subpops;i++)
    {
      for(j=0;j<N_subpops;j++)
	{
	  k=3*(j+i*N_subpops);
	  dPop[k]=0; dPop[1+k]=0; dPop[2+k]=0;
	}
    } 

  // now calculate the rates of change
  for(i=0;i<N_subpops;i++)
    {
      for(j=0;j<N_subpops;j++)
	{
	  k=3*(j+i*N_subpops); K=3*(i+j*N_subpops); 
	  h=3*(i+i*N_subpops); H=3*(j+j*N_subpops);
	  
	  dPop[k]-=beta[i]*Pop[k]*sumY[i]/sumN[i];    // Infection
	  dPop[k+1]+=beta[i]*Pop[k]*sumY[i]/sumN[i];  // Infection
	  dPop[k+1]-=gamm[i]*Pop[k+1];          // Recovery

	  /* Movement */
	 
	  dPop[h]+=r[j][i]*Pop[K];
	  dPop[h]-=l[j][i]*Pop[h];
	  
	  dPop[1+h]+=r[j][i]*Pop[1+K];
	  dPop[1+h]-=l[j][i]*Pop[1+h];
	  
	  dPop[2+h]+=r[j][i]*Pop[2+K];
	  dPop[2+h]-=l[j][i]*Pop[2+h];
	  
	  dPop[k]+=l[i][j]*Pop[H];
	  dPop[k]-=r[i][j]*Pop[k];
	  
	  dPop[k+1]+=l[i][j]*Pop[1+H];
	  dPop[k+1]-=r[i][j]*Pop[1+k];
	  
	  dPop[k+2]+=l[i][j]*Pop[2+H];
	  dPop[k+2]-=r[i][j]*Pop[2+k];
	    
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

      if(DEBUG) printf("\nReading parameters from file %s\n",FileName);
    }
  else
    {
      if(DEBUG) printf("\nSetting default parameters\n");
	
      N_subpops=5;
      for(i=0;i<N_subpops;i++)
	{
	  beta[i]=1;
	  gamm[i]=0.3;
	  for(j=0;j<N_subpops;j++)
	    {
	      if( abs(i-j)==1) l[i][j]=0.1;
	      else l[i][j]=0;
	      r[i][j]=2.0;
	    }
	  r[i][i]=0;
	  N0[i]=1000;
	  X0[i]=800;
	  Y0[i]=0;
	}
      Y0[0]=1;
      MaxTime=60;
    }

  /* Check all parameters are OK & set up intitial conditions */

  Perform_Checks();
  for(i=0;i<N_subpops;i++)
     {
       for(j=0;j<N_subpops;j++)
	 {
	   X[i][j]=0; Y[i][j]=0; N[i][j]=0;
	 }
       X[i][i]=X0[i]; Y[i][i]=Y0[i]; N[i][i]=N0[i];
     }


   /* Find a suitable time-scale for outputs */

   step=1e100;
   for(i=0;i<N_subpops;i++)
     {
       tmp=0;
       for(j=0;j<N_subpops;j++)
	 {
	   tmp+=r[i][j]+l[i][j];
	 }
       tmp=0.1/((beta[i]+gamm[i]+tmp)*X0[i]);

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
  int i,j;
  char str[200];

  fscanf(in,"%s",str);
  fscanf(in,"%d",&N_subpops);
  if(N_subpops>MAX) {printf("Number of subpopulations N_subpops (%d) exceeds the predefined maximum\n",N_subpops); exit(1);}
  
  fscanf(in,"%s",str);
  for(i=0;i<N_subpops;i++)
    {
      fscanf(in,"%lf",&beta[i]);
    }
  
  fscanf(in,"%s",str);
  for(i=0;i<N_subpops;i++)
    {
      fscanf(in,"%lf",&gamm[i]);
    }
  
  fscanf(in,"%s",str);
  for(i=0;i<N_subpops;i++)
    {
      for(j=0;j<N_subpops;j++)
	{
	  fscanf(in,"%lf",&l[i][j]);
	}
    }
  
  fscanf(in,"%s",str);
  for(i=0;i<N_subpops;i++)
    {
      for(j=0;j<N_subpops;j++)
	{
	  fscanf(in,"%lf",&r[i][j]);
	}
    }
  
  fscanf(in,"%s",str);
  for(i=0;i<N_subpops;i++)
    {
      fscanf(in,"%lf",&N0[i]);
    }
  
  fscanf(in,"%s",str);
  for(i=0;i<N_subpops;i++)
    {
      fscanf(in,"%lf",&X0[i]);
    }
  
  fscanf(in,"%s",str);
  for(i=0;i<N_subpops;i++)
    {
      fscanf(in,"%lf",&Y0[i]);
    }
  
  fscanf(in,"%s",str);
  fscanf(in,"%lf",&MaxTime);
  
  fclose(in);
  
}


void Perform_Checks()
{
  int i,j;

  for(i=0;i<N_subpops;i++)
    {
      if(X0[i]<=0) {printf("ERROR: Initial level of susceptibles_%d (%g) is less than or equal to zero\n",i,X0[i]); exit(1);}
      
      if(Y0[i]<0) {printf("ERROR: Initial level of infecteds_%d (%g) is less than zero\n",i,Y0[i]); exit(1);}
      
      if(beta[i]<=0) {printf("ERROR: Transmission rate beta_%d (%g) is less than or equal to zero\n",i,beta[i]); exit(1);}
      
      if(gamm[i]<=0) {printf("ERROR: Recovery rate gamma_%d (%g) is less than or equal to zero\n",i,gamm[i]); exit(1);}
      
      if(X0[i]+Y0[i]>N0[i]) {printf("WARNING: Initial level of susceptibles+infecteds (%g+%g=%g) is greater than population size (%g)\n",X0[i],Y0[i],X0[i]+Y0[i],N0[i]);}
      
      if(beta[i]<gamm[i]) {printf("WARNING: Basic reproductive ratio (R_0=%g) is less than one\n",beta[i]/(gamm[i]));}
      
      for(j=0;j<N_subpops;j++)
	{
	  if(l[i][j]<0) {printf("ERROR: Movement rate l_%d,%d (%g) is less than zero\n",i,j,l[i][j]); exit(1);}
	  if(l[i][j]<0) {printf("ERROR: Return rate r_%d,%d (%g) is less than zero\n",i,j,r[i][j]); exit(1);}
	}
      if(l[i][i]!=0) {printf("WARNING: Movement rate l_%d,%d (%g) is not equal to zero\n",i,i,l[i][i]);}
      if(r[i][i]!=0) {printf("WARNING: Movement rate r_%d,%d (%g) is not equal to zero\n",i,i,r[i][i]);}
    }
  if(MaxTime<=0) {printf("ERROR: Maximum run time (%g) is less than or equal to zero\n",MaxTime); exit(1);}
}


void Output_Data(FILE *out)
{
  int i,j;
  double TotalS, TotalI;

  if(out!=stdout)
    {
      fprintf(out,"%g \t",t);
      for(i=0;i<N_subpops;i++)
	{
	  TotalS=TotalI=0;
	  for(j=0;j<N_subpops;j++)
	    {
	      TotalS+=X[i][j]; TotalI+=Y[i][j];
	    }
	  fprintf(out," %g %g",TotalS,TotalI);
	}
      fprintf(out,"\n");
    }

  if(DEBUG)
    {
      TotalS=TotalI=0;
      for(i=0;i<N_subpops;i++)
	{
	  for(j=0;j<N_subpops;j++)
	    {
	      TotalS+=X[i][j]; TotalI+=Y[i][j];
	    }
	}
      printf("%g \t %g %g\n",t,TotalS,TotalI);
    }


  if(DEBUG<0)
    {
      printf("%g \t",t);
      for(i=0;i<N_subpops;i++)
	{
	  TotalS=TotalI=0;
	  for(j=0;j<N_subpops;j++)
	    {
	      TotalS+=X[i][j]; TotalI+=Y[i][j];
	    }
	  printf(" %g %g",TotalS,TotalI);
	}
      printf("\n");
    }

}





void Runge_Kutta(double step)
{
  int i,j,k;
  double dPop1[3*MAX*MAX], dPop2[3*MAX*MAX], dPop3[3*MAX*MAX], dPop4[3*MAX*MAX];
  double tmpPop[3*MAX*MAX], initialPop[3*MAX*MAX];

  /* Integrates the equations one step, using Runge-Kutta 4
     Note: we work with arrays rather than variables to make the
     coding easier */

  for(i=0;i<N_subpops;i++)
    {
      for(j=0;j<N_subpops;j++)
	{
	  k=3*(j+i*N_subpops);
	  initialPop[k]=X[i][j]; initialPop[1+k]=Y[i][j]; initialPop[2+k]=N[i][j];
	}
    }
  
  Diff(initialPop);
  for(i=0;i<3*N_subpops*N_subpops;i++)
    {
      dPop1[i]=dPop[i];
      tmpPop[i]=initialPop[i]+step*dPop1[i]/2;
    }

  Diff(tmpPop);
  for(i=0;i<3*N_subpops*N_subpops;i++)
    {
      dPop2[i]=dPop[i];
      tmpPop[i]=initialPop[i]+step*dPop2[i]/2;  
    }

  Diff(tmpPop);
  for(i=0;i<3*N_subpops*N_subpops;i++)
    {
      dPop3[i]=dPop[i];
      tmpPop[i]=initialPop[i]+step*dPop3[i]; 
    }

  Diff(tmpPop);

  for(i=0;i<3*N_subpops*N_subpops;i++)
    {
      dPop4[i]=dPop[i];

      tmpPop[i]=initialPop[i]+(dPop1[i]/6 + dPop2[i]/3 + dPop3[i]/3 + dPop4[i]/6)*step;
    }

  for(i=0;i<N_subpops;i++)
    {
      for(j=0;j<N_subpops;j++)
	{
	  k=3*(j+i*N_subpops);
	  X[i][j]=tmpPop[k]; Y[i][j]=tmpPop[1+k]; N[i][j]=tmpPop[2+k];
	}
    }
  
  return;
}
