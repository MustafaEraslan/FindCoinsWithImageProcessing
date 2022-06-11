% Programý her çalýþtýrdýðýmýzda farklý datalar ile karþýlaþacaðýmýz için
% workspace'i run etmeden önce temizlememiz gerekir.
clear all
close all

%mevcut fotoðrafý alýyoruz.
imageorj=imread('white_united.jpeg'); 
figure(1),imshow(imageorj);

% rgb2gray ile siyah beyaza dönüþtürüp 2 boyuta dönüþtürüyoruz. Renk
% önemsiz.image=rgb2gray(imageorj); 
level=graythresh(image);%2 boyuta geçirirken matlab'ýn kullanýdðý level degeri onemli.
%Burada o degeri almaktayýz. Ben run ettiðimde 0.2784 deðerini buldum.
%0.2784 deðeri üstü 1 olarak yani beyaz, alt deðeri siyah olarak atandý.
bw=im2bw(image,level);
bw=im2bw(image,level);
figure(2),imshow(bw);


bw=imcomplement(bw); 
figure(3),imshow(bw);

%Gorseldeki bosluklari tespit ettik. 
%imfill: gri seviyede veya binary modda açýklýklarý doldurur.bw=imfill(bw,'holes');

%Birbiri ile baglý olmayan pixelleri kaldirdik.
bw = bwareaopen(bw,30);
figure(4),imshow(bw);

%12 piksel yarýçaplý disk þeklinde bir yapýsal eleman oluþturduk.
% strell,strel, morfolojik iþlemlerde kullanýlan yapýsal filtre elemanýdýr. 
%Morfolojik iþlemleri hangi þekil ve parametrelerle uygulayacaðýmýzý strel ile belirleriz.
se=strel('disk',12,0); 

%Resimde herhangi bir birleþik madeni para oluþmuþsa, onu ayýrdýk.
%imdilate: açma iþlemini yapar.
%imerode: aþýndýrma iþlemi yapar.bw2=imerode(bw,se); 
figure(5),imshow(bw2);

% Madeni para uzunluklarýný belirlendi ve bu deðer B uzunluðuna atandý.
[B,L] = bwboundaries(bw2); 
%B = bwboundaries(BW), ikili görüntü BW'de nesnelerin dýþ sýnýrlarýný ve bu nesnelerin içindeki deliklerin sýnýrlarýný izler. bwboundaries ayrýca en dýþtaki nesnelere izler ve onlarý takip sürer. Sýnýr piksel konumlarýnýn bir hücre dizisi olan B'yi döndürür.
stats = regionprops(bw2, 'Area','Centroid');
%ikili görüntüdeki BW'deki her 8 baðlantýlý nesne için bir dizi özellik için ölçümleri döndürür.
figure(6),imshow(imageorj);    
total = 0;  %baslangic degerleri atandi. Tum paralar ýcýn
count1=0;   %1 tl'yi say
count50=0;  %50kr say
count25=0;  %25kr say
count10=0;  %10kr say
count5=0;   %5kr say
for n=1:length(B) 
  %Para alanlarý bulundu ve fotoðraftaki ile eþlenip eþlenmediðini sorgulamak için bir loop etrafýnda incelendi.       
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

