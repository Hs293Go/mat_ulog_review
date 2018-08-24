close all

%% Attitude    
    figure    
    subplot(3,1,1); 
    u_plot(log, 'roll_ref', 'roll_des', 'theta');
    title('Plot euler angles: Reference, Desired, and estimate');
    xlabel('Time since armed');
    ylabel('Roll Deg');
    legend('Reference', 'Desired', 'State estimate');
    
    subplot(3,1,2); 
    u_plot(log, 'pitch_ref', 'pitch_des', 'phi');
    xlabel('Time since armed');
    ylabel('Pitch Deg');
        
    subplot(3,1,3); 
    u_plot(log, 'yaw_ref', 'yaw_des', 'psi');
    xlabel('Time since armed');
    ylabel('Yaw Deg');
    
    
%% Position
    figure    
    subplot(3,1,1); 
    u_plot(log, 'Position_Reference0', 'local_position_x');
    title('X');
    xlabel('Time since armed');
    legend('Reference', 'State estimate');
    
    subplot(3,1,2); 
    u_plot(log, 'Position_Reference1', 'local_position_y');
    xlabel('Time since armed');
        
    subplot(3,1,3); 
    u_plot(log, 'Position_Reference2', 'local_position_z');
    xlabel('Time since armed');
    
%% Control Action
    figure    
    subplot(4,1,1); 
    u_plot(log, 'ail');
    title('Aileron');
    xlabel('Time since armed');
    
    subplot(4,1,2); 
    u_plot(log, 'elev');
    title('Elevator');
    xlabel('Time since armed');
        
    subplot(4,1,3); 
    u_plot(log, 'rud');
    title('Rudder');
    xlabel('Time since armed');
    
    subplot(4,1,4); 
    u_plot(log, 'thr');
    title('Throttle');
    xlabel('Time since armed');
    
    
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