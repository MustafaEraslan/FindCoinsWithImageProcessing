% Program� her �al��t�rd���m�zda farkl� datalar ile kar��la�aca��m�z i�in
% workspace'i run etmeden �nce temizlememiz gerekir.
clear all
close all

%mevcut foto�raf� al�yoruz.
imageorj=imread('white_united.jpeg'); 
figure(1),imshow(imageorj);

% rgb2gray ile siyah beyaza d�n��t�r�p 2 boyuta d�n��t�r�yoruz. Renk
% �nemsiz.image=rgb2gray(imageorj); 
level=graythresh(image);%2 boyuta ge�irirken matlab'�n kullan�d�� level degeri onemli.
%Burada o degeri almaktay�z. Ben run etti�imde 0.2784 de�erini buldum.
%0.2784 de�eri �st� 1 olarak yani beyaz, alt de�eri siyah olarak atand�.
bw=im2bw(image,level);
bw=im2bw(image,level);
figure(2),imshow(bw);


bw=imcomplement(bw); 
figure(3),imshow(bw);

%Gorseldeki bosluklari tespit ettik. 
%imfill: gri seviyede veya binary modda a��kl�klar� doldurur.bw=imfill(bw,'holes');

%Birbiri ile bagl� olmayan pixelleri kaldirdik.
bw = bwareaopen(bw,30);
figure(4),imshow(bw);

%12 piksel yar��apl� disk �eklinde bir yap�sal eleman olu�turduk.
% strell,strel, morfolojik i�lemlerde kullan�lan yap�sal filtre eleman�d�r. 
%Morfolojik i�lemleri hangi �ekil ve parametrelerle uygulayaca��m�z� strel ile belirleriz.
se=strel('disk',12,0); 

%Resimde herhangi bir birle�ik madeni para olu�mu�sa, onu ay�rd�k.
%imdilate: a�ma i�lemini yapar.
%imerode: a��nd�rma i�lemi yapar.bw2=imerode(bw,se); 
figure(5),imshow(bw2);

% Madeni para uzunluklar�n� belirlendi ve bu de�er B uzunlu�una atand�.
[B,L] = bwboundaries(bw2); 
%B = bwboundaries(BW), ikili g�r�nt� BW'de nesnelerin d�� s�n�rlar�n� ve bu nesnelerin i�indeki deliklerin s�n�rlar�n� izler. bwboundaries ayr�ca en d��taki nesnelere izler ve onlar� takip s�rer. S�n�r piksel konumlar�n�n bir h�cre dizisi olan B'yi d�nd�r�r.
stats = regionprops(bw2, 'Area','Centroid');
%ikili g�r�nt�deki BW'deki her 8 ba�lant�l� nesne i�in bir dizi �zellik i�in �l��mleri d�nd�r�r.
figure(6),imshow(imageorj);    
total = 0;  %baslangic degerleri atandi. Tum paralar �c�n
count1=0;   %1 tl'yi say
count50=0;  %50kr say
count25=0;  %25kr say
count10=0;  %10kr say
count5=0;   %5kr say
for n=1:length(B) 
  %Para alanlar� bulundu ve foto�raftaki ile e�lenip e�lenmedi�ini sorgulamak i�in bir loop etraf�nda incelendi.       
  a=stats(n).Area;           
  centroid=stats(n).Centroid;            
  if a> 1100                 
    total = total + 1; 
    count1=count1+1;    
    text(centroid(1),centroid(2),'1TL');              
  elseif a >800 &&  a < 1050               
    total = total + 0.5; 
    count50=count50+1;      
    text(centroid(1),centroid(2),'50Kr');            
  elseif a >380 &&  a < 650                
    total = total + 0.25; 
    count25=count25+1;      
    text(centroid(1),centroid(2),'25Kr');            
  elseif a > 280 &&  a < 380                
    total = total + 0.10;  
    count10=count10+1;      
    text(centroid(1),centroid(2),'10Kr');            
  else             
    total = total + 0.05; 
    count5=count5+1;      
    text(centroid(1),centroid(2),'5Kr');      
  
  end    
end   
title([num2str(count1),' x 1 TL + ', num2str(count50),' x 50 Kr + ', num2str(count25),' x 25 Kr + ', num2str(count10),' x 10 Kr + ', num2str(count5),' x 5 Kr. ', 'The total money amount= ',num2str(total),' TL'])   

