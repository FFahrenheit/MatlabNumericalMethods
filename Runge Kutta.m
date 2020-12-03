function Programa05_E3
  clc;
  clear all;
  close all;
  
  %Valores iniciales
  x0 = 0;
  y0 = 1;
  
  xf = 0.5;
  
  %Numero de subintervalos
  n = 5;
  
  %Calculo de h
  h = (xf-x0)/n;
  fprintf("h = (%f - %f)/%d = %.4f\n",xf,x0,n,h);
  
  xn = x0;
  yn = y0;
  
  %Procesos por intervalo
  for i = 1:n
    fprintf("*** Intervalo %d ***\n",i);
    
    xi = xn;
    yi = yn;
    
    xn = xi + h;
    fprintf("x%d = %.4f + %.4f = %.4f\n",i,xi,h,xn);
    
    fprintf("k1 = f(%.4f,%.4f) = ",xi,yi);
    k1 = getFunction(xi,yi);
    
    fprintf("k2 = f(%.4f + %.4f/2, %.4f + %.4f*%.4f/2) = ",xi,h,yi,h,k1);
    k2 = getFunction(xi + h/2, yi + h*k1/2);
    
    fprintf("k3 = f(%.4f + %.4f/2, %.4f + %.4f*%.4f/2) = ",xi,h,yi,h,k2);
    k3 = getFunction(xi + h/2, yi + h*k2/2);

    fprintf("k4 = f(%.4f + %.4f, %.4f + %.4f*%.4f) = ",xi,h,yi,h,k3);
    k4 = getFunction(xi + h, yi + h*k3);

    yn = yi + (h/6)*(k1+2*k2+2*k3+k4);
    fprintf("y%d = %.4f/6*(%.4f + 2*%.4f + 2*%.4f + %.4f) = %.4f\n",i,h,k1,k2,k3,k4,yn);   %Valor de y(0.5) 
  endfor
  
  disp("**Resultado final***");
  fprintf("Valor para f'(%.4f) = ",xf);
  result = getFunction(xf, yn);
  
endfunction

%Evaluacion de la funcion 
function res = getFunction(x,y)
  res = x - y + 1;  
  fprintf("%.4f - %.4f + 1 = %.6f\n",x,y,res);
endfunction
