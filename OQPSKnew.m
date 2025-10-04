clc;
clear all;
close all;

n=10;
Tb=1;
fc=1;
t=(0:Tb/100:2*Tb);
m=round(rand(1,n));
c1=(sqrt(2/Tb))*cos(2*pi*fc*t);
c2=(sqrt(2/Tb))*sin(2*pi*fc*t);

subplot(5,2,1);
stem(m);
title('Binary data bits');xlabel('n---->');ylabel('b(n)---->');grid on;

subplot(5,2,2);
plot(t,c1);
title('Carrier Signal-1');xlabel('t---->');ylabel('c1(t)');grid on;

subplot(5,2,3);
plot(t,c2);
title('Carrier Signal-2');xlabel('t---->');ylabel('c2(t)');grid on;
p1=-Tb; p2=Tb; p3=0; p4=2*Tb;

for i=1:2:n
    r1=(p1:Tb/100:p2);
    if m(i)==1
        m_s(i,:)=ones(1,length(r1))
    else
        m_s(i,:)=-1*ones(1,length(r1))
    end
    subplot(5,2,5);
    plot(r1,m_s(i,:));
    axis([-2 n -2 2]);
    title('Odd Bits');
    grid on
    hold on
    
    odd_sig(i,:)=c1.*m_s(i,:)
    
    subplot(5,2,6);
    plot(r1,odd_sig(i,:));
    axis([-2 n -2 2]);
    title('Odd Signal');
    grid on
    hold on
    
    r2=(p3:Tb/100:p4);
    if m(i+1)==1 
        m_s(i,:)=ones(1,length(r2))
    else
        m_s(i,:)=-1*ones(1,length(r2))
    end
    subplot(5,2,7);
    plot(r2,m_s(i,:));
    axis([-2 n -2 2]);
    title('Even Bits');
    grid on
    hold on
    
    even_sig(i,:)=c2.*m_s(i,:)
    subplot(5,2,8);
    plot(r2,even_sig(i,:));
    axis([-2 n -2 2]);
    title('Even Signal');
    grid on
    hold on
    
    oqpsk(i,:)=(odd_sig(i,:))+(even_sig(i,:))
    zq=p3:Tb/100:p4;
    subplot(5,2,9);
    plot(zq,oqpsk(i,:));
    axis([-2 n -2 2]);
    title('OQPSK Modulated Signal');
    grid on
    hold on
    p1=p1+(2*Tb); p2=p2+(2*Tb); p3=p3+(2*Tb); p4=p4+(2*Tb);
end


kd1=0;kd2=Tb
for i=1:n-1
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
kd1=kd1+(2*Tb+.01); kd2=kd2+(2*Tb+.01);
end
