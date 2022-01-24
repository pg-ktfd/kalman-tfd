function [tfdf,tfd] = ktfd(d,M)
%
%
%
% Description:  Time-Frequency DIstribution (TFD) estimated at each instant
%               of time using Kalman FIlter/ Smoother
%
% State-space model:    s[n+1] = A s[n] + w[n]
%                       d[n] = Phi[n]’ s[n] + e[n]
%
% Syntax:   [tfdf,tfd] = ktfd(d,M);
%
% Inputs:   d - scalar real time series with N samples
%           M - Max frequency samples (corresponds to 1 x sampling frequency)
%
% Outputs:  tfdf - Fourier Transform (complex) at each {t, f} location;
%                   Size = M x N
%           tfd  - Spectrum estimate (magnitude squared of 'tfdf') at {t,f}
%
% Reference: PG Madhavan & WJ Williams, Kalman Filtering and Time Frequency 
%            Distribution of Random Signals, SPIE Proceedings, 
%            SPIE Vol. 2846, pp. 164-173, 1996.
%
% Author:   PG Madhavan
%           pg@syansol.com
%
% Date submitted to GitHub:     25 Jan 2022
% See GitHub LICENSE!
%
%
%
N=size(d,1); % Time series column vector size
%
% Initialize Kalman variables
%
H=zeros(N,M);
ypr=zeros(1,N);
ysm=zeros(1,N);
k1=0.1;
Q=k1*eye(M);
k2=100;
r=k2;
k3=0.001;
Pf_old=(1/k3)*eye(M);
sf_old=zeros(M,1);
sp_old=zeros(M,1);
sf=zeros(M,N);
sp=zeros(M,N);
Pf=zeros(M,M,N);
v=0;
K=zeros(M,1);
%
sS_new=zeros(M,1);
PS_new=zeros(M,M);
sS=zeros(M,N);
A=eye(M);
%
E=zeros(N,M);
%
for t=1:N;
%
% Create Complex Exponential vector, 'Phi'
%
    for k=0:M-1
        E(t,k+1) = j*(((2*pi)/M)*k*t);
    end;
    E(t,:)=exp(E(t,:));
%
    H(t,:)=E(t,:);
%
% 
% UPDATES
        sp_new=A*sf_old;
        Pp_new=A*Pf_old*A'+Q;
        yprd(t)=H(t,:)*sp_new;
        %
        v=d(t)-H(t,:)*sp_old;
        Ek=H(t,:)*Pp_new*H(t,:)'+r;
        K=Pp_new*H(t,:)'*inv(Ek);
            sf_new=sp_new+K*v;
            Pf_new=Pp_new-K*Ek*K';
            yflt(t)=H(t,:)*sf_new;
%
% Copy NEW to OLD for next recursion
sp_old=sp_new;sf_old=sf_new;Pf_old=Pf_new;
%
sp(:,t)=sp_new;sf(:,t)=sf_new;
Pf(:,:,t)=Pf_new;
%
end;
%
%
% Smoothing
%
sS_new=zeros(M,1);
PS_new=zeros(M,M);
sS=zeros(M,N);
    PF=Pf; sF=sf;
    sS_new=sF(:,N); PS_new=PF(:,:,N);
%
    for n=N-1:-1:1;
        %
        sP_new=A*sF(:,n);
        PP=A*PF(:,:,n)*A' + Q;
        G=PF(:,:,n)*A'*inv(PP);
        %
            sS_old=sF(:,n)+G*(sS_new-sP_new);
            PS_old=PF(:,:,n)+G*(PS_new-PP)*G';
            ysm(n)=H(n,:)*sS_old;
        %
    % Copy OLD to NEW (!!!) for next recursion
    sS_new=sS_old;PS_new=PS_old;
    %
    sS(:,n)=sS_new;
    %
    end;
%
%tfdf=flipud(sf); %Kalman FILTER States
tfdf=flipud(sS); % Kalman SMOOTHER States
%
tfd=zeros(M,N);
tfd=abs(tfdf.*tfdf)/(M);
end
%
%
%

