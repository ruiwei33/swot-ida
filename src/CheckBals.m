function CheckBals(Truth,Obs,D,Prior,C,R,Estimate)

[Delta,DeltaA,B,~,~,~,qhatv] =  InitializeMetropolis (D,C,Prior,R);

[f,dQdxv,dAdtv]=CalcLklhd(Obs,Truth.A0',Truth.n,D,Prior,Delta,DeltaA,B,qhatv);

A0v=reshape((Truth.A0'*ones(1,D.nt))',D.nR*D.nt,1);
nv=reshape((Truth.n*ones(1,D.nt))',D.nR*D.nt,1);        
Qv=1./nv.*(A0v+Obs.dAv).^(5/3).*Obs.wv.^(-2/3).*sqrt(Obs.Sv);

Qtv=reshape(Truth.Q',D.nR*D.nt,1);
dQdxtv=Delta*Qtv;

dQdxcv=Delta*(Qv);

figure(9) 
minvalt=min([min(dQdxv) min(dAdtv) min(dQdxtv)]);
maxvalt=max([max(dQdxv) max(dAdtv) max(dQdxtv)]);

subplot(211)
plot(dQdxtv,-dAdtv,'o',[minvalt maxvalt],[minvalt maxvalt],'LineWidth',2)
xlabel('dQ/dx, m^2/s')
ylabel('-dA/dt, m^2/s')
title('True Q')
subplot(212)
plot(dQdxv,-dAdtv,'o',dQdxcv,-dAdtv,'o',[minvalt maxvalt],[minvalt maxvalt],'LineWidth',2)
xlabel('dQ/dx, m^2/s')
ylabel('-dA/dt, m^2/s')
title('Manning approximate Q')

figure(10)
minval=min([min(Qtv) min(Qv)]);
maxval=max([max(Qtv) max(Qv)]);
plot(Qtv,Qv,'o',[minval maxval],[minval maxval],'LineWidth',2)
set(gca,'FontSize',14)
xlabel('True discharge, m^3/s')
ylabel('Manning discharge with true A_0,n, m^3/s')
title('Manning applicability check with true parameters')
% 
% [f,dQdxv,dAdtv]=CalcLklhd(Obs,Estimate.A0hat,Estimate.nhat,D,Prior,Delta,DeltaA,B,qhatv);
% 
% figure(11)
% plot(dQdxv,-dAdtv,'o',[minvalt maxvalt],[minvalt maxvalt],'LineWidth',2)
% set(gca,'FontSize',14)
% xlabel('dQ/dx, m^2/s')
% ylabel('-dA/dt, m^2/s')
% title('Q hat')



return