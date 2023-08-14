function [t,X,Y] = Program_7_2(n,beta,gamma,l,r,N0,X0,Y0,MaxTime)
%
% 
%
% Program_7_2( n,beta, gamma, l, r, N0, X0, Y0, MaxTime)
%      This is the MATLAB version of program 7.2 from page 242 of 
% "Modeling Infectious Disease in humans and animals" 
% by Keeling & Rohani.
% 
% It is the SIR epidemic in a metapopulationFor simplicity births and deaths have been 
% ignored, and we work with numbers of individuals.
% Y[i][j] refers to infected individual who are currently in i but live in j..
%

% Sets up default parameters if necessary.
if nargin == 0
   n=5;
   beta=1.0*ones(n,1);
   gamma=0.3*ones(n,1);
   N0=1000*ones(n,1);
   X0=800*ones(n,1);
   Y0=0.0*ones(n,1); Y0(1)=1;
   MaxTime=60;
   l=0.1*(diag(ones(1,n-1),1)+diag(ones(1,n-1),-1));
   r=2*ones(n,n); r=r-diag(diag(r));
end

% Check all parameters are the right size
beta=CheckSize(beta,n,1,'beta');
gamma=CheckSize(gamma,n,1,'gamma');
l=CheckSize(l,n,n,'m');
r=CheckSize(r,n,n,'m');
N0=CheckSize(N0,n,1,'S0');
X0=CheckSize(X0,n,1,'S0');
Y0=CheckSize(Y0,n,1,'I0');

% Checks all the parameters are valid
CheckGreaterOrEqual(beta,0,'beta');
CheckGreaterOrEqual(gamma,0,'gamma');
CheckGreaterOrEqual(l,0,'m');
CheckGreaterOrEqual(r,0,'m');
CheckGreaterOrEqual(N0,0,'S0');
CheckGreaterOrEqual(X0,0,'S0');
CheckGreaterOrEqual(Y0,0,'I0');

if sum(abs(diag(l)))>0
    warning('Diagonal terms in movement matrix l are non-zero');
end
if sum(abs(diag(r)))>0
    warning('Diagonal terms in return rate matrix r are non-zero');
end
m=find(X0+Y0>N0);
if length(m)>0
    error('Population %g, susceptibles + infecteds are greater than population size',m(1));
end

X=zeros(n,n); Y=zeros(n,n); NN=zeros(n,n);
X=diag(X0); Y=diag(Y0); NN=diag(N0); All=reshape([X Y NN],3*n*n,1);

% The main iteration 
options = odeset('RelTol', 1e-4);
[t, pop]=ode45(@Diff_7_1,[0 MaxTime],All,options,n, beta, gamma, l, r);

X=zeros(length(t),n); Y=X;
for i=1:n
    X(:,i)=sum(pop(:,i:n:(n*n))')';
    Y(:,i)=sum(pop(:,(n*n)+[i:n:(n*n)])')';
end

% plots the graphs with scaled colours
subplot(2,1,1)
h=plot(t,X,'-g');
for i=1:n
    set(h(i),'Color',[0 0.5+0.5*(i-1)/(n-1) 0]);
end
legend(h);
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
function dPop=Diff_7_1(t,pop, n, beta, gamma, l, r)

X=reshape(pop(1:(n*n)),n,n); Y=reshape(pop((n*n)+[1:(n*n)]),n,n); 
NN=reshape(pop(2*(n*n)+[1:(n*n)]),n,n);

dX=zeros(n,n); dY=zeros(n,n); dNN=zeros(n,n);

% Note the different use of .* and *

sumY=sum(Y')'; sumNN=sum(NN')';

% First do the off diagonals.
dX = -X.*((beta.*sumY./sumNN)*ones(1,n)) + l.*(ones(n,1)*diag(X)')   - r.*X;
dY = X.*((beta.*sumY./sumNN)*ones(1,n)) - Y.*(gamma*ones(1,n)) + l.*(ones(n,1)*diag(Y)')   - r.*Y;
dNN =  l.*(ones(n,1)*diag(NN)')   - r.*NN;

% Now do diagonals
DX = -diag(X).*(beta.*sumY./sumNN) - sum(l)'.*diag(X) + sum(r.*X)';
DY = diag(X).*(beta.*sumY./sumNN) - diag(Y).*gamma - sum(l)'.*diag(Y) + sum(r.*Y)';
DNN = - sum(l)'.*diag(NN) + sum(r.*NN)';

dX = dX - diag(diag(dX)) + diag(DX);
dY = dY - diag(diag(dY)) + diag(DY);
dNN = dNN - diag(diag(dNN)) + diag(DNN);

dPop=reshape([dX dY dNN],3*n*n,1);

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


