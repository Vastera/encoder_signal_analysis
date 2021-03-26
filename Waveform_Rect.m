function rectified_sig=Waveform_Rect(encoder_sig)
% Copyright@ vastera@163.com
% General introduction:Rectify the waveform of encoder signal from elipse into circle
% Referece: "New intertpolaion method for quadrature encoder signal"
%% ====================== INPUT ========================
% encoder_sig:          Type: N*2 matrix 
%                           encoder_sig description: two channels of encoder signal: A and B
%% ====================== OUTPUT =======================
% rectified_sig:          Type: N*2 matrix with the same length of input signal
%                           Phase description: rectifeid signal 
%% =====================================================

U=QudraMatrix(encoder_sig);
y=ones(size(U,1),1);
k=pinv(U)*y;
epsilon=asin(k(3)/sqrt(4*k(1)*k(2)));
G=sqrt(k(2)/k(1));
m1=(2*k(2)*k(4)-k(3)*k(5))/(k(3)^2-4*k(1)*k(2));
m2=(2*k(1)*k(5)-k(3)*k(4))/(k(3)^2-4*k(1)*k(2));
A1=sqrt((4*k(2)*(1+k(1)*m1^2+k(2)*m2^2+k(3)*m1*m2))/(4*k(1)*k(2)-k(3)^2));
u1=(encoder_sig(:,1)-m1)/A1;
u2=((encoder_sig(:,1)-m1).*sin(epsilon)+G*(encoder_sig(:,2)-m2))/A1./cos(epsilon);
rectified_sig=[u1,u2];
% figure('Name','Before Rectification')
% plot3(encoder_sig(:,1),encoder_sig(:,2),t);
% hold on;
% plot3(u1,u2,t);
% zlim([0 1e-2]);
% xlabel('Channel A');
% ylabel('Channel B');
% zlabel('Time [s]');legend('Before rectification','After rectification');

%%%%%%%%%%%%%%%%%%%%%% Support functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function U = QudraMatrix(x)
%QudraMatrix - Description convert fault signal (N*2 matrxi) into N*5
%qudratic matrix (denoting the elipse function)
U=[x(:,1).^2,x(:,2).^2,x(:,1).*x(:,2),x(:,1),x(:,2)];
end

end

