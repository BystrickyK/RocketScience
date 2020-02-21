close all

data = linearOutput.linear;
Time = linearOutput.tout;

rows_ = size(data.x.Data, 1);

samples = 500;
figLimits = [min(data.x.Data(1:samples))-10, max(data.x.Data(1:samples))+10;
             min(data.y.Data(1:samples))-10, max(data.y.Data(1:samples))+10];

%%
f1 = figure;
for row = 1:1:rows_    
    %% poloha rakety
    x = data.x.Data(row);
    y = data.y.Data(row);
    
    %% smer osy rakety -> osa y relativnich souradnic
    %alpha = table2array(data(row, 'alpha'));
    alpha = data.alpha.Data(row);
    [xH, yH] = pol2cart(alpha + pi/2, 50);
    
    %% Rychlost
    xR = data.xPrime.Data(row);
    yR = data.yPrime.Data(row);
    v = sqrt(xR^2 + yR^2);
    beta = data.beta.Data(row)
    %xR = table2array(data(row, 'xPrime'));
    %yR = table2array(data(row, 'yPrime'));
    
    %% vykreslovani
    subplot(121)
    cla
    hold on
    grid on
    
    quiver( x, y,...
        xH, yH,...
        'Color', 'Black',...
        'LineWidth', 3,...
        'Marker', '*');
    
    quiver( x, y,...
        xR, yR,...
        'Color', 'Red');
    
    time = Time(row);
    title("T = " + time + " s  \beta = " + rad2deg(beta) + "{^o}  v = " + v + "m s^{-1}" );
    
   axis equal
   %xlim([-50, 400])
   %ylim([-50, 300])
   xlim([x-150, x+150])
   ylim([y-150, y+150])
   
    subplot(122)
   hold on
   grid on
   axis equal
   plot(x, y, 'k.');
   samples = 300;
   xlim([min(data.x.Data(1:samples))-10, max(data.x.Data(1:samples))+10])
   ylim([min(data.y.Data(1:samples))-10, max(data.y.Data(1:samples))+10])
   
   if (x > figLimits(1,2))
       xlim([figLimits(1), x + 100])
   end
   if (y > figLimits(2,2))
       ylim([figLimits(2,1), y + 100])
   end
   
   
   
   drawnow
end
