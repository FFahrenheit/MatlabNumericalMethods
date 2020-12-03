function Programa02_E3
    clc;
    clear all;
    close all;
    
    %Variables auxiliares
    error = 0.0001;
    completo = false;
    iteraciones = 1;
    
    %Estimaciones iniciales
    x1n = 100;
    x2n = 50;
    x3n = 250;
    
    while(completo==false)
        x1 = getX1(x2n,x3n);
        x2 = getX2(x1,x3n);
        x3 = getX3(x1,x2);
        fprintf("\t\tIteracion %d\n",iteraciones);
        fprintf("x1=%.4f\tx2=%.4f\tx3=%.4f\n",x1,x2,x3);
        dif1 = (x1-x1n);
        dif2 = (x2-x2n);
        dif3 = (x3-x3n);
        fprintf("d1=%.4f\td2=%.4f\td3=%.4f\n",dif1,dif2,dif3);
        if(abs(dif1)>error || abs(dif2)>error || abs(dif3)>error)
            x1n = x1;
            x2n = x2;
            x3n = x3;
            iteraciones = iteraciones + 1;
        else
            completo = true;
        end
        input('Presione enter para continuar','s');
    end
    fprintf("\n\nSoluciones encontradas:\n");
    fprintf("x1=%.4f\nx2=%.4f\nx3=%.4f\n",x1,x2,x3);
end

%Funciones para evaluar x1, x2, x3
function [res] = getX1(x2,x3)
    res = (1/8.15)*(1458 - 3.91*x2 - 1.1*x3);
end

function [res] = getX2(x1,x3)
    res = (1/8.81)*(1321 - 3.76*x1 - 1.19*x3);
end

function [res] = getX3(x1,x2)
    res = (1/4.35)*(1416 - 1.16*x1 - 1.82*x2);
end