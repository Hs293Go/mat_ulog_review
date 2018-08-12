close all

data_process
%% Attitude    
    figure    
    subplot(3,1,1); 
    u_plot(log, 'phi', 'roll_body');
    title('Roll angle tracking');
    xlabel('Time since armed');
    ylabel('Deg');
    legend('Roll angle', 'Roll angle setpoint');
    
    subplot(3,1,2); 
    u_plot(log, 'theta', 'pitch_body');
    title('Pitch angle tracking');
    xlabel('Time since armed');
    ylabel('Deg');
    legend('Pitch angle', 'Pitch angle setpoint');
    
    subplot(3,1,3); 
    u_plot(log, 'psi', 'yaw_body');
    title('Yaw angle tracking');
    xlabel('Time since armed');
    ylabel('Deg');
    legend('Yaw angle', 'Yaw angle setpoint');
    
%% Rates
    figure
    subplot(3,1,1); 
    u_plot(log, 'rollspeed', 'roll');
    title('Rollspeed');
    xlabel('Time since armed');
    ylabel('Deg/sec');
    legend('Roll rate', 'Roll rate setpoint');
    
    subplot(3,1,2); 
    u_plot(log, 'pitchspeed', 'pitch');
    title('Pitchspeed');
    xlabel('Time since armed');
    ylabel('Deg/sec');
    legend('Pitch rate', 'Pitch rate setpoint');
    
    subplot(3,1,3); 
    u_plot(log, 'yawspeed', 'yaw');
    title('Yawspeed');
    xlabel('Time since armed');
    ylabel('Deg/sec');
    legend('Yaw rate', 'Yaw rate setpoint');
    
%% Controls
    figure    
    subplot(3,1,1);
    u_plot(log, 'manual_control_setpoint_x', 'manual_control_setpoint_y', 'manual_control_setpoint_z', 'manual_control_setpoint_r', 'kill_switch');
    title('Stick movement');
    legend('X', 'Y', 'Z', 'R');
    
    subplot(3,1,2);
    u_plot(log, 'control0', 'control1', 'control2', 'control3')
    title('Actuator control');
    legend('Roll', 'pitch', 'Yaw', 'Thrust');
    
    subplot(3,1,3);
    u_plot(log, 'output0', 'output1', 'output2', 'output3')
    title('Actuator output');
    legend('NE', 'SW', 'NW', 'SE');

%% Sensors
    figure
    subplot(3,1,1);
    u_plot(log, 'gyro_rad0', 'gyro_rad1', 'gyro_rad2');
    title('Raw angular speed');
    legend('x','y','z');
    
    subplot(3,1,2);
    u_plot(log, 'accelerometer_m_s20', 'accelerometer_m_s21', 'accelerometer_m_s22');
    title('Raw Acceleration');
    legend('x','y','z');
    
    subplot(3,1,3);
    u_plot(log, 'magnetometer_ga0', 'magnetometer_ga1', 'magnetometer_ga2');
    title('Raw Magnetic Field Strength');
    legend('x','y','z');
    
function rt = realtime(timestamp)
rt = zeros(length(timestamp),1);
    for ti = 1:length(timestamp)
        rt(ti) = 1e-6*(timestamp(ti)-timestamp(1));
    end
end

function u_plot(log, varargin)
    f_names = fieldnames(log);
    t = find(contains(f_names,'timestamp'));
    for li = 1:(nargin -1)
        pos = find(strcmp(f_names, varargin{li}));
        ind = find(t<pos,1, 'last');
        
        plot(log.(f_names{t(ind)}),log.(varargin{li}));
        hold on;
    end
    hold off;
end
