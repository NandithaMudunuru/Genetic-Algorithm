function f = stalagmite_func(I)
A = (sin(0.5+(5.1*pi*I))).^6;
B = exp(-4*log(2)*((I-0.0667).^2)/0.64);
f = -A(1)*B(1)*A(2)*B(2);
end