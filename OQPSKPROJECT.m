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
title('Binary data bits');xlabel('n---->');ylabel('b(n)---->');grid on;

subplot(5,2,2);
plot(t,c1);
title('Carrier Signal-1');xlabel('t---->');ylabel('c1(t)');grid on;

subplot(5,2,3);
plot(t,c2);
title('Carrier Signal-2');xlabel('t---->');ylabel('c2(t)');grid on;
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
    title('Odd Bits');
    grid on
    hold on
    
    odd_sig(i,:)=c1.*m_s(i,:)
    
    subplot(5,2,6);
    plot(t1,odd_sig(i,:));
    axis([-2 N -2 2]);
    title('Odd Signal');
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
    axis([-2 N -2 2]);
    title('Even Bits');
    grid on
    hold on
    
    even_sig(i,:)=c2.*m_s(i,:)
    subplot(5,2,8);
    plot(t2,even_sig(i,:));
    axis([-2 N -2 2]);
    title('Even Signal');
    grid on
    hold on
    
    oqpsk(i,:)=(odd_sig(i,:))+(even_sig(i,:))
    tq=a3:Tb/100:a4;
    subplot(5,2,9);
    plot(tq,oqpsk(i,:));
    axis([-2 N -2 2]);
    title('OQPSK Modulated Signal');
    grid on
    hold on
    a1=a1+(2*Tb); a2=a2+(2*Tb); a3=a3+(2*Tb); a4=a4+(2*Tb);
end


td1=0;td2=Tb
for i=1:N-1
x1=sum(c1.*oqpsk(i,:));
x2=sum(c2.*oqpsk(i,:));

if (x1>0&&x2>0)
demod(i)=1;
demod(i+1)=1;
elseif (x1>0&&x2<0)
demod(i)=1;
demod(i+1)=0;
elseif (x1<0&&x2<0)
demod(i)=0;
demod(i+1)=0;
elseif (x1<0&&x2>0)
demod(i)=0;
demod(i+1)=1;
end

subplot(5,2,10);
stem(i,demod(i));
title('Demodulated Signal');
td1=td1+(2*Tb+.01); td2=td2+(2*Tb+.01);
end
