% Programı her çalıştırdığımızda farklı datalar ile karşılaşacağımız için
% workspace'i run etmeden önce temizlememiz gerekir.
clear all
close all

%mevcut fotoğrafı alıyoruz.
imageorj=imread('original.jpeg'); 
figure(1),imshow(imageorj);

% rgb2gray ile siyah beyaza dönüştürüp 2 boyuta dönüştürüyoruz. Renk
% önemsiz.image=rgb2gray(imageorj); 
level=graythresh(image); %2 boyuta geçirirken matlab'ın kullanıdğı level degeri onemli.
%Burada o degeri almaktayız. Ben run ettiğimde 0.2784 değerini buldum.
%0.2784 değeri üstü 1 olarak yani beyaz, alt değeri siyah olarak atandı.
bw=im2bw(image,level);
figure(2),imshow(bw);

%We took the complement of our image.
bw=imcomplement(bw); 
figure(3),imshow(bw);

%Gorseldeki bosluklari tespit ettik. 
%imfill: gri seviyede veya binary modda açıklıkları doldurur.
bw=imfill(bw,'holes');

%Birbiri ile baglı olmayan pixelleri kaldirdik.
bw = bwareaopen(bw,30); 
figure(4),imshow(bw);

%12 piksel yarıçaplı disk şeklinde bir yapısal eleman oluşturduk.
% strell,strel, morfolojik işlemlerde kullanılan yapısal filtre elemanıdır. 
%Morfolojik işlemleri hangi şekil ve parametrelerle uygulayacağımızı strel ile belirleriz.se=strel('disk',12,0); 

%Resimde herhangi bir birleşik madeni para oluşmuşsa, onu ayırdık.
%imdilate: açma işlemini yapar.
%imerode: aşındırma işlemi yapar.bw2=imerode(bw,se); 
figure(5),imshow(bw2);

% Madeni para uzunluklarını belirlendi ve bu değer B uzunluğuna atandı.
[B,L] = bwboundaries(bw2);
%B = bwboundaries(BW), ikili görüntü BW'de nesnelerin dış sınırlarını ve bu nesnelerin içindeki deliklerin sınırlarını izler. bwboundaries ayrıca en dıştaki nesnelere izler ve onları takip sürer. Sınır piksel konumlarının bir hücre dizisi olan B'yi döndürür.
stats = regionprops(bw2, 'Area','Centroid');
%ikili görüntüdeki BW'deki her 8 bağlantılı nesne için bir dizi özellik için ölçümleri döndürür.
figure(6),imshow(imageorj);    
total = 0;  %baslangic degerleri atandi. Tum paralar ıcın
count1=0;   %1 tlyi say
count50=0;  %50kr say
count25=0;  %25kr say
count10=0;  %1 tl'yi say
count5=0;   %5kr say
for n=1:length(B) 
  %Para alanları bulundu ve fotoğraftaki ile eşlenip eşlenmediğini sorgulamak için bir loop etrafında incelendi.       
  
  a=stats(n).Area;        
  centroid=stats(n).Centroid;            
  if a> 8000                 
    total = total + 1; 
    count1=count1+1;    
    text(centroid(1),centroid(2),'1TL');              
  elseif a >6000 &&  a < 8000               
    total = total + 0.5; 
    count50=count50+1;      
    text(centroid(1),centroid(2),'50Kr');            
  elseif a >4000 &&  a < 6000                
    total = total + 0.25; 
    count25=count25+1;      
    text(centroid(1),centroid(2),'25Kr');            
  elseif a > 3500 &&  a < 4000                
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

