function Programa03_E3
    %Limpieza
    clc;
    clear;
    close all;
    format short;
    
    %Inicializacion de datos
    xData = [1.9,  3.7,  5.5,  7.3];
    yData = [14.4, 28.7, 43.1, 52.7];
    
    z = 4.5;
    
    polynomials = 3;
    
    n = length(xData);
    
    %Muestra del problema
    disp("       Datos a interpolar:");
    fprintf("Profundidad\t\tEsfuerzo\n");
    for i = 1:n
        fprintf("%.4f\t\t\t%.4f\n",xData(i),yData(i));
    end
    
    input('Presione enter para continuar...','s');
    
    %Grafica de la data
    interpolation = figure('Name','Lagrange','MenuBar','none');
    title('Interpolacion por Lagrange');
    xlabel('Profunidad (m)');
    ylabel('Esfuerzo (kPa)');
    set(interpolation, 'Position',  [100, 250, 500, 400]);
    intF = gca;
    grid on;
    hold on;
    
    lengthX = length(xData);
    x = xData;
    y = yData;
    
    plot(intF,x,y,'-*r','LineWidth',1,'DisplayName','Data inicial');
    legend('Location','southeast');
    
    disp("Grafica elaborada");
    input('Presione enter para continuar...','s');
    
    %Muestra de polinomios
    for i = 1:polynomials
        fprintf("\n Polinomio de grado %d\n",i);
        total = 0;
        for j = 1:i+1
            if j ~= 1
                fprintf("\n + ");
            end
            fprintf("%.4f",yData(j));
            up = upsidePart(xData,i+1,j,z);
            fprintf("/(");
            down = downsidePart(xData,i+1,j,z);
            fprintf(")");
            total = total + yData(j)*up/down;
        end
        color = [rand rand rand];        
        plot(intF,z,total,'.','MarkerSize',12,'Color',color,'DisplayName',cstrcat("Polinomio grado ",num2str(i)));
        legend('off');
        legend('show');
        legend('Location','southeast');
        fprintf(" = %.4f\n",total);
        input('Presione enter para continuar ...','s');
    end
    
    fprintf("\nRespuesta final: %.4f\n\n",total);

    %Impresion de la curva suave
    samplingRateIncrease = 10;
    newXSamplePoints = linspace(min(x), max(x), lengthX * samplingRateIncrease);
    smoothedY = spline(x, y, newXSamplePoints);
    plot(newXSamplePoints, smoothedY, '-b','LineWidth',2,'DisplayName','Curva suave');
    plot(intF,z,total,'.k','MarkerSize',15,'DisplayName',"Respuesta final");
    legend('off');
    legend('show');
    legend('Location','southeast');
    zoom on;
    disp("Compare resultados");
    
    input('Presione enter para finalizar el programa','s');
end

%Funcion para obtener el numerador
function [total] = upsidePart(data,t,k,x)
	total = 1;
    for i = 1:t
        if i~= k
            total = total * (x - data(i));
            fprintf("(%.4f - %f)",x,data(i));
        end 
    end
end

%Funcion para obtener el denominador
function total = downsidePart(data,t,k,x)
    total = 1;
    for i = 1:t
        if i~=k
            total = (total * (data(k) - data(i)));
            fprintf("(%.4f - %.4f)",data(k),data(i));
        end
    end
end