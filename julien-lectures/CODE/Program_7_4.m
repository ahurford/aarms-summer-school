function [T,X,Y] = Program_7_4(N,tau,gamma,nu,epsilon, timestep, MaxTime)
%
%
%
% Program_7_4( N, tau, gamma, nu, epsilon, time-step, MaxTime)
%      This is the MATLAB version of program 7.4 from page 260 of
% "Modeling Infectious Disease in humans and animals"
% by Keeling & Rohani.
%
% It is the forest-fire model on a grid of size NxN.
% A zero time-step means that asynchronous updating is used.
%

% Sets up default parameters if necessary.
if nargin == 0
    N=50;
    tau=1;
    gamma=0.1;
    nu=0.01;
    epsilon=1e-4;
    timestep=0.5;
    MaxTime=1000;
end

% Checks all the parameters are valid
CheckGreater(N,0,'Grid size N');
CheckGreater(tau,0,'tau');
CheckGreater(gamma,0,'gamma');
CheckGreaterOrEqual(nu,0,'nu');
CheckGreaterOrEqual(epsilon,0,'epsilon');
CheckGreaterOrEqual(timestep,0,'Time-step');
CheckGreater(MaxTime,0,'MaxTime');

%Initialise the grid (all susceptibles)%

Grid=2*ones(N,N);
for i=1:300
Grid(ceil(N*rand(1,1)), ceil(N*rand(1,1)))=3;
end
t=0; i=1; T=[]; X=[]; Y=[];

% The main iteration
while (t<MaxTime)

    [step,Grid,T,X,Y]=Iterate(i,t,T,X,Y,Grid,N,tau,gamma,nu,epsilon,timestep);
    t=t+step; i=i+1;

    subplot(2,1,1);
    colormap([0.9 0.9 0.9; 0 0.8 0; 1 0 0]); A=ones(N+1,N+1); A(1:N,1:N)=Grid; pcolor(A); 
    
    subplot(4,1,3);
    plot(T,X,'-g');
    ylabel 'Number of Susceptibles'
    subplot(4,1,4);
    plot(T,Y,'-r');
    ylabel 'Number of Infecteds'
    xlabel 'Time'
    drawnow;
end




%Do the Up-Dating.
function [step,Grid,T,X,Y]=Iterate(i,t,T,X,Y,Grid,N,tau,gamma,nu,epsilon,timestep)

INF=[0 0 1]; SUS=[0 1 0]; EMP=[1 0 0];

Infecteds=INF(Grid);  Susceptibles=SUS(Grid);
X(i)=sum(sum(Susceptibles)); Y(i)=sum(sum(Infecteds)); T(i)=t;

Inf_Nbrs=Infecteds(1:N,[2:N 1]) + Infecteds(1:N,[N 1:(N-1)]) + Infecteds([2:N 1],1:N) + Infecteds([N 1:(N-1)],1:N);

if(timestep==0)  % asynchronous updating
    Rates=nu*EMP(Grid) + gamma*Infecteds + tau*Susceptibles.*(Inf_Nbrs + epsilon);
    vectorRates=reshape(Rates,1,N*N);
    Total_Rates=sum(vectorRates);
    Cum_Rates=cumsum(vectorRates);
    step=-log(rand(1,1))/Total_Rates;
    R=rand(1,1)*Total_Rates;
    Event=min(find(R<Cum_Rates));
    Grid(Event)=mod(Grid(Event),3)+1;
else
    Rates=nu*EMP(Grid) + gamma*Infecteds + tau*Susceptibles.*(Inf_Nbrs + epsilon);
    R=timestep*Rates-rand(N,N);
    Grid=mod(Grid-1+ceil(R),3)+1;
    step=timestep;
end



% Does a simple check on the value
function []=CheckGreaterOrEqual(Parameter, Value, str)

m=find(Parameter<Value);
if length(m)>0
    error('Parameter %s(%g) (=%g) is less than %g',str,m(1),Parameter(m(1)),Value);
end

function []=CheckGreater(Parameter, Value, str)

m=find(Parameter<=Value);
if length(m)>0
    error('Parameter %s(%g) (=%g) is less than %g',str,m(1),Parameter(m(1)),Value);
end


