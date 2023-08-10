function [t,X,Y] = Program_7_1(n,beta,gamma,nu,mu,m,X0,Y0,MaxTime)
%
% 
%
% Program_7_1( n, beta, gamma, nu, mu, m, X0, Y0, MaxTime)
%      This is the MATLAB version of program 7.1 from page 241 of 
% "Modeling Infectious Disease in humans and animals" 
% by Keeling & Rohani.
% 
% It is the SIR epidemic in a metapopulation with "animal-like" movements
% of infected or susceptible individuals across the network.
% 
% The default model employs global coupling between ALL subpopulations; an
% alterative linear arrangement, with nearest-neighbour coupling can be
% achieved by:
% 
% Program_7_1(n,beta,gamma,nu,mu,m*(diag(ones(1,n-1),1)+diag(ones(1,n-1),-1)),X0,Y0,MaxTime)
%

% Sets up default parameters if necessary.
if nargin == 0
   n=5;
   beta=1.0*ones(n,1);
   gamma=0.1*ones(n,1);
   nu=0.0001*ones(n,1);
   mu=0.0001*ones(n,1);
   X0=0.1*ones(n,1);
   Y0=0.0*ones(n,1); Y0(1)=0.0001;
   MaxTime=2910;
   m=0.001*ones(n,n); m=m-diag(diag(m));
end

% Check all parameters are the right size
beta=CheckSize(beta,n,1,'beta');
gamma=CheckSize(gamma,n,1,'gamma');
nu=CheckSize(nu,n,1,'nu');
mu=CheckSize(mu,n,1,'mu');
m=CheckSize(m,n,n,'m');
X0=CheckSize(X0,n,1,'X0');
Y0=CheckSize(Y0,n,1,'Y0');

% Checks all the parameters are valid
CheckGreaterOrEqual(beta,0,'beta');
CheckGreaterOrEqual(gamma,0,'gamma');
CheckGreaterOrEqual(nu,0,'nu');
CheckGreaterOrEqual(mu,0,'mu');
CheckGreaterOrEqual(m,0,'m');
CheckGreaterOrEqual(X0,0,'X0');
CheckGreaterOrEqual(Y0,0,'Y0');

if sum(abs(diag(m)))>0
    warning('Diagonal terms in movement matrix m are non-zero');
end

X=X0; Y=Y0; All=reshape([X';Y'],2*n,1);

% The main iteration 
options = odeset('RelTol', 1e-4);
[t, pop]=ode45(@Diff_7_1,[0 MaxTime],All,options,n, beta, gamma, nu, mu,m);

X=pop(:,1:2:(2*n)); Y=pop(:,2:2:(2*n));

% plots the graphs with scaled colours
subplot(2,1,1)
h=plot(t,X,'-g');
for i=1:n
    set(h(i),'Color',[0 0.5+0.5*(i-1)/(n-1) 0]);
end
xlabel 'Time';
ylabel 'Susceptibles'

subplot(2,1,2) 
h=plot(t,Y,'-r');
for i=1:n
    set(h(i),'Color',[0.5+0.5*(i-1)/(n-1) 0 0]);
end
legend(h);
xlabel 'Time';
ylabel 'Infectious'



% Calculates the differential rates used in the integration.
function dPop=Diff_7_1(t,pop, n, beta, gamma, nu, mu, m)

X=pop(1:2:(2*n)); Y=pop(2:2:(2*n));

dPop=zeros(2*n,1);

% Note the different use of .* and *

dPop(1:2:(2*n))= nu -beta.*X.*Y - mu.*X + m*X - sum(m)'.*X;
dPop(2:2:(2*n))= beta.*X.*Y - gamma.*Y - mu.*Y + m*Y - sum(m)'.*Y;


% Does a simple check on the size and possible transpose
function Parameter=CheckSize(Parameter, L, W, str)

[l w]=size(Parameter);

if(l==W & w==L)
    Parameter=Parameter'; [l w]=size(Parameter);
end

if(l==1 & w==1)
    warning('Parameter %s is a scaler value, expanding to size %d x %d',str,L,W);
    Parameter=Parameter*ones(L,W);
    [l w]=size(Parameter);
end

if(l~=L | w~=W)
    error('Parameter %s is of size %d x %d and not %d x %d',str,l,w,L,W);
end


% Does a simple check on the value
function []=CheckGreaterOrEqual(Parameter, Value, str)

m=find(Parameter<Value);
if length(m)>0
    error('Parameter %s(%g) (=%g) is less than %g',str,m(1),Parameter(m(1)),Value);
end


