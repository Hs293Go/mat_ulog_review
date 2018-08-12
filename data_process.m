len = numel(log.vehicle_attitude_timestamp);
log.attitude_angle_timestamp = log.vehicle_attitude_timestamp;
log.phi = zeros(len,1); 
log.theta = zeros(len,1); 
log.psi = zeros(len,1);

for ii = 1:len
    [log.phi(ii), log.theta(ii), log.psi(ii)] = QuaternionToEul([log.q0(ii); log.q1(ii); log.q2(ii); log.q3(ii)]);
end

log.kill_switch = arrayfun(@(x) 3-x, log.kill_switch);

log = rmfield(log, 'accelerometer_timestamp_relative');