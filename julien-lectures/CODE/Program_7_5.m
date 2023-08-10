function [t,X,Y] = Program_7_5(N, Size, beta, gamma, alpha , Y0, timestep, MaxTime)
%
%
%
% Program_7_5( N, size, beta, gamma, alpha, Y0, time-step, MaxTime)
%      This is the MATLAB version of program 7.5 from page 269 of
% "Modeling Infectious Disease in humans and animals"
% by Keeling & Rohani.
%
% It is an individual based model. N individuals are randomly distributed
% in a size x size space and Y0 are assumed to be initially infectious.
% Transmission is assumed to be via a power-law kernel beta*distance^-alpha
%
% A time-step of zero uses full stochastic updating. A non-zero time-step
% uses the short-cuts mentioned in Box 7.3

% Sets up default parameters if necessary.
if nargin == 0
    N=1000;
    Size=10;
    beta=0.01;
    gamma=0.5;
    alpha=3;
    Y0=4;
    timestep=0.1;
    MaxTime=100;
end

% Checks all the parameters are valid
CheckGreater(N,0,'Individuals N ');
CheckGreater(beta,0,'beta');
CheckGreaterOrEqual(gamma,0,'gamma');
CheckGreaterOrEqual(alpha,0,'power-law alpha');
CheckGreater(Y0,0,'number of infections Y0');

% Set Up a 10x10 grid and position individuals
x=Size*rand(N,1); y=Size*rand(N,1); Status=zeros(N,1); Status(1:Y0)=1;
grid=WhichGrid(x,y,Size,Size,10,10);
[tmp,i]=sort(grid);
x=x(i); y=y(i); Status=Status(i); grid=grid(i);
for i=1:max(grid)
    Xgrid(i)=floor((i-1)/10);
    Ygrid(i)=mod((i-1),10);
    m=find(grid==i);
    Num(i)=length(m);
    if Num(i)>0
        first_in_grid(i)=min(m);
        last_in_grid(i)=max(m);
    else
        first_in_grid(i)=0;
        last_in_grid(i)=-1;
    end
end

%Work out grid to maximum grid transmission probabilities
for i=1:max(grid)
    for j=1:max(grid)
        if i==j | Num(i)==0 | Num(j)==0
            MaxRate(i,j)=inf;
            MaxProb(i,j)=1;
        else
            Dist2=(Size*max([0 (abs(Xgrid(i)-Xgrid(j))-1)])/10).^2 + (Size*max([0 (abs(Ygrid(i)-Ygrid(j))-1)])/10).^2;
            MaxRate(i,j)=timestep*beta*Dist2.^(-alpha/2);
            MaxProb(i,j)=1-exp(-Num(j)*MaxRate(i,j));
        end
    end
end

t=0; i=1; X=length(find(Status==0)); Y=length(find(Status==1)); i=i+1;
% The main iteration
while (t<MaxTime & Y(end)>0)

    [step, Status]=Iterate(Status, x, y, grid, first_in_grid, last_in_grid, Num, MaxRate, MaxProb, beta, gamma, alpha, timestep);

    Sus=find(Status==0); Inf=find(Status==1); Emp=find(Status==2);
    X(i)=length(Sus); Y(i)=length(Inf);
    t(i)=t(i-1)+step; i=i+1;

    if i>10000
        X=interp1(t,S,[0:999]*t(i)/999,'linear');
        Y=interp1(t,I,[0:999]*t(i)/999,'linear');
        t=[0:999]*t(i)/999;
        i=1001;
    end

    % plots the data
    subplot(2,1,1);
    plot(x(Emp),y(Emp),'.k','MarkerSize',8,'Color',[0.5 0.5 0.5]);
    hold on
    plot(x(Sus),y(Sus),'ok','MarkerFaceColor','g');
    plot(x(Inf),y(Inf),'sk','MarkerFaceColor','r');
    hold off
    axis([0 Size 0 Size]);

    subplot(4,1,3);
    plot(t,X,'-g');
    ylabel 'Total Susceptibles'

    subplot(4,1,4);
    plot(t,Y,'-r');
    ylabel 'Total Infecteds'
    xlabel 'Time'
    drawnow
    
end

% Iteration Space
function [step, Status]=Iterate(Status, x, y, grid, first_in_grid, last_in_grid, Num, MaxRate, MaxProb, beta, gamma, alpha, timestep)

if timestep==0   % Do full stochastic updating
    INF=find(Status==1);  NI=length(INF);
    SUS=find(Status==0);  NS=length(SUS);
    Rate=0*Status;
    Rate(INF)=gamma;
    Rate(SUS)=beta*sum(((x(INF)*ones(1,NS)-ones(NI,1)*x(SUS)').^2+(y(INF)*ones(1,NS)-ones(NI,1)*y(SUS)').^2).^(-alpha/2));
    TotalRate=sum(Rate);
    CumRate=cumsum(Rate);
    Event=min(find(TotalRate*rand(1,1)<CumRate));
    Status(Event)=Status(Event)+1;
    step=-log(rand(1,1))/TotalRate;
else
    Event=0*Status;

    INF=find(Status==1);  NI=length(INF);
    IGrids=grid(INF);

    for i=1:NI
        m=find(MaxProb(IGrids(i),:)-rand(1,max(grid))>0);  % these are grids that need further consideration

        for n=1:length(m)
            s=1;
            M=m(n);
            PAB=1-exp(-MaxRate(IGrids(i),M));
            if PAB==1
                ind=first_in_grid(M):last_in_grid(M);
                Q=1-exp(-timestep*beta*((x(INF(i))-x(ind)).^2+(y(INF(i))-y(ind)).^2).^(-alpha/2));
                Event(ind(find(rand(size(Q))-Q<0 & Status(ind)==0)))=1;
            else
                for j=1:Num(M)
                    ind=first_in_grid(M)+j-1;
                    P=1-s*(1-PAB).^(Num(M)+1-j);
                    R=rand(1,1);
                    if R<PAB/P
                        s=0;
                        Q=1-exp(-timestep*beta*((x(INF(i))-x(ind)).^2+(y(INF(i))-y(ind)).^2).^(-alpha/2));
                        if R<Q/P & Status(ind)==0
                            Event(ind)=1;
                        end
                    end
                end
            end
        end
        if rand(1,1)<1-exp(-gamma*timestep)
            Event(INF(i))=1;
        end
    end
    Status=Status+Event;
    step= timestep;
end

% Calculates the differential rates used in the integration.
function dPop=Diff_7_3(t,pop, N, beta, gamma, nu, mu, m)

S=pop(1:(N*N)); I=pop((N*N)+[1:(N*N)]);

dPop=zeros(2*N*N,1);

% Note the different use of .* and *

dPop(1:(N*N))= nu - beta.*S.*(m*I) - mu.*S;
dPop((N*N)+[1:(N*N)])= beta.*S.*(m*I) - gamma.*I - mu.*I;



%Calculates which grid a particular location is in
function G=WhichGrid(x,y,XRange,YRange,XNum,YNum)

G=floor(x*XNum/XRange)*YNum+floor(y*YNum/YRange)+1;


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


