close all;
clear all;

res = load('second_run.mat');

start_idx = 5277;
end_idx = 37549;
length = (end_idx - start_idx);
t = res.states.Position.p_N.Time(start_idx:end_idx)-start_idx*0.01;

p_N = res.states2.Position.p_N.Data(start_idx:end_idx);
p_E = res.states2.Position.p_E.Data(start_idx:end_idx);
p_D = res.states2.Position.p_D.Data(start_idx:end_idx);

phi = res.states2.Attitude.phi.Data(start_idx:end_idx);
theta = res.states2.Attitude.theta.Data(start_idx:end_idx);
psi = res.states2.Attitude.psi.Data(start_idx:end_idx);


%% COVERAGE STUFF
xq_1 = 0:0.5:9.5;
coefficients = polyfit([0 10], [0 1800], 1);
a = coefficients(1);
b = coefficients(2);
yq_1 = a*xq_1 + b;

%% FLOWN ROUTE
figure(1);
hold on;
grid on;
%plot(p_E, p_N, 'LineWidth', 1);

waypoints = [[0,0,0,0]; [1800,10,0,0];[1800,3500,0,pi/2];[5000,6000,0,pi]];
R = 600;

[N,~] = size(waypoints);

for i = (2: N)
    [L, c_s, lambda_s, c_e, lambda_e, z1, q1, z2, z3, q3] = ...
           dubinsPath(waypoints(i-1,1:3)',waypoints(i-1,4),waypoints(i,1:3)',waypoints(i,4),R);
    
    [x1, y1] = createCircle(c_s(2),c_s(1),R);
    [x2, y2] = createCircle(c_e(2),c_e(1),R);

    %plot(x1,y1,'--k');
    %plot(x2,y2,'--k');
    %plot(waypoints(i,2),waypoints(i,1),'*b');
    %plot(z1(2),z1(1),'ob');
    %plot(z2(2),z2(1),'or');
    %plot(z3(2),z3(1),'*b');
    w = plot([z1(2),z2(2)],[z1(1),z2(1)],'--k');
    
    if lambda_s == 1
        P0 = [c_s(2);c_s(1)];
        P2 = [waypoints(i-1,2);waypoints(i-1,1)];
        P1 = [z1(2);z1(1)];
    else
        P0 = [c_s(2);c_s(1)];
        P1 = [waypoints(i-1,2);waypoints(i-1,1)];
        P2 = [z1(2);z1(1)];
    end

    v1 = P1-P0;
    v2 = P2-P0;
    v3 = [0 -1;1 0]*v1; % (as you suggested)
    a = linspace(0,mod(atan2(det([v1,v2]),dot(v1,v2)),2*pi));
    % Note the absence of the 'abs' function in 'atan2'
    v = v1*cos(a)+v3*sin(a);
    plot(v(1,:)+P0(1),v(2,:)+P0(2),'--k')
    
    if lambda_e == -1
        P0 = [c_e(2);c_e(1)];
        P2 = [waypoints(i,2);waypoints(i,1)];
        P1 = [z2(2);z2(1)];
    else
        P0 = [c_e(2);c_e(1)];
        P1 = [waypoints(i,2);waypoints(i,1)];
        P2 = [z2(2);z2(1)];
    end

    v1 = P1-P0;
    v2 = P2-P0;
    v3 = [0 -1;1 0]*v1;
    a = linspace(0,mod(atan2(det([v1,v2]),dot(v1,v2)),2*pi));
    % Note the absence of the 'abs' function in 'atan2'
    v = v1*cos(a)+v3*sin(a);
    plot(v(1,:)+P0(1),v(2,:)+P0(2),'--k')
end
plot(waypoints(1,2),waypoints(1,1),'*k');
plot(waypoints(i,2),waypoints(i,1),'*k');

%plot(p_nd(:,2),p_nd(:,1));
%plot(p_nd2(:,2),p_nd2(:,1));

%legend('Flown Path', 'Observation path', 'Location', 'NW');
ylim([-50 5900]);
xlim([-100 6100]);

xlabel('East');
ylabel('North');

%% CAMERA POS
c_1 = zeros(2,(end_idx-start_idx));
c_2 = zeros(2,(end_idx-start_idx));

for i = (1:(end_idx-start_idx))
    [x_temp, y_temp] = camera_pos([phi(i), theta(i), psi(i)],...
                                  [p_N(i), p_E(i), p_D(i)], 0.331612558);
    c_1(:,i) = x_temp(1:2);
    c_2(:,i) = y_temp(1:2);
end

plot(c_1(2,:),c_1(1,:));
b = plot(c_2(2,:),c_2(1,:),'k');
h = fill([c_1(2,:) fliplr(c_2(2,:))],[c_1(1,:) fliplr(c_2(1,:))],'k');
set(h, 'facealpha', 0.1);
%legend('Observation path', 'Location', 'NW');
legend([w b], 'Observation path', 'Camera Footprint', 'Location', 'NW');