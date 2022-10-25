%Miroslav Paškevič EKSfm-22
clear all
clc
%1
x= 0.1:1/22:1;
y= ((1 + 0.6*sin(2*pi*x/0.7)) + 0.3*sin(2*pi*x))/2;
figure(1)
plot(x, y,"kx")
%2
w11_1 = randn(1); b1_1 = randn(1);
w21_1 = randn(1); b2_1 = randn(1);
w31_1 = randn(1); b3_1 = randn(1);
w41_1 = randn(1); b4_1 = randn(1);
w51_1 = randn(1); b5_1 = randn(1);

w11_2 = rand(1); b1_2 = randn(1);
w12_2 = rand(1); 
w13_2 = rand(1); 
w14_2 = rand(1); 
w15_2 = rand(1); 

mok_zing = 0.15;
for indx = 1:10000

    for n = 1:20
%3
    v1_1 = x(n)*w11_1 + b1_1;
    v2_1 = x(n)*w21_1 + b2_1;
    v3_1 = x(n)*w31_1 + b3_1;
    v4_1 = x(n)*w41_1 + b4_1;
    v5_1 = x(n)*w51_1 + b5_1;
    
    y_1 = 1/(1+exp(-v1_1)); 
    y_2 = 1/(1+exp(-v2_1));
    y_3 = 1/(1+exp(-v3_1));
    y_4 = 1/(1+exp(-v4_1));
    y_5 = 1/(1+exp(-v5_1));
    
    v1 = y_1 * w11_2 + y_2 * w12_2 + y_3 * w13_2 + y_4 * w14_2 + y_5 * w15_2 + b1_2;
    
    y_apskaiciuota = v1;
    %4
    e= y(n)-y_apskaiciuota;
    
    %5
    delta_out = e;
    
    delta_1_1 = y_1*(1-y_1)*(delta_out*w11_2);
    delta_2_1 = y_2*(1-y_2)*(delta_out*w12_2);
    delta_3_1 = y_3*(1-y_3)*(delta_out*w13_2);
    delta_4_1 = y_4*(1-y_4)*(delta_out*w14_2);
    delta_5_1 = y_5*(1-y_5)*(delta_out*w15_2);
   
    
    w11_2 = w11_2 + mok_zing*delta_out*y_1;
    w12_2 = w12_2 + mok_zing*delta_out*y_2;
    w13_2 = w13_2 + mok_zing*delta_out*y_3;
    w14_2 = w14_2 + mok_zing*delta_out*y_4;
    w15_2 = w15_2 + mok_zing*delta_out*y_5;
    b1_1 = b1_1+ mok_zing*delta_out;

    w11_1 = w11_1 + mok_zing*delta_1_1*x(n);
    w21_1 = w21_1 + mok_zing*delta_2_1*x(n);
    w31_1 = w31_1 + mok_zing*delta_3_1*x(n);
    w41_1 = w41_1 + mok_zing*delta_4_1*x(n);
    w51_1 = w51_1 + mok_zing*delta_5_1*x(n);

    b1_1 = b1_1 + mok_zing*delta_1_1;
    b2_1 = b2_1 + mok_zing*delta_2_1;
    b3_1 = b3_1 + mok_zing*delta_3_1;
    b4_1 = b4_1 + mok_zing*delta_4_1;
    b5_1 = b5_1 + mok_zing*delta_5_1;
        
    end
end
x2 = linspace(0.1,1,100);
for m = 1:100

 v1_1 = x2(m)*w11_1 + b1_1;
    v2_1 = x2(m)*w21_1 + b2_1;
    v3_1 = x2(m)*w31_1 + b3_1;
    v4_1 = x2(m)*w41_1 + b4_1;
    v5_1 = x2(m)*w51_1 + b5_1;
    
    y_1 = 1/(1+exp(-v1_1)); 
    y_2 = 1/(1+exp(-v2_1));
    y_3 = 1/(1+exp(-v3_1));
    y_4 = 1/(1+exp(-v4_1));
    y_5 = 1/(1+exp(-v5_1));
    
    v1 = y_1 * w11_2 + y_2 * w12_2 + y_3 * w13_2 + y_4 * w14_2 + y_5 * w15_2 + b1_2;
    
    y_apskaiciuota(m) = v1;


end
figure(2)
plot(x, y, "bx", x2, y_apskaiciuota, "r*")