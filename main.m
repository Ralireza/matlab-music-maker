clc
clear
notes()

odetojoy()

fs=1000;
x=[];
SUMnew=0;

for i=1:size(nf')
    tt=0:(1./fs):(TD./nd(i));
    square = na(i)*sin(2*pi*nf(i)*tt);
   

    for num=2:12
        harmonic = ((1/num)*na(i))*sin(2*pi*(nf(i)*num)*tt); 
        square=square+harmonic;

    end
         square= square .* exp(-tt);

    x=[x;square'];

end
% plot(x)
% SUMtemp+1:SUMnew+1
% audiowrite('song.wav',x,fs); 
plot(x)
 sound(x, fs) 