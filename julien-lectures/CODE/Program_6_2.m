function [t,X,Y] = Program_6_2(beta,gamma,mu,X0,Y0,N0,Step,MaxTime)
%
% 
%
% Program_6_2( beta, gamma, mu, X0, Y0, N0, Step, MaxTime)
%      This is the MATLAB version of program 6.2 from page 197 of 
% "Modeling Infectious Disease in humans and animals" 
% by Keeling & Rohani.
% 
% It is the SIR epidemic model with scaled additive noise added to 
% all the various rates.
% Given the difficulties in integrating the dynamics, the user is prompted
% for a integration time-step.
%
%

% Sets up default parameters if necessary.
if nargin == 0
   beta=1.0;
   gamma=1/10.0;
   mu=1/(50*365.0);
   X0=1e5;
   Y0=500;
   N0=1e6;
   Step=1;
   MaxTime=5*365;
end

% Checks all the parameters are valid
if X0<=0 
    error('Initial number of susceptibles (%g) is less than or equal to zero',X0);
end

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

if mu<0 
    error('Birth / Death rate gamma (%g) is less than zero',mu);
end
    
if MaxTime<=0 
    error('Maximum run time (%g) is less than or equal to zero',MaxTime);
end

if Step<=0
    error('Integration time-step (%g) is less than or equal to zero',Step);
end
    
if X0+Y0>N0
    warning('Initial level of susceptibles+infecteds (%g+%g=%g) is greater than population size (%g)',X0,Y0,X0+Y0,N0);
end


X=X0; Y=Y0;

% The main iteration 

options = odeset('RelTol', 1e-5);
[t, pop]=Stoch_ODE([0 MaxTime],[X Y],options,[beta gamma mu N0 Step]);

T=t/365; X=pop(:,1); Y=pop(:,2);

% plots the graphs with scaled colours
subplot(2,1,1)
h=plot(T,X,'.-g');
xlabel 'Time (years)';
ylabel 'Susceptibles'

subplot(2,1,2)
h=plot(T,Y,'.-r');
xlabel 'Time (years)';
ylabel 'Infectious'

% Do the integration of the differential equations with noise
% Here we fix the noise for each step, but integrate that step using ode45
% This works, but it may be better to use Forward Euler, but this would
% need much shorter time steps.
function [T,P]=Stoch_ODE(Time,Initial,options,Parameters)

X=Initial(1); Y=Initial(2);
t=0; 
Step=Parameters(5); sqrtStep=sqrt(Step);


T=zeros(1+ceil(Time(2)/Step),1); 
P=zeros(1+ceil(Time(2)/Step),2); P(1,:)=[X Y]; loop=1;

while (t<Time(2) & Y>0 & X>0)
    Parameters(5:9)=randn(1,5)/sqrtStep;
    [tt,p]=ode45(@Diff_6_2,[t t+Step],[X Y],options,Parameters);
    t=tt(end); X=p(end,1); Y=p(end,2);
    loop=loop+1;
    T(loop)=t;
    P(loop,:)=[X Y];
end

T=T(1:loop); P=P(1:loop,:);

% Calculates the differential rates used in the integration.
function dPop=Diff_6_2(t,pop, parameter)

beta=parameter(1); gamma=parameter(2); 
mu=parameter(3); N=parameter(4);
noise=parameter(5:9);

X=pop(1); Y=pop(2); 

dPop=zeros(2,1);

dPop(1)= (mu*N + sqrt(mu*N)*noise(1)) - (beta*X*Y/N + sqrt(beta*X*Y/N)*noise(2)) - (mu*Y + sqrt(mu*Y)*noise(3));
dPop(2)= (beta*X*Y/N + sqrt(beta*X*Y/N)*noise(2)) - (gamma*Y + sqrt(gamma*Y)*noise(4)) - (mu*Y + sqrt(mu*Y)*noise(5));




