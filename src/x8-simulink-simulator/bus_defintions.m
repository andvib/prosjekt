Position = Simulink.Bus;
Position.Elements = Simulink.BusElement;
Position.Elements(1).Name = 'p_N';
Position.Elements(1).DataType = 'double';
Position.Elements(2).Name = 'p_E';
Position.Elements(2).DataType = 'double';
Position.Elements(3).Name = 'p_D';
Position.Elements(3).DataType = 'double';

Attitude = Simulink.Bus;
Attitude.Elements = Simulink.BusElement;
Attitude.Elements(1).Name = 'phi';
Attitude.Elements(1).DataType = 'double';
Attitude.Elements(2).Name = 'theta';
Attitude.Elements(2).DataType = 'double';
Attitude.Elements(3).Name = 'psi';
Attitude.Elements(3).DataType = 'double';

Quaternion = Simulink.Bus;
Quaternion.Elements = Simulink.BusElement;
Quaternion.Elements(1).Name = 'ScalarPart';
Quaternion.Elements(1).DataType = 'double';
Quaternion.Elements(2).Name = 'VectorPart';
Quaternion.Elements(2).DataType = 'double';
Quaternion.Elements(2).Dimensions = double(3);

Velocity = Simulink.Bus;
Velocity.Elements = Simulink.BusElement;
Velocity.Elements(1).Name = 'u';
Velocity.Elements(1).DataType = 'double';
Velocity.Elements(2).Name = 'v';
Velocity.Elements(2).DataType = 'double';
Velocity.Elements(3).Name = 'w';
Velocity.Elements(3).DataType = 'double';

Acceleration = Simulink.Bus;
Acceleration.Elements = Simulink.BusElement;
Acceleration.Elements(1).Name = 'a_x';
Acceleration.Elements(1).DataType = 'double';
Acceleration.Elements(2).Name = 'a_y';
Acceleration.Elements(2).DataType = 'double';
Acceleration.Elements(3).Name = 'a_z';
Acceleration.Elements(3).DataType = 'double';

AngularVelocity = Simulink.Bus;
AngularVelocity.Elements = Simulink.BusElement;
AngularVelocity.Elements(1).Name = 'p';
AngularVelocity.Elements(1).DataType = 'double';
AngularVelocity.Elements(2).Name = 'q';
AngularVelocity.Elements(2).DataType = 'double';
AngularVelocity.Elements(3).Name = 'r';
AngularVelocity.Elements(3).DataType = 'double';

AirData = Simulink.Bus;
AirData.Elements = Simulink.BusElement;
AirData.Elements(1).Name = 'Va';
AirData.Elements(1).DataType = 'double';
AirData.Elements(2).Name = 'alpha';
AirData.Elements(2).DataType = 'double';
AirData.Elements(3).Name = 'beta';
AirData.Elements(3).DataType = 'double';
AirData.Elements(4).Name = 'Course_angle';
AirData.Elements(4).DataType = 'double';
AirData.Elements(5).Name = 'Crab_angle';
AirData.Elements(5).DataType = 'double';
AirData.Elements(6).Name = 'Path_angle';
AirData.Elements(6).DataType = 'double';
AirData.Elements(7).Name = 'Air_mass_referenced_path_angle';
AirData.Elements(7).DataType = 'double';
AirData.Elements(8).Name = 'wind_x';
AirData.Elements(8).DataType = 'double';
AirData.Elements(9).Name = 'wind_y';
AirData.Elements(9).DataType = 'double';
AirData.Elements(10).Name = 'wind_z';
AirData.Elements(10).DataType = 'double';

Control = Simulink.Bus;
Control.Elements = Simulink.BusElement;
Control.Elements(1).Name = 'elevator';
Control.Elements(1).DataType = 'double';
Control.Elements(2).Name = 'aileron';
Control.Elements(2).DataType = 'double';
Control.Elements(3).Name = 'rudder';
Control.Elements(3).DataType = 'double';
Control.Elements(4).Name = 'throttle';
Control.Elements(4).DataType = 'double';

States = Simulink.Bus;
States.Elements = Simulink.BusElement;
States.Elements(1).Name = 'Position';
States.Elements(1).DataType = 'Bus: Position';
States.Elements(2).Name = 'Attitude';
States.Elements(2).DataType = 'Bus: Attitude';
States.Elements(3).Name = 'Quaternion';
States.Elements(3).DataType = 'Bus: Quaternion';
States.Elements(4).Name = 'Velocity';
States.Elements(4).DataType = 'Bus: Velocity';
States.Elements(5).Name = 'AngularVelocity';
States.Elements(5).DataType = 'Bus: AngularVelocity';
States.Elements(6).Name = 'Acceleration';
States.Elements(6).DataType = 'Bus: Acceleration';

References = Simulink.Bus;
References.Elements = Simulink.BusElement;
References.Elements(1).Name = 'Course';
References.Elements(1).DataType = 'double';
References.Elements(2).Name = 'Height';
References.Elements(2).DataType = 'double';
References.Elements(3).Name = 'Airspeed';
References.Elements(3).DataType = 'double';