% EXERCICE 1
% -------------------------------

% convertir l'image en matrice
img = im2double(imread("TestREC.gif"));

% Séparer les bfs et les hfs
[frq_low, frq_high] = separate_freq(img, 0.055);

% Montrer les images extraites
imwrite(frq_low, 'TestREC_low_0.1.jpg');
figure, imshow('TestREC_low_0.1.jpg');
imwrite(frq_high + 0.5, 'TestREC_high_0.1.jpg');
figure, imshow('TestREC_high_0.1.jpg');

% On sépare les bfs fréquences des hfs fréquences , 
% Pour un affichage plus clair et lumineux on ajoute une composante
% continue égale à 0.5
% Par contre la ratio=0.055 est choisi par tatônement , il faut une valeur entre
% 0 et 1

% Montrer les hfs à côté des bfs
pairOfImages = [frq_low,  frq_high + 0.5]; 
figure, imshow(pairOfImages), title("LOW frequency image - HIGH frequency image");
