function Programa_E1
    clc;
    close all;
    clear all;
    
    epsilon = 0.0001;
    initialGuess = 2.5;
    iterations = 0;
    check = false;
    xNow = initialGuess;
    
    newtonRhapsonFigure = figure('Name','NewtonRhapson','MenuBar','none');
    title('Metodo Newton Rhapson');
    xlabel('x');
    ylabel('x^3 - 2x^2 - 1');
    set(newtonRhapsonFigure, 'Position',  [100, 250, 500, 400]);
    nrF = gca;
    grid on;
    hold on;
    
    newtonRhapsonGraph = figure('Name','NewtonRhapsonGraph','MenuBar','none');
    title('Grafica ecuacion');
    xlabel('x');
    ylabel('x^3 - 2x^2 - 1');
    set(newtonRhapsonGraph, 'Position',  [610, 250, 500, 400]);
    nrG = gca;
    grid on;
    hold on;
    
    input("Presione enter para empezar el metodo");
    
    while(check==false)
        fx = getFunction(xNow);
        iterations = iterations + 1;
        
        x = 0:epsilon:5;
        y = getFunction(x);
        
        xNext = xNow - fx / getDerivative(xNow);
        fx1 = getFunction(xNext);
        sigma = abs(xNow-xNext);

        tangentLine  = (fx1 - fx)/(xNext - xNow);
        m = tangentLine.*(x-xNow) + fx;
        
        line(nrG,[0 5], [0 0], 'color', 'k','LineWidth',2);
        plot(nrG,x,m,'color','g','LineWidth',2);
        plot(nrG,x,y,'color',[250/255 20/255 255/255],'LineWidth',2);
        plot(nrG,xNow, fx, 'r.', 'MarkerSize', 15);
        plot(nrG,xNext, fx1, 'b.','MarkerSize',15);
        legend(nrG, "y=0","Linea tangente","f(x)",strcat("x",num2str(iterations)),strcat("x",num2str(iterations+1)));

        
        line(nrF,[0 5],[0 0],'color','k','LineWidth',2)
        plot(nrF,x,m,'color','g','LineWidth',2);
        plot(nrF,x,y,'color',[250/255 20/255 255/255],'LineWidth',2);
        plot(nrF,xNow, fx, 'r.', 'MarkerSize', 15);
        plot(nrF,xNext, fx1, 'b.','MarkerSize',15);
        legend(nrF, "y=0","Linea tangente","f(x)",strcat("x",num2str(iterations)),strcat("x",num2str(iterations+1)));

        
        fprintf("Iteracion: %i\nx%i: %.4f (%.4f)\n",iterations,iterations,xNow,fx);
        fprintf("x%i: %.4f (%.4f)\nCriterio: %.4f\n\n",iterations+1,xNext,fx1,sigma);
        if(sigma <= epsilon)
            check = true;
        else
            input("Presione enter para continuar con la siguiente iteracion");
            xCenter = xNext;
            xLim = [xCenter-sigma*.8 xCenter+sigma*.8];
            yLim = [getFunction(xLim(1)) getFunction(xLim(2))];
            ylim(nrF,yLim)
            xlim(nrF,xLim);
            cla(nrF);
            cla(nrG);
            xNow = xNext;
         end
    end
    fprintf("Solucion: %0.4f\n\n",xNow);
    input("");
    close all;
end

function [fx] = getFunction(x)
    fx = x.^3 - 2.*x.^2-1;
end 

function [fx] = getDerivative(x)
    fx = 3*x^2 - 4*x;
end