% scripts/setup_bus.m
% Defines the deterministic Signal Buses for Simulink data routing.

clearElems = Simulink.BusElement.empty();

% -- Radar Bus --
elems(1) = Simulink.BusElement; elems(1).Name = 'Distance'; elems(1).DataType = 'double';
elems(2) = Simulink.BusElement; elems(2).Name = 'Velocity'; elems(2).DataType = 'double';
elems(3) = Simulink.BusElement; elems(3).Name = 'SNR';      elems(3).DataType = 'double';
Bus_Radar = Simulink.Bus; Bus_Radar.Elements = elems; clear elems;

% -- Vision Bus --
elems(1) = Simulink.BusElement; elems(1).Name = 'Distance';    elems(1).DataType = 'double';
elems(2) = Simulink.BusElement; elems(2).Name = 'Velocity';    elems(2).DataType = 'double';
elems(3) = Simulink.BusElement; elems(3).Name = 'ObjectClass'; elems(3).DataType = 'uint8';
elems(4) = Simulink.BusElement; elems(4).Name = 'Confidence';  elems(4).DataType = 'double';
Bus_Vision = Simulink.Bus; Bus_Vision.Elements = elems; clear elems;

% -- Fused Data Bus --
elems(1) = Simulink.BusElement; elems(1).Name = 'Fused_Dist';  elems(1).DataType = 'double';
elems(2) = Simulink.BusElement; elems(2).Name = 'Fused_Vel';   elems(2).DataType = 'double';
elems(3) = Simulink.BusElement; elems(3).Name = 'Est_Accel';   elems(3).DataType = 'double';
elems(4) = Simulink.BusElement; elems(4).Name = 'Threat_Lvl';  elems(4).DataType = 'uint8';
Bus_Fused = Simulink.Bus; Bus_Fused.Elements = elems; clear elems;

disp('>> SIXXIS AEB: Virtual Signal Buses Configured.');