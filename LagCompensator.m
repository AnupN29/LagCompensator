% defining open-loop transfer function G(s) 
s = tf('s');
G = 10 / (s*(s +3)*(s^2 + 2*s + 5));


% defining  new G(s), for increase in ramp error constant by factor of 30
G1 = 30*G;



% calculating damping ratio, for maintaining overshoot =< 11 percentage
d = sqrt((((log(0.11))^2)/((pi^2) +((log(0.11))^2))));


% required phase margin
PM =10 + (atan((2*d)/(sqrt(-2*(d^2) + sqrt(1 + 4*(d^4)))))*180/pi);

pAngle = PM - 180; % phase angle

Wgco = 0.514; % requried Gain crossover frequency from bode plot

LAGmag = -31.9; % required lag compensator maginude at Wgco 

% defining required lag compensator transfer function

Gc = 0.025409728*(s + 0.0514)/(s + 0.00130606);


% compensated open-loop transfer function 
Gcompensated = G1*Gc;


% Bode plots 
bode(G1);
hold on 
bode(Gc);
bode(Gcompensated)
hold off
legend('Uncompensated G','Lag compensator','compensated G' )

% compensated closed-loop transfer function

Tcompensated = Gcompensated/(1 + Gcompensated);

% Unit step input
figure;step(Tcompensated);
hold on
yline(1)
hold off 
legend('System Response','Step Input')

% Finding Settling time and Bandwidth
info = stepinfo(Tcompensated);
disp(info)
BW = bandwidth(Tcompensated); 
disp('Bandwidth:') 
disp(BW)
