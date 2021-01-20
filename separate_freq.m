function [low_pass_img, high_pass_img] = separate_freq(img, ratio)

    % application de la FFT
    frequency_map = fft2(img);
    %figure, imshow( log(abs(frequency_map) + 1), []);
    
    % décalage de la transformée au centre
    frequency_map_shifted = fftshift(frequency_map);

    % creation d'un filtre basse-fréquence
    % creattion d'un filtre rectangle
    %       longueur = ratio * longueur d'image 
    %       largeur = ratio * largeur d'image 
    %       centre du rectangle = centre de l'image
    middle_point = [floor(size(img, 1) / 2), floor(size(img, 2) / 2)];
    
    mask_half_x = ratio * size(img, 1);
    x1 = floor(middle_point(1) - mask_half_x);
    x2 = floor(middle_point(1) + mask_half_x);
    
    mask_half_y = ratio * size(img, 2);
    y1 = floor(middle_point(2) -  mask_half_y);
    y2 = floor(middle_point(2) + mask_half_y);
    
    mask = zeros(size(img));
    mask(y1 : y2, x1 : x2, :) = 1;
    
    % séparation des bfs et des hfs
    low_frequency_map_shifted = frequency_map_shifted .* mask;
    high_frequency_map_shifted = frequency_map_shifted .* (1 - mask);
    
    % décalage inverse de la transformée
    low_frequency_map = ifftshift(low_frequency_map_shifted);
    high_frequency_map = ifftshift(high_frequency_map_shifted);
    
    % application de la transformée inverse
    low_pass_img = real(ifft2(low_frequency_map)); 
    high_pass_img = real(ifft2(high_frequency_map));
  
end