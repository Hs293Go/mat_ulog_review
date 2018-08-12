%% Convert attitude to angles
len = numel(log.vehicle_attitude_timestamp);
log.attitude_angle_timestamp = log.vehicle_attitude_timestamp;
log.phi = zeros(len,1); 
log.theta = zeros(len,1); 
log.psi = zeros(len,1);

for ii = 1:len
    [log.phi(ii), log.theta(ii), log.psi(ii)] = QuaternionToEul([log.q0(ii); log.q1(ii); log.q2(ii); log.q3(ii)]);
end

%% Convert timestamp to seconds
f_names = string(fieldnames(log));
t = find(contains(f_names,'timestamp'));
for li = 1:numel(t)
    log.(f_names{t(li)})= secs(log.(f_names{t(li)}));
end

clear t

%% Convert kill switch
log.kill_switch = arrayfun(@(x) 3-x, log.kill_switch);

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

function [phi, theta, psi] = QuaternionToEul(Quat)

q0 = Quat(1);
q1 = Quat(2);
q2 = Quat(3);
q3 = Quat(4);

phi = atan2(2*(q0*q1 + q2*q3), (1-2*(q1^2 + q2^2)));
theta = asin(2*(q0*q2 - q1*q3));
psi = atan2(2*(q0*q3 + q1*q2), (1-2*(q2^2 + q3^2)));

end