close all

data = nonlinearOutput.nonlinear;
Time = nonlinearOutput.tout;

rows_ = size(data.x.Data, 1);

% nastaveni pocatecni velikosti okna s trajektorii letu
samples = 820;
figLimits = [min(data.x.Data(1:samples))-10, max(data.x.Data(1:samples))+10;
             min(data.y.Data(1:samples))-10, max(data.y.Data(1:samples))+10];
%%
f1 = figure;
% animaci lze zrychlit pomocí úpravy kroku, nap?. p?i 1:3:rows_ se
% vykresluje pouze kadı t?etí vzorek
for row = 1:1:rows_    
    %% poloha rakety
    x = data.x.Data(row);
    y = data.y.Data(row);

    %% rychlost rakety
    velocity = data.velocity.Data(row);    
    %% smer osy rakety -> osa y relativnich souradnic
    alpha = data.alpha.Data(row);
    [xH, yH] = pol2cart(alpha + pi/2,90);
    
    %% Rychlost
    xR = data.xPrime.Data(row);
    yR = data.yPrime.Data(row);
    beta = atan2(yR, xR);
    v = sqrt(xR^2 + yR^2);
    
    %% gimbaling
    phi = data.gimbalAngle.Data(row);
    thrust = data.thrust.Data(row);
    phi = alpha + phi - pi/2;
    [xT, yT] = pol2cart(phi, thrust/50);
    
    %% Sily
    FX = data.F_X.Data(row);
    FY = data.F_Y.Data(row);
    
    [FXx, FXy] = pol2cart(0, FX);
    [FYx, FYy] = pol2cart(pi/2, FY);
    
    FXx = FXx / 20;
    FXy = FXy / 20;
    FYx = FYx / 20;
    FYy = FYy / 20;
    
    Ftotal = sqrt(FX^2 + FY^2);

    
    %% vykreslovani
    subplot(1, 2, 1);
    cla
    hold on
    grid on
    
    quiver( x, y,...
        xH, yH,...
        'Color', 'Black',...
        'LineWidth', 5,...
        'Marker', '*')
    
    quiver( x, y,...
        xR, yR,...
        'Color', 'Red')
    
    quiver( x, y,...
        xT, yT,...
        'Color', 'Green',...
        'LineWidth', 2, ...
        'ShowArrowHead', 'off'); 
    
    quiver( x, y,...
        FXx, FXy,...
        'Color', 'Cyan',...
        'LineWidth', 2); 
    
    quiver( x, y,...
        FYx, FYy,...
        'Color', 'Blue',...
        'LineWidth', 2); 
    
    time = Time(row);
    title("T = " + time + " s   F = " + Ftotal + " N    \beta = " + rad2deg(beta) + "{^o}    v = " + v + "m s^{-1}" );
    
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
   
   xlim([figLimits(1,1), figLimits(1,2)])
   ylim([figLimits(2,1), figLimits(2,2)])
   if (x > figLimits(1,2))
       xlim([figLimits(1), x + 100])
   end
   if (y > figLimits(2,2))
       ylim([figLimits(2,1), y + 100])
   end
%   xlim([min(data.x.Data(1:samples))-10, x + 1000])
%  ylim([min(data.y.Data(1:samples))-10, y + 1000])
   
   drawnow
end
