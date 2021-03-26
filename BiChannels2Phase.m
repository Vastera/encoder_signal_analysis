function phase=BiChannels2Phase(encoder,varargin)
% CopyRight:vastera@163.com
% General introduction:% Convert the two channels of signals into a single monotonously increasing phase
%% analyze two channels of encoder signals by combining them together as
% complex nubmers
%% ====================== INPUT ========================
% encoder:        Type: N*2 Matrix
%                           encoder description: the raw encoder signal (sinusoidal signal)
% ---------------------OPTIONAL:
% optional arg: rectify             Type: Boolean
%                            description: true (default) is to apply the Waveform_Rect.m to rectify the encoder signal from elipse into circle shape
%% ====================== OUTPUT =======================
% phase:          Type: N*1 vector
%                           output_arg description: the instantaneous phase 
%% =====================================================
rectify=true;% choose whether to rectify the waveform of encoder signal 
if nargin>=2 
	rectify=varargin{1};
	if rectify==1
		rectify = true;
	elseif rectify==0
		rectify=false;
	end
	if ~islogical(rectify), error('rectify must be logical:''ture'' or ''false''~'); end
end
if size(encoder,2)~=2, encoder=encoder'; end% make the encoder signal in the form of N*2 
%------------------------------------------------------------------
if rectify, encoder = Waveform_Rect(encoder); end
x=encoder(:,1);y=encoder(:,2);
z=complex(x,y);
phi0=imag(log(z));
%% make the phase monotonously increase
loc_down=(diff(phi0)>pi);%the locations of down stairs 
loc_up=(diff(phi0)<-pi);%the locations of up stairs
staircase=-cumsum(loc_down)*2*pi+cumsum(loc_up)*2*pi;
staircase=[staircase(1);staircase];
phase=phi0+staircase;
end