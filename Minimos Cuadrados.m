function Proyecto_E14
  clear all;
  close all;
  clc;
  warning('off', 'all');
  
  intF = crearFigura();
  
  n = 100;
  dif = 50;
    
  for i = 1:n
    x(i) = i*dif;
    vector  = generarVector(x(i));
    tic;
    burbujaMejorado(vector);
    y(i) = toc * 1000;
    fprintf("n = %d\tt = %d\n",x(i),y(i));
  endfor
  
  input("Presione una tecla para continuar...");
  
  plot(intF,x,y,'-*c','LineWidth',1,'DisplayName','Puntos');
  legend('Location','southeast');

  input("Presione una tecla para continuar...");  
  curvaSuave(x,y,intF);
  
  polinomios = 3;
      
  for i = 1:polinomios*2
    xSum(i) = obtenerSumatoria(x,i);
  endfor
  
  for i = 1:polinomios+1
    xySum(i) = obtenerSumaXY(x,y,i-1);
  endfor
  
  x = 0 : n*dif;
  
  colors = ['g','r','b'];
  for i = 1:polinomios
    input("Presione una tecla para continuar...");
    res = obtenerFuncion(xSum,xySum,i,length(x));
    imprimirEcuacion(res);
    m = abs(min(res));
    imprimirEcuacion(res./m);
    y = obtenerLinea(res,x);
    plot(x, y, '-','LineWidth',3,'Color',colors(i),'DisplayName',cstrcat("Polinomio grado ",num2str(i)));  
    legend('off');
    legend('show');
    legend('Location','southeast');  
  endfor
  
  disp("Ingrese el numero de elementos o 0 para salir");
  
  do
    n = input("Ingrese el numero de elementos: ");
    t = obtenerLinea(res,n);
    fprintf("En promedio, el algoritmo tardara %dms en ordenar %d elementos\n",t,n);
  until ( n == 0);

 disp("Gracias por usar este programa!"); 
 
endfunction

%Esta funcion define una grafica con ejes definidos (cantidad de elementos, tiempo)
%Se ponen los titulos, nombre de ejes, el tama�o, etc...
function intF = crearFigura()
  fig = figure('Name','Metodos de ordenamiento','MenuBar','none');
  title('Complejidad en tiempo algoritmo burbuja mejorado');
  xlabel('Cantidad de elementos');
  ylabel('Tiempo(ms)');
  set(fig, 'Position',  [100, 150, 800, 500]);
  intF = gca;
  grid on;
  hold on;
endfunction 

%Genera un vector con datos al azar de tama�o n 
%usando la funcion nativa randperm (rango de 0 a 1000000)
function vector = generarVector(n)
  vector = randperm(1000000,n);
endfunction

%El metodo de ordenamiento en cuesti�n
%Recorre el vector n veces, obtiene el mayor y lo coloca al 
%final del vector. Si no hay cambios en una iteracion, se termina
function vector = burbujaMejorado(vector)
  n = length(vector);
  for i = 1:n
    for j = 1:(n-1)
      cambios = false;
      if j > (n-i)
        break;
      endif  
      if vector(j) > vector(j+1) 
        temp = vector(j);
        vector(j) = vector(j+1);
        vector(j+1) = temp;
        cambios = true;
      endif
    endfor
    if cambios == false
      return
    endif
  endfor
endfunction

%Grafica los puntos dados con una curva suave usando un espacio lineal
%propio de matlab
function curvaSuave(x,y,fig)
  lengthX = length(x);  
  samplingRateIncrease = 10;
  newXSamplePoints = linspace(min(x), max(x), lengthX * samplingRateIncrease);
  smoothedY = spline(x, y, newXSamplePoints);
  plot(newXSamplePoints, smoothedY, '-m','LineWidth',2,'DisplayName','Curva suave');
  legend('off');
  legend('show');
  legend('Location','southeast');
  zoom on;
endfunction

%Obtiene la suma de los valores de un vector a cierta potencia
%recorriendo el vector y sumandolo en un acumulador
function total = obtenerSumatoria(vector,pot)
  total = 0;
  for i = 1:length(vector)
    total += vector(i).^pot;
  endfor
endfunction

%Obtiene la suma de los valores de x a una potencia por los valores de y
%usando un acumulador y un ciclo
function total = obtenerSumaXY(x,y,pot)
  total = 0;
  for i = 1:length(x)
    total += x(i).^pot .* y(i);
  endfor
endfunction

%Funcion auxiliar para el metodo de minimos cuadrados
%Genera la fila de la matriz del sistema de ecuaciones
%usando un ciclo y colocando el coeficiente en su lugar basado
%en las sumas de X
function vector = obtenerEcuacion(orden,n,sumaX,terminos)
  for i = 1:orden+1
    if i == 1 && n == 1
      vector(1) = terminos;
    else 
      vector(i) = sumaX(n-2+i);
    endif
  endfor
endfunction

%Genera la matriz A y Y del sistema de ecuaciones para el m�todo
%de minimos cuadrados
function res = obtenerFuncion(xSum,xySum,i,terminos)
  fprintf("Polinomio grado %d\n",i);
  coefMatr = zeros(i+1,i+1);
  coefSol = zeros(i+1);
  for j = 1:i+1
    coefEq = obtenerEcuacion(i,j,xSum,terminos);
    for k = 1:length(coefEq);
      coefMatr(j,k) = coefEq(k);
    endfor
    coefSol(j) = xySum(j);
  endfor
  res = linsolve(coefMatr,coefSol);
endfunction

%Imprime los coeficientes de la matriz solucion de forma algebraica
%ejemplo: [1 2 3] = 1 + 2x + 3x^2
function imprimirEcuacion(res)
  for i = 1:length(res)
    if i != 1
      if res(i) > 0
        fprintf(" + %dx^%d",res(i),i-1);
      else
        fprintf(" - %dx^%d",abs(res(i)),i-1);
      endif
    else
      fprintf("%d",res(i));
    endif
  endfor
  fprintf("\n");
endfunction

%Evalua la matriz solucion en un punto "X"
%manejandola como un polinomio
function y = obtenerLinea(res,x)
  y = 0;
  for i = 1:length(res)
    y += res(i).*x.^(i-1);
  endfor
endfunction