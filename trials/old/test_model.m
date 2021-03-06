close all;
clear all;

aerosonde

Va = 35;
gamma = 0*pi / 180;
R = Inf;

DX0 = [0; 0; -Va*sin(gamma); 0; 0; 0; 0; 0; Va/R; 0; 0; 0];
IDX = [3; 4; 5; 6; 7; 8; 9; 10; 11; 12];

X0 = [0; 0; -100; Va; 0; 0; 0; gamma; 0; 0; 0; 0];
IX0 = [];
U0 = [0; 0; 0; 1];
IU0 = [];
Y0 = [Va; gamma; 0];
IY0 = [1,3];

options(14) = 10000;
[X_trim, U_trim, Y_trim, DX_trim] = trim('trim_sys', X0, U0, Y0, ...
                                         IX0, IU0, IY0, DX0, IDX, options)

norm(DX_trim(3:end)-DX0(3:end)) % Should be very low

delta_e = U_trim(1);
delta_a = U_trim(2);
delta_r = U_trim(3);
delta_t = U_trim(4);

set_param('model', 'StopTime', int2str(10));
sim('model');