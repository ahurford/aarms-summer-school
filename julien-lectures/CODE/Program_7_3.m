function [t,S,I] = Program_7_3(N,beta,gamma ,mu, rho, X0, nI, N0, timestep, MaxTime)
%
% 
%
  % Program_7_3( n, beta, gamma, mu, rho, X0, nI, N0, time-step, MaxTime)
%      This is the MATLAB version of program 7.3 from page 256 of 
% "Modeling Infectious Disease in humans and animals" 
% by Keeling & Rohani.
% 
% It is the SIR epidemic on an nxn lattice with coupling (rho) to 4 nearest
% neighbour. nI defines the number of lattice sites (chosen randomly) that
% start with some infection.
%

% Sets up default parameters if necessary.
if nargin == 0
   n=25;
   beta=1.0;
   gamma=0.1;
   mu=0.0001;
   rho=0.1;
   X0=0.1;
   nI=4;
   N0=1;
   timestep=1;
   MaxTime=2910;
end

% Checks all the parameters are valid
CheckGreater(n,0,'Lattice size nxn ');
CheckGreater(beta,0,'beta');
CheckGreater(gamma,0,'gamma');
CheckGreaterOrEqual(mu,0,'mu');
CheckGreaterOrEqual(rho,0,'rho');
CheckLess(rho,1/4,'rho');
CheckGreater(X0,0,'S0');
CheckGreater(nI,0,'number of sources nI');
CheckGreater(N0,0,'N0');

% Convert Lattice to a Metapopulation !!!
X=X0*ones(n*n,1); Y=zeros(n*n,1); 
Y(ceil(n*n*rand(nI,1)))=0.001*X0;
All=[X; Y];

m=((1-4*rho))*eye(n*n,n*n);
[i,j]=meshgrid([1:(n-1)],[1:n]);
ri=reshape(i,n*(n-1),1); rj=reshape(j,n*(n-1),1);
m=m+sparse(ri*n+rj-n,(ri+1)*n+rj-n,rho,n*n,n*n);
m=m+sparse((ri+1)*n+rj-n,ri*n+rj-n,rho,n*n,n*n);
m=m+sparse(rj*n+ri-n,rj*n+ri+1-n,rho,n*n,n*n);
m=m+sparse(rj*n+(ri+1)-n,rj*n+ri-n,rho,n*n,n*n);


% The main iteration 
t=0; X=sum(X); Y=sum(Y); i=2;
ColMap=[0.4+0.6*[0:99]/99 ; zeros(1,100); zeros(1,100)]';
ColMap(1,1)=0;
colormap(ColMap);
    
while (t<MaxTime)
    options = odeset('RelTol', 1e-3);
    [T, pop]=ode45(@Diff_7_3,[0 timestep],All,options,n, beta, gamma, mu*N0, mu, m, N0);

    XX=pop(end,1:(n*n)); YY=pop(end,(n*n)+[1:(n*n)]); All=pop(end,:);
    X(i)=sum(XX); Y(i)=sum(YY);
    t(i)=t(i-1)+T(end); i=i+1;

    % plots the graphs with scaled colours
    subplot(2,1,1);
    A=zeros(n+1,n+1); A(1:n,1:n)=reshape(YY,n,n); pcolor(A); colorbar;

    subplot(4,1,3);
    plot(t,X,'-g');
    ylabel 'Total Susceptibles'
    
    subplot(4,1,4);
    plot(t,Y,'-r');
    ylabel 'Total Infecteds'
    xlabel 'Time'
    drawnow
end



% Calculates the differential rates used in the integration.
function dPop=Diff_7_3(t,pop, n, beta, gamma, nu, mu, m, N)

X=pop(1:(n*n)); Y=pop((n*n)+[1:(n*n)]);

dPop=zeros(2*n*n,1);

% Note the different use of .* and *

dPop(1:(n*n))= nu - beta.*X.*(m*Y)./(N*(m*ones(n*n,1))) - mu.*X;
dPop((n*n)+[1:(n*n)])= beta.*X.*(m*Y)./(N*(m*ones(n*n,1))) - gamma.*Y - mu.*Y;




% Does a simple check on the value
function []=CheckGreaterOrEqual(Parameter, Value, str)
m=find(Parameter<Value);
if length(m)>0
    error('Parameter %s(%g) (=%g) is less than %g',str,m(1),Parameter(m(1)),Value);
end

function []=CheckGreater(Parameter, Value, str)
m=find(Parameter<=Value);
if length(m)>0
    error('Parameter %s(%g) (=%g) is less than or equal to %g',str,m(1),Parameter(m(1)),Value);
end

function []=CheckLess(Parameter, Value, str)
m=find(Parameter>=Value);
if length(m)>0
    error('Parameter %s(%g) (=%g) is greater than or equal to %g',str,m(1),Parameter(m(1)),Value);
end


