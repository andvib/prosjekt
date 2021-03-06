close all;
clear all;

run 'cur_70deg_150m.m'

%% PLOT POSITION %%

figure(1);
grid on;
hold on;
plot(STATES(:,3), STATES(:,2),'LineWidth', 2.0);
plot(PATH(:,2), PATH(:,1),'k','LineWidth', 2.0);
xlim([-100 300]);
ylim([450 850]);
ylabel('North [m]');
xlabel('East [m]');
%matlab2tikz('fig/uav_position.tex');
set(gca, 'fontsize', 14);
saveas(gcf, 'fig_70deg/uav_position', 'epsc');

%% PLOT CAMERA CENTRE POINT%%

figure(2);
grid on;
hold on;
for i = (1:length(STATES(:,1)))
    [x_temp, y_temp] = camera_pos([STATES(i,8), STATES(i,9), STATES(i,10)],...
                            [STATES(i,2), STATES(i,3), STATES(i,4)], 0.0);%0.331612);
    c_n_1(:,i) = x_temp;
    c_n_2(:,i) = y_temp;
end

plot(c_n_1(2,:),c_n_1(1,:),'color',[1 .4 0],'LineWidth', 2.0);
%plot(c_n_2(2,:),c_n_2(1,:));
%plot(STATES(:,3), STATES(:,2));

plot(PATH(:,2), PATH(:,1),'k','LineWidth', 2.0);
xlim([-100 300]);
ylim([450 850]);
ylabel('North [m]');
xlabel('East [m]');
set(gca, 'fontsize', 14);
saveas(gcf, 'fig_70deg/camera_position', 'epsc');


%% PLOT HEIGHT %%

figure(3);
grid on;
hold on; 
plot(STATES(:,1), STATES(:,4),'LineWidth', 2.0);
xlim([0 40]);
ylim([100 160]);
ylabel('Height [m]');
xlabel('Time [s]');
set(gca, 'fontsize', 14);
saveas(gcf, 'fig_70deg/height', 'epsc');

%% PLOT ATTITUDE %%

figure(4);
grid on;
hold on;
plot(STATES(:,1), STATES(:,8),'LineWidth', 2.0);
plot(STATES(:,1), STATES(:,9),'LineWidth', 2.0);
plot(STATES(:,1), STATES(:,10),'LineWidth', 2.0);

ylabel('Angle [rad]');
xlabel('Time [s]');
leg=legend('\phi', '\theta', '\psi','Location','NW');
set(gca, 'fontsize', 14);
set(leg, 'fontsize', 16);
saveas(gcf, 'fig_70deg/attitude','epsc');

%% PLOT CONTROLS %%

figure(5);
grid on;
hold on;

subplot(4,1,1);
plot(STATES(:,1), STATES(:,14));
subplot(4,1,2);
plot(STATES(:,1), STATES(:,15));
subplot(4,1,3);
plot(STATES(:,1), STATES(:,16));
subplot(4,1,4);
plot(STATES(:,1), STATES(:,17));
set(gca, 'fontsize', 14);
saveas(gcf, 'fig_70deg/control','epsc');