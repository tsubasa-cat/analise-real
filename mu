deg2rad = pi/180;      
rad2deg = 1/deg2rad;   
gV = 0.146418;         
tan_theta0 = 0.14;     
alpha0 = 8*deg2rad;    

Ybeta = ureal('Ybeta',-0.082,'Percentage',10);
Yp = ureal('Yp',0.010827,'Percentage',10);
Yr = ureal('Yr',0.060268,'Percentage',10);
Ydeltap = ureal('Ydeltap',0.002,'Percentage',10);
Ydeltar = ureal('Ydeltar',0.0118,'Percentage',10);
Lbeta = ureal('Lbeta',-0.84,'Percentage',10);
Lp = ureal('Lp',-0.76,'Percentage',10);
Lr = ureal('Lr',0.74,'Percentage',10);
Ldeltap = ureal('Ldeltap',0.095,'Percentage',10);
Ldeltar = ureal('Ldeltar',0.06,'Percentage',10);
Nbeta = ureal('Nbeta',0.092,'Percentage',10);
Np = ureal('Np',-0.23,'Percentage',10);
Nr = ureal('Nr',-0.114,'Percentage',10);
Ndeltar = ureal('Ndeltar',-0.151,'Percentage',10);

A = [Ybeta (Yp+sin(alpha0)) (Yr-cos(alpha0)) gV; ...
    Lbeta  Lp Lr 0; Nbeta Np Nr 0; 0 1 tan_theta0 0];
B = [Ydeltap Ydeltar; Ldeltap Ldeltar; 0 Ndeltar; 0 0];
C = -1/gV*deg2rad*[Ybeta Yp Yr 0];
C = [C; zeros(3,1) eye(3)];
D = -1/gV*deg2rad*[Ydeltap Ydeltar];
D = [D; zeros(3,2)];
AIRCRAFT = ss(A,B,C,D);

K = [-629.8858 11.5254 3.3110 9.4278; ...
  285.9496 0.3693 -2.6301 -0.5489];

CLOOP = feedback(P,K);

% POWER iteration / stability analysis

ropt = robOptions('Mussv','m5','VaryFrequency','on');
[SM1,WCU1,INFO1] = robstab(CLOOP,ropt);
