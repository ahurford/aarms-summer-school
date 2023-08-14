function [t,X,Y,Z] = Program_6_4(beta,gamma,mu,X0,Y0,N0, tau, MaxTime)
%
% 
% Program_6_5( beta, gamma, mu, X0, Y0, N0, tau, MaxTime)
%      This is the MATLAB version of program 6.5 from page 204 of 
% "Modeling Infectious Disease in humans and animals" 
% by Keeling & Rohani.
% 
% It is the SIR model (including births and deaths) with 
% (event-driven) demographic stochasticity approximated using the tau-leap 
% method and assuming Poisson distributions.
%
% This is a more complex stochastic model as 6 events are
% possible: infection, recovery, birth, death of susceptible, death of
% infected, death of recovered.
%
% Note: by default we are using a very small population size to highlight
% the stochasticity.

% Sets up default parameters if necessary.
if nargin == 0
   beta=1;
   gamma=1/10.0;
   mu=5e-4;
   N0=5000;
   
   Y0=ceil(mu*N0/gamma);
   X0=floor(gamma*N0/beta);
   
   tau=1;
   
   MaxTime=2*365;
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

if mu<=0 
    error('Brith and Death rate mu (%g) is less than or equal to zero',mu);
end

if tau<=0 
    error('Step length tau (%g) is less than or equal to zero',tau);
end
  
if MaxTime<=0 
    error('Maximum run time (%g) is less than or equal to zero',MaxTime);
end

if X0+Y0>N0
    warning('Initial level of suceptibles + infecteds (%g + %g = %g) is greater than population size (%g)',X0,Y0,X0+Y0,N0);
end


Z0=N0-X0-Y0;

% The main iteration 

[t, pop]=Stoch_Iteration([0 MaxTime],[X0 Y0 Z0],[beta gamma mu N0 tau]);

T=t/365; X=pop(:,1); Y=pop(:,2); Z=pop(:,3);

% plots the graphs with scaled colours
subplot(3,1,1)
h=plot(T,X,'-g');
xlabel 'Time (years)';
ylabel 'Susceptible'

subplot(3,1,2)
h=plot(T,Y,'-r');
xlabel 'Time (years)';
ylabel 'Infectious'

subplot(3,1,3)
h=plot(T,Z,'-k');
xlabel 'Time (years)';
ylabel 'Recovereds'




% Do the iterations using the full event driven stochastic methodology
% This is a relatively general version of the event-driven methodology know
% as Gillespie's Direct Algorithm
function [T,P]=Stoch_Iteration(Time,Initial,Parameters)

X=Initial(1); Y=Initial(2); Z=Initial(3); 
tau=Parameters(5);

T=[0:tau:Time(2)]; P(1,:)=[X Y Z];
old=[X Y Z];

loop=1;
while (T(loop)<Time(2))  
    [new]=Tau_leap(old,Parameters);
    loop=loop+1;
    P(loop,:)=new; old=new;
end


% Do the actual iteration step
function [new_value]=Tau_leap(old, Parameters);

beta=Parameters(1); gamma=Parameters(2); mu=Parameters(3); N=Parameters(4); tau=Parameters(5);
X=old(1); Y=old(2); Z=old(3);

Rate(1) = mu*N;       Change(1,:)=[+1 0 0];
Rate(2) = beta*X*Y/N;  Change(2,:)=[-1 +1 0];
Rate(3) = gamma*Y;     Change(3,:)=[0 -1 +1];
Rate(4) = mu*X;       Change(4,:)=[-1 0 0];
Rate(5) = mu*Y;       Change(5,:)=[0 -1 0];
Rate(6) = mu*Z;       Change(6,:)=[0 0 -1];

new_value=old;

for i=1:6
    Num=poissrnd(Rate(i)*tau);
    %% Make sure things don't go negative
    Use=min([Num new_value(find(Change(i,:)<0))]);
    new_value=new_value+Change(i,:)*Use;
end










