clc;
clear all;
close all;

N=10;
Tb=1;
Fc=1;
t=(0:Tb/100:2*Tb);
m=round(rand(1,N));
c1=(sqrt(2/Tb))*cos(2*pi*Fc*t);
c2=(sqrt(2/Tb))*sin(2*pi*Fc*t);

subplot(5,2,1);
stem(m);

subplot(5,2,2);
plot(t,c1);

subplot(5,2,3);
plot(t,c2);
a1=-Tb;a2=Tb;a3=0;a4=2*Tb;

for i=1:2:N
    t1=(a1:Tb/100:a2);
    if m(i)==1
        m_s(i,:)=ones(1,length(t1))
    else
        m_s(i,:)=-1*ones(1,length(t1))
    end
    subplot(5,2,5);
    plot(t1,m_s(i,:));
    axis([-2 N -2 2]);
    grid on
    hold on
    
    odd_sig(i,:)=c1.*m_s(i,:)
    
    subplot(5,2,6);
    plot(t1,odd_sig(i,:));
    axis([-2 N -2 2]);
    grid on
    hold on
    
    t2=(a3:Tb/100:a4);
    if m(i+1)==1 
        m_s(i,:)=ones(1,length(t2))
    else
        m_s(i,:)=-1*ones(1,length(t2))
    end
    subplot(5,2,7);
    plot(t2,m_s(i,:));
    grid on
    hold on
    axis([-2 N -2 2]);
    even_sig(i,:)=c2.*m_s(i,:)
    subplot(5,2,8);
    plot(t2,even_sig(i,:));
    grid on
    hold on
    axis([-2 N -2 2]);
    
    oqpsk(i,:)=(odd_sig(i,:))+(even_sig(i,:))
    tq=a3:Tb/100:a4;
    subplot(5,2,9);
    plot(tq,oqpsk(i,:));
    grid on
    hold on
    axis([-2 N -2 2]);
    a1=a1+(2*Tb); a2=a2+(2*Tb); a3=a3+(2*Tb); a4=a4+(2*Tb);
end



td1=0;td2=Tb;
for i=1:2:N
%correlator
  z1=sum(c1.*oqpsk(i,:))
  x2=sum(c2.*oqpsk(i,:))

%decision device
  if (z1>0&&x2>0)
   demod(i)=1
   demod(i+1)=1
  elseif (z1>0&&x2<0)
   demod(i)=1
   demod(i+1)=0
  elseif (z1<0&&x2<0)
   demod(i)=0
   demod(i+1)=0
  elseif (z1<0&&x2>0)
   demod(i)=0
   demod(i+1)=1
  end

  subplot(5,2,10);
  stem(i,demod(i));
  hold on
  stem(i+1,demod(i+1));
  hold on
  td1=td1+(2*Tb); td2=td2+(2*Tb);
end
