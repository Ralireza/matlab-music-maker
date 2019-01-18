function [song_name,song_vector,fs] = resolve_song(v)


notes()

if v == 1
        odetojoy()
        song_name='odetojoy.wav';
    elseif v == 2
        odeto2()
        song_name='odeto2.wav';
    elseif v == 3
        mornmood()
        song_name='mornmood.wav';
    elseif v == 4
        furelise()
        song_name='furelise.wav';
end


fs=10000;
x=[];
SUMnew=0; 

for i=1:size(nf')
    tt=0:(1./fs):(TD./nd(i));
    square = na(i)*sin(2*pi*nf(i)*tt);
   

    for num=2:12
        harmonic = ((1/num)*na(i))*sin(2*pi*(nf(i)*num)*tt); 
        square=square+harmonic;

    end
         square= square .* exp(10*-tt);
       

    x=[x;square'];

end
% x=movmean(x,10)

plot(x)
 song_vector=x;


end

