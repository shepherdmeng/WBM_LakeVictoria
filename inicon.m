% --------------------------------------------------------------------
% Inicon: initialisation of constants
% --------------------------------------------------------------------

% specific gass constant for water vapour (Van Lipzig, 2009 (W&K))
global Rv;
Rv = 461.5; % [J*kg^-1*K^-1]

% Specific gas constant for dry air (Van Lipzig, 2009 (W&K))
global Rd;
Rd = 287.058; % [J*kg^-1*K^-1]

% Water vapour pressure at freezing point of water (611Pa) (Van Lipzig, 2009 (W&K));
global es0;
es0 = 611; % [Pa] !dit is op basis van de formule van de verzadigde dampspanning berekend!

% Temperature at freezing point of water (611Pa) (Van Lipzig, 2009)
global T0;
T0 = 273.16; % [K]

% Standard reference pressure (Akkermans et al., 2014)
global P0;
P0 = 100000; % [Pa]

% Latent heat of vaporization, assumed constant
global Lvap;
Lvap = 2.50E6; % [J*kg^-1]

% Stephan-Boltzmann constant
global sigma;
sigma = 5.67E-8; % [W*m^-2*K^-4]

% Specific heat capacity of water at constant pressure
global cp;
cp  = 4.1813E3; % [J kg^-1 K^-1]

% Specific heat capacity of air at constant pressure (Akkermans et al., 2014)
global cp_air;
cp_air  = 1005; % [J kg^-1 K^-1]

% Latent heat of vaporization, assumed constant
global rhow;
rhow = 1E3; % [J*kg^-1]

% earth circumference (wikipedia)
global c_earth;
c_earth = 40075017; % [m]

% earth gravitation (wikipedia)
global g_earth;
g_earth = 9.81; % [m s^-1]

% lake surface area !TO BE REMOVED!!
global A_lake;
A_lake = 68800*10^6;  %[m²]

