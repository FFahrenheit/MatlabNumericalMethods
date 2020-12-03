function Programa04_E3
  clear all;
  clc;
  close all;
  
  %Informacion de la tabla
  data = [0,
          1.5297,
          9.5120,
          8.7025,
          2.8087,
          1.0881,
          0.3537];
  h = (30 - 0)/6;  % => 5
  
  for i = 1:length(data)
    xPoints(i) = (i-1)*h; 
  endfor
  
  %Grafica 
  nCotes = figure('Name','Newton Cotes','MenuBar','none');
  title('Calculo trabajo variable');
  xlabel('x');
  ylabel('f(x)');
  set(nCotes, 'Position',  [100, 250, 500, 400]);
  intF = gca;
  grid on;
  hold on;
  
  lengthX = length(data);
  y = data;
  x = xPoints;
  
  plot(intF,x,y,'-*r','LineWidth',1,'DisplayName','Data inicial','LineWidth',2);
  legend('Location','southeast');
  
  %Impresion de la curva suave
  samplingRateIncrease = 10;
  newXSamplePoints = linspace(min(x), max(x), lengthX * samplingRateIncrease);
  smoothedY = spline(x, y, newXSamplePoints);
  plot(newXSamplePoints, smoothedY, '-b','LineWidth',2,'DisplayName','Curva suave');
  legend('Location','southeast');
  legend('off');
  legend('show');
  legend('Location','southeast');
  zoom on;
  
  x1 = getCompositeTrapeze(smoothedY, h/10);
  x2 = getSimpson1over3(smoothedY, h/10);
  x3 = getSimpson3over8(smoothedY, h/10);
  clc; 
    
  disp("\n\nTrapecio compuesto");
  getCompositeTrapeze(data,h);
  
  disp("\n\nSimpson 1/3");
  getSimpson1over3(data,h);
  
  disp("\n\nSimpson 3/8");
  getSimpson3over8(data,h);
  
  fprintf("\n\n%.4f\n%.4f\n%.4f\n",x1,x2,x3);
    
endfunction

function total = getCompositeTrapeze(data,h) 
  total = data(1);
  n = length(data);
  fprintf("%d/2(%.4f + 2(",h,data(1));
  for i = 2:n-1
    if i ~= 2
      fprintf(" + ");
    endif
    fprintf("%.4f",data(i));
    total += + 2 * data(i);
  endfor
  fprintf(") + %.4f) = ",data(n));
  total += data(n);
  total *= h / 2;
  fprintf("%.4f",total);
endfunction

function total =  getSimpson1over3(data,h)
  total = data(1);
  n = length(data);
  fprintf("%d/3(%.4f + 4(",h,data(1));
  for i = 2:2:n-1
    if i ~= 2
      fprintf(" + ");
    endif
    fprintf("%.4f",data(i));
    total += 4*data(i);
  endfor
  fprintf(") + 2(");
  for i = 3:2:n-1
    if i ~= 3
      fprintf(" + ");
    endif
    fprintf("%.4f",data(i));
    total += 2*data(i);
  endfor
  fprintf(") + %.4f) = ",data(n));
  total += data(n);
  total = total*h/3;
  fprintf("%.4f",total);
endfunction

function total = getSimpson3over8(data,h)
  n = length(data);
  total = data(1);
  fprintf("(3*%d/8)(%.4f + 3(",h,data(1));
  for i = 2:n-1
    if mod(i,3) ~= 0
      if i ~= 2
        fprintf(" + ");
      endif
      fprintf("%.4f",data(i));
      total += 3*data(i);
    endif
  endfor
  fprintf(") + 2(");
  for i = 1:n-3
    if i*3 < n
      if i ~= 1
        fprintf(" + ");
      endif
      fprintf("%.4f",data(i*3));
      total += 2*data(i*3);
    endif
  endfor
  fprintf(") + %.4f) = ",data(n));
  total += data(n);
  total *= 3*h/8;
  fprintf("%.4f",total);
  endfunction