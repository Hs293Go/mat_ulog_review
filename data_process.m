%% Convert attitude to angles
len = numel(log.vehicle_attitude_timestamp);
log.attitude_angle_timestamp = log.vehicle_attitude_timestamp;
log.phi = zeros(len,1); 
log.theta = zeros(len,1); 
log.psi = zeros(len,1);

for ii = 1:len
    [log.phi(ii), log.theta(ii), log.psi(ii)] = QuaternionToEul([log.q0(ii); log.q1(ii); log.q2(ii); log.q3(ii)]);
end

if sum(strcmp(log_topics, 'aerobatics_variables'))
    log.aerobatics_attitude_timestamp = log.aerobatics_variables_timestamp;
    log.roll_ref = zeros(len,1); 
    log.pitch_ref = zeros(len,1); 
    log.yaw_ref = zeros(len,1);

    log.roll_des = zeros(len,1); 
    log.pitch_des = zeros(len,1); 
    log.yaw_des = zeros(len,1);
    
    for ii = 1:len    
        [log.roll_ref(ii), log.pitch_ref(ii), log.yaw_ref(ii)] = QuaternionToEul([log.Quaternion_Reference0(ii); log.Quaternion_Reference1(ii); log.Quaternion_Reference2(ii); log.Quaternion_Reference3(ii)]);
        [log.roll_des(ii), log.pitch_des(ii), log.yaw_des(ii)] = QuaternionToEul([log.Quaternion_Desired0(ii); log.Quaternion_Desired1(ii); log.Quaternion_Desired2(ii); log.Quaternion_Desired3(ii)]);   
    end
end

if sum(strcmp(log_topics, 'aerobatics_variables2'))
    log.aerobatics_variables2_timestamp = log.aerobatics_variables_timestamp;
end

if sum(strcmp(log_topics, 'aerobatics_variables3'))
    log.aerobatics_variables3_timestamp = log.aerobatics_variables_timestamp;
end

%% Convert timestamp to seconds
f_names = string(fieldnames(log));
t = find(contains(f_names,'timestamp'));
for li = 1:numel(t)
    log.(f_names{t(li)})= secs(log.(f_names{t(li)}));
end

clear t

%% Convert kill switch
if sum(strcmp(log_topics, 'accelerometer_timestamp_relative'))
    log.kill_switch = arrayfun(@(x) 3-x, log.kill_switch);
end
%% Hard remove offending fields
if sum(strcmp(fieldnames(log), 'accelerometer_timestamp_relative')) == 1
    log = rmfield(log, 'accelerometer_timestamp_relative');
end

function time = secs(timestamp)
time = zeros(length(timestamp),1);
    for ti = 1:length(timestamp)
        time(ti) = 1e-6*(timestamp(ti)-timestamp(1));
    end
end

function [phi, theta, psi] = QuaternionToEul(Quat, varargin)

q0 = Quat(1);
q1 = Quat(2);
q2 = Quat(3);
q3 = Quat(4);

phi = atan2(2*(q0*q1 + q2*q3), (1-2*(q1^2 + q2^2)));
theta = asin(2*(q0*q2 - q1*q3));
psi = atan2(2*(q0*q3 + q1*q2), (1-2*(q2^2 + q3^2)));

    if sum(strcmp(varargin, 'use_radian')) == 0
        phi = rad2deg(phi);
        theta = rad2deg(theta);
        psi = rad2deg(theta);
    end

end