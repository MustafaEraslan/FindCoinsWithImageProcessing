% Programi her �alistirdigimizda farkli datalar ile karsilasacagimiz i�in
% workspace'i run etmeden �nce temizlememiz gerekir.
clear all
close all

%mevcut fotografi aliyoruz.
imageorj=imread('black_background.jpeg'); 
figure(1),imshow(imageorj);

% rgb2gray ile siyah beyaza d�n�st�r�p 2 boyuta d�n�st�r�yoruz. Renk
% �nemsiz.
image=rgb2gray(imageorj); 
level=graythresh(image); %2 boyuta ge�irirken matlab'in kullanidgi level degeri onemli.
%Burada o degeri almaktayiz. Ben run ettigimde 0.2784 degerini buldum.
%0.2784 degeri �st� 1 olarak yani beyaz, alt degeri siyah olarak atandi.
bw=im2bw(image,level);
figure(2),imshow(bw);

%Gorseldeki bosluklari tespit ettik. 
%imfill: gri seviyede veya binary modda a�ikliklari doldurur.
bw=imfill(bw,'holes');

%Birbiri ile bagli olmayan pixelleri kaldirdik.
bw = bwareaopen(bw,30);
figure(3),imshow(bw);

%12 piksel yari�apli disk seklinde bir yapisal eleman olusturduk.
% strell,strel, morfolojik islemlerde kullanilan yapisal filtre elemanidir. 
%Morfolojik islemleri hangi sekil ve parametrelerle uygulayacagimizi strel ile belirleriz.
se=strel('disk',12,0); 

%Resimde herhangi bir birlesik madeni para olusmussa, onu ayirdik.
%imdilate: a�ma islemini yapar.
%imerode: asindirma islemi yapar.
bw2=imerode(bw,se); 
figure(4),imshow(bw2);

% Madeni para uzunluklarini belirlendi ve bu deger B uzunluguna atandi.
[B,L] = bwboundaries(bw2);  
%B = bwboundaries(BW), ikili g�r�nt� BW'de nesnelerin dis sinirlarini ve bu nesnelerin i�indeki deliklerin sinirlarini izler. bwboundaries ayrica en distaki nesnelere izler ve onlari takip s�rer. Sinir piksel konumlarinin bir h�cre dizisi olan B'yi d�nd�r�r.
stats = regionprops(bw2, 'Area','Centroid');
%ikili g�r�nt�deki BW'deki her 8 baglantili nesne i�in bir dizi �zellik i�in �l��mleri d�nd�r�r.
figure(5),imshow(imageorj);    
total = 0;  %baslangic degerleri atandi. Tum paralar icin
count1=0;   %1 tl'yi say
count50=0;  %50kr say
count25=0;  %25kr say
count10=0;  %10kr say
count5=0;   %5kr say
for n=1:length(B)  
  %Para alanlari bulundu ve fotograftaki ile eslenip eslenmedigini sorgulamak i�in bir loop etrafinda incelendi.       
  a=stats(n).Area;  
  centroid=stats(n).Centroid;            
  if a> 45000                 
    total = total + 1; 
    count1=count1+1;    
    text(centroid(1),centroid(2),'1TL');              
  elseif a >35000 &&  a < 45000               
    total = total + 0.5; 
    count50=count50+1;      
    text(centroid(1),centroid(2),'50Kr');            
  elseif a >25000 &&  a < 35000                
    total = total + 0.25; 
    count25=count25+1;      
    text(centroid(1),centroid(2),'25Kr');            
  elseif a > 20000 &&  a < 25000                
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
