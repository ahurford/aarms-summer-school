function [t,Y] = Program_6_3(beta,gamma,Y0,N0,MaxTime)
%
% 
%
% Program_6_3( beta, gamma, Y0, N0, MaxTime)
%      This is the MATLAB version of program 6.3 from page 202 of 
% "Modeling Infectious Disease in humans and animals" 
% by Keeling & Rohani.
% 
% It is the SIS model with full (event-driven) demographic stochasticity.
%
% This is a relatively simple stochastic model as only 2 events are
% possible: infection or recovery.
% Note: by default we are using a very small population size to highlight
% the stochasticity.

% Sets up default parameters if necessary.
if nargin == 0
   beta=0.03;
   gamma=1/100.0;
   Y0=70;
   N0=100;
   MaxTime=10*365;
end

% Checks all the parameters are valid
if Y0<=0 
    error('Initial number of infecteds (%g) is less than or equal to zero',Y0);
end

if N0<=0 
    error('Initial population size (%g) is less than or equal to zero',N0);
end

if beta<=0 
    error('Transmission rate beta0 (%g) is less than or equal to zero',beta0);
end

if gamma<=0 
    error('Recovery rate gamma (%g) is less than or equal to zero',gamma);
end
  
if MaxTime<=0 
    error('Maximum run time (%g) is less than or equal to zero',MaxTime);
end

if Y0>N0
    warning('Initial level of infecteds (%g) is greater than population size (%g)',Y0,N0);
end


% The main iteration 

[t, pop]=Stoch_Iteration([0 MaxTime],[Y0],[beta gamma N0]);

T=t/365; Y=pop;

% plots the graphs with scaled colours
subplot(1,1,1)
h=plot(T,Y,'-r');
xlabel 'Time (years)';
ylabel 'Infectious'


% Do the iterations using the full event driven stochastic methodology
% Note that this could be written more generally (see Program 6.4) but
% this version is kept simple for clarity
function [T,P]=Stoch_Iteration(Time,Initial,Parameters)

Y=Initial(1);
T=0; P(1)=Y;

loop=1;
while (T(loop)<Time(2) & Y>0)
    [step,new]=Iterate(Y,Parameters);
    loop=loop+1;
    T(loop)=T(loop-1)+step;
    P(loop)=Y;
    loop=loop+1;
    T(loop)=T(loop-1);
    P(loop)=new; Y=new;

    if loop>=length(T)
        T(loop*2)=0;
        P(loop*2)=0;
    end
end

T=T(1:loop); P=P(1:loop);


% Do the actual iteration step
function [step, new_value]=Iterate(Y, Parameters);

beta=Parameters(1); gamma=Parameters(2); N=Parameters(3);

Rate_Infection = beta*(N-Y)*Y/N;
Rate_Recovery = gamma*Y;

R1=rand(1,1);
R2=rand(1,1);

step = -log(R2)/(Rate_Infection+Rate_Recovery);

if R1<Rate_Infection/(Rate_Infection+Rate_Recovery)
    new_value=Y+1;  % do infection
else
    new_value=Y-1;  % do recovery
end






