function [t,X,Y] = Program_7_8(n,tau,gamma,Y0,N0,MaxTime)
%
% 
%
% Program_7_8( n, tau, gamma, Y0, N0, MaxTime)
%      This is the MATLAB version of program 7.8 from page 285 of 
% "Modeling Infectious Disease in humans and animals" 
% by Keeling & Rohani.
% 
% It is the pairwise approximation to the SIS model on a random network of
% N individuals, each with n contacts.
% 
% Initially it is assumed that there is no correlation between infected and
% susceptible individuals in the network. 
%

% Sets up default parameters if necessary.
if nargin == 0
   n=4;
   tau=0.1;
   gamma=0.05;
   Y0=1;
   N0=10000;
   MaxTime=100;
end
X0=N0-Y0;

% Checks all the parameters are valid
CheckGreater(tau,0,'beta');
CheckGreaterOrEqual(gamma,0,'gamma');
CheckGreater(n,0,'nu');
CheckGreater(N0,0,'N0');
CheckGreater(Y0,0,'Y0');
CheckGreaterOrEqual(X0,0,'X0=N0-Y0');

X=X0; XY=n*Y0*X0/N0; 

% The main iteration 
options = odeset('RelTol', 1e-4);
[t, pop]=ode45(@Diff_7_8,[0 MaxTime],[X XY] ,options,n, tau, gamma, N0);

X=pop(:,1); XY=pop(:,2); Y=N0-X;

% plots the graphs 
subplot(3,1,1)
h=plot(t,Y,'-g');
xlabel 'Time';
ylabel 'Infectious'

subplot(3,1,2) 
h=plot(t,XY,'-r');
xlabel 'Time';
ylabel '[XY] pairs'

% this last graph is the effective reduction in transmission due to the
% negative spatial correlations between susceptibles and infecteds.
subplot(3,1,3) 
h=plot(t,XY./(n*X.*Y/N0),'-r');
xlabel 'Time';
ylabel 'relative XY correlation'




% Calculates the differential rates used in the integration.
function dPop=Diff_7_8(t,pop, n, tau, gamma, N)

X=pop(1); XY=pop(2);

dPop=zeros(2,1);

% Taken from Box 7.4

dPop(1)= gamma*(N-X) - tau*XY;
dPop(2)= tau*(n-1)*(n*X-XY)*XY/(n*X) + gamma*(n*N-n*X-XY) - tau*XY - tau*(n-1)*XY*XY/(n*X) - gamma*XY;


% Does a simple check on the value
function []=CheckGreaterOrEqual(Parameter, Value, str)

if Parameter<Value
    error('Parameter %s (=%g) is less than %g',str,Parameter,Value);
end

% Does a simple check on the value
function []=CheckGreater(Parameter, Value, str)

if Parameter<=Value
    error('Parameter %s (=%g) is less than %g',str,Parameter,Value);
end


