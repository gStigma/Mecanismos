%Análisis de posición de un mecanismo de 4 barra

clc
clear all

%Datos de entrada
a=2;  %Longitud de la manivela
b=7;  %Longitud del acoplador
c=9;  %Longitud del balancin
d=6;  %Longitud de la bancada
THETA1 =0; %ángulo de la bancada en grados
TETHAinicial = 0;  %Angulo de la manivela en la posición estacionaria en grados;
omega2=10;   %Velocidad de la manivela en RPM

% Se pasan los angulos a radianes y se calcula el tiempo total del recorrido
theta1=THETA1*pi/180; %Angulo de la Bancada en radianes
OMEGA2=omega2*2*pi/60; %Velocidad de la manivela en rad/seg.
tiempototal=(2*pi)/OMEGA2;  %tiempo total del recorrido


%Division de 360 grados y del tiempo en una vuelta completa de la manivela
jnodos=360;
dtheta=360/(jnodos);
dtiempo=tiempototal/jnodos;

%analisis de la posición de mecanismos de 4 barras

for j=1:jnodos+1
    tiempo(j)=(j-1)*dtiempo; %Iniciamos en tiempo cero
    THETA2(j)=(j-1)*dtheta+TETHAinicial; % Angulo de la manivela en grados
    theta2(j)=THETA2(j)*pi/180; %angulo de la manivela en radianes
    
    k1=d*cos(theta1)-a*cos(theta2(j));
    k2=d*sin(theta1)-a*sin(theta2(j));
    k3=k1^2+k2^2+c^2-b^2;
    k4=c^2-b^2-k1^2-k2^2;
    
    A1=k3-2*k1*c;
    B1=4*k2*c;
    C1=2*k1*c+k3;
    
    A2=k4-2*k1*b;
    B2=4*k2*b;
    C2=2*k1*b+k4;
   
    %Calculo de posiciones angulares
    tantheta31=(-B2+sqrt(B2^2-4*A2*C2))/(2*A2);
    tantheta32=(-B2-sqrt(B2^2-4*A2*C2))/(2*A2);
    tantheta41=(-B1+sqrt(B1^2-4*A1*C1))/(2*A1);
    tantheta42=(-B1-sqrt(B1^2-4*A1*C1))/(2*A1);
    
    theta3c(j)=2*atan(tantheta31);
    theta3a(j)=2*atan(tantheta32);
    theta4c(j)=2*atan(tantheta41);
    theta4a(j)=2*atan(tantheta42);
        
    THETA3c(j)=2*atan(tantheta31)*180/pi; % theta3 cruzado
    THETA3a(j)=2*atan(tantheta32)*180/pi; % theta3 abierto
    THETA4c(j)=2*atan(tantheta41)*180/pi; %theta4 cruzado
    THETA4a(j)=2*atan(tantheta42)*180/pi; %theta4 abierto
    
    %claculo del angulo de transmisión
    miu(j) = abs(THETA4a(j)-THETA3a(j));
    if miu(j) >90
        miu(j) = 180-miu(j);
    end
     
end

%A CONTINUACION GRAFICAMOS LOS RESULTADOS OBTENIDOS

%posiciones angulares
figure(1)
plot(THETA2,THETA3c)
xlabel('theta 2 (grados)')
ylabel('theta3 cruzado (grados)')
grid on

figure(2)
plot(THETA2,THETA3a)
xlabel('theta 2 (grados)')
ylabel('theta3 abierto (grados)')
grid on

figure(3)
plot(THETA2,THETA4c)
xlabel('theta 2 (grados)')
ylabel('theta4 cruzado (grados)')
grid on

figure(4)
plot(THETA2,THETA4a)
xlabel('theta 2 (grados)')
ylabel('theta4 abierto (grados)')
grid on

figure(5)
plot(THETA2,miu)
xlabel('theta2 (grados)')
ylabel('angulo de transmisión (grados)')
grid on