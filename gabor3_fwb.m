function varargout=gabor3_fwb(aspect,theta,bw,psi,sigma,sz)
% Returns 3D gabor filter.
% gb=GABOR_FWB(aspect,theta,bw,psi,sigma,sz)
%
% [aspecta, aspectb]
%        = 2 element array giving aspect ratios for 2 minor axis
%           (eg: [0.5, 1], for major < minoraxis1, major = minoraxi2)
% [theta,phi]
%        = yaw and pitch of major axis (0-2*pi)
%           roll isn't implemented, sorry.
% bw     = spatial bandwidth in pixels (decreasing fine detail,), (eg: >=1)
%               scales the frequency of the cosine modulation
% psi,   = phase shift, [optional, default: 0]
% sigma  = scales the falloff of the gaussian, (must be >=2) [default: = bw]
%              + can set to 'auto' to maintain default functionality
% [x y z] = size of gabor kernel created  [optional, size set automatically
%           to 3 standard deviations of gaussian kernel]

% Frederick Bryan adapted from gabor_fn.m
% July 2013
% Vanderbilt Univ

% To Do
% implement roll:
% This isn't hard as far as the meshgrid goes. All that needs to be done for that is to
% uncomment the appropriate lines. I just didn't want to figure out the math
% for the auto-sizing option. (if nargin < 6)
%

% handle mandatory args
if numel(aspect) ~= 2;
    error('1st argument (aspect) must be 2 element array');
end
% if numel(theta) ~=2;
%     error('2nd argument ([theta,phi]) must be 2 element array');
% end

% handle optional inputs
if nargin<4
    psi = [0 0];
end
if nargin<5
    sigma = 'auto';
end
% allow 'auto' sizing of guassian kernel
if strcmp(sigma,'auto');
    sigma = bw;
end
if nargin<6
    % figure out size
    phi = theta(2);
    theta = theta(1);
    len1 = 3*sigma; % length along theta direction
    len2 = len1/aspect(1);
    len3 = len1/aspect(2);
    sz(1) = (len1*cos(theta)+len2*sin(theta)); % column/x dimension
    sz(2) = (len1*sin(theta)+len2*cos(theta)); % row/y direction
    sz(1) = round(sz(1)*cos(phi)+len3*sin(phi));
    sz(2) = round(sz(2));
    sz(3) = round(sz(1)*sin(phi)+len3*cos(phi));
    sz=abs(sz);
end
if nargin==6
    % figure out size
    phi = theta(2);
    roll=theta(3);
    theta = theta(1);
end

% handle incorrectly given optional args

if length(sz)<2; % allow just one number to be given for size
    sz(2) = sz(1);
    sz(3) = sz(1);
end
% keyboard;
sx = sz(1);
sy = sz(2);
sz = sz(3);

% figured out size above, now make matrix of points
[x y z]=meshgrid(-sx:sx, sy:-1:-sy, -sz:sz); % note that y goes backwards

% rotate reference frame to point in theta direction
% http://en.wikipedia.org/wiki/Rotation_matrix
% yaw - rotation about z
xp1 = x*cos(theta)+y*sin(theta);
yp1 = -x*sin(theta)+y*cos(theta);
zp1 = z;
% pitch - rotation about y
xp2 = xp1*cos(phi)-zp1*sin(phi);
yp2 = yp1;
zp2 = xp1*sin(phi)+zp1*cos(phi);
% % roll - rotation about x - unimplemented, requires "roll" angle
xp = xp2;
yp = yp2*cos(roll) + zp2*sin(roll);
zp = -yp2*sin(roll) + zp2*cos(roll);

% create gaussian pointing in theta direction with size determined by
%   aspect ration
sigmajor = sigma;
sigminor1 = sigma/aspect(1);
sigminor2 = sigma/aspect(2);
h1 = exp(-(xp.^2/sigmajor^2+yp.^2/sigminor1^2+zp.^2/sigminor2^2));

% multiply by cosine with appropriate bw
F=1/bw;  % Frequency
h2 = exp(1i*(2*pi*(F*(xp))+psi));
h2=real(h2);
g = h1.*h2;
% g = h1;

if nargout>0
    varargout{1} = g;
end