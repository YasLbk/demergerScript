% EXERCICE 2
%-----------------------------
% Partie 1
%--------------------------------------
% Convertir l'image en matrice
img = im2double(imread("TestREC.gif"));

% Création d'un filtre
% filtres bf : h1 et h2
% filtres hf : h3 et h4 
h1 = ones(5)/25; 
h2 = fspecial('average',[12 12]);
h3  = fspecial('unsharp');
h4 = -1 * ones(3)/9;
h4(2,2) = 8/9;

% Filtrer l'image
% Y1, Y2 sont des images filtrés respictevement avec h1, h2
% Y3, Y4
Y1 = imfilter(img, h1, 'replicate');
Y2 = imfilter(img, h2, 'replicate');
Y3 = imfilter(img, h3, 'replicate');
Y4 = imfilter(img, h4, 'replicate');

% Montrer l'image originelle
figure, imshow("TestREC.gif");

% Montrer l'image filtrée
imwrite(Y1, 'TestREC_low.jpg');
figure, imshow('TestREC_low.jpg');

% Transformer l'image en une image grisée pour un affichage plus clair
I1 = mat2gray( img - Y1 );
imwrite(I1, 'TestREC_high_mod.jpg');
figure, imshow("TestREC_high_mod.jpg");

% Montrer les deux images résultantes après h1
% à la gauche ; les bfs filtrées et à la droite : les hfs 
pairOfImages = [Y1, I1]; 
figure, imshow(pairOfImages), title("Applying low-pass filter h1 = ones(5)/25 ");

% Montrer les deux images résultantes après h2
pairOfImages = [Y2, mat2gray( img - Y2 )];  
figure, imshow(pairOfImages), title("Applying low-pass filter h2 = fspecial('average',[12 12]) ");

% Montrer les deux images résultantes après h3
% à la gauche ; les hs filtrées et à la droite : les bfs 
pairOfImages = [mat2gray(Y3),  img - Y3 ]; 
figure, imshow(pairOfImages), title("Applying high-pass filter h3 = fspecial('unsharp')");

% Montrer les deux images résultantes après h4
pairOfImages = [mat2gray(Y4),  img - Y4 ]; 
figure, imshow(pairOfImages), title("Applying high-pass filter h4 = -1 * ones(3)/9 ");

% Augmenter la valeur du filtre(avec prudence) h1 a permis un filtrage meilleur et précis
% ainsi que des images plus claire par contre , si on augmente beaucoup
% h1=ones(15/25) il ne fait passer que les hautes fréquences .
% Une comparaison des filtres peut conclure en l'efficacité des filtres h1
% h2 et surtout h2 obtenue grâce à la fonction fspecial avec l'option average ,
% qui ont donné des images claires .
% Quant au filtre passe-haut , le filtre h4 a donné des bons résultats
% par contre la fonction fspecial('unsharp') - qui est connu
% pour créer un filtre passehaut qui enlevent les bruits bf - n'a pas
% donné des résultats concluants .

% Partie 2
%--------------------------------------

input_image = im2double(imread("TestREC.gif"));
  
% Enregistrer la taille de la matrice
[M, N] = size(input_image); 
  
% Appliquer la transformation Fourier en utilisant la 
% function fft2 (2D fast fourier transform)   
FT_img = fft2(double(input_image)); 
  
% Frequence de coupure 
D0 = 10; 
  
% Création de la matrice du filtre
u = 0:(M-1); 
idx = find(u>M/2); 
u(idx) = u(idx)-M; 
v = 0:(N-1); 
idy = find(v>N/2); 
v(idy) = v(idy)-N; 
   
% Copie
[V, U] = meshgrid(v, u); 
  
% Distance euclidienne
D = sqrt(U.^2+V.^2); 
  
% Comparaison avec la freq de coupure et création du filtre
H = double(D > D0); 
  
% Convolution entre la transformée de Fourier et le masque
G = H.*FT_img; 
  
% Application de la Tranformée inverse de Fourier de l'image convolue
% à l'aide de la fonction ifft2
output_image = real(ifft2(double(G))); 

% Montrer les hfs à côté des bfs
pairOfImages = [mat2gray(output_image),  input_image - output_image ]; 
figure, imshow(pairOfImages), title("Applying ideal high-pass filter using edge detection technique ");

% Remarque la détection de contours affiche bel et bien les hautes
% fréquences , mais par contre elle donne des fois de faux contours comme on voit , 
% il y a cet effet de rebondissement qui fausse le filtrage .
