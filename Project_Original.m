% Program? her çal??t?rd???m?zda farkl? datalar ile kar??la?aca??m?z için
% workspace'i run etmeden önce temizlememiz gerekir.
clear all
close all

%mevcut foto?raf? al?yoruz.
imageorj=imread('original.jpeg'); 
figure(1),imshow(imageorj);

% rgb2gray ile siyah beyaza dönü?türüp 2 boyuta dönü?türüyoruz. Renk
% önemsiz.image=rgb2gray(imageorj); 
level=graythresh(image); %2 boyuta geçirirken matlab'?n kullan?d?? level degeri onemli.
%Burada o degeri almaktay?z. Ben run etti?imde 0.2784 de?erini buldum.
%0.2784 de?eri üstü 1 olarak yani beyaz, alt de?eri siyah olarak atand?.
bw=im2bw(image,level);
figure(2),imshow(bw);

%We took the complement of our image.
bw=imcomplement(bw); 
figure(3),imshow(bw);

%Gorseldeki bosluklari tespit ettik. 
%imfill: gri seviyede veya binary modda aç?kl?klar? doldurur.
bw=imfill(bw,'holes');

%Birbiri ile bagl? olmayan pixelleri kaldirdik.
bw = bwareaopen(bw,30); 
figure(4),imshow(bw);

%12 piksel yar?çapl? disk ?eklinde bir yap?sal eleman olu?turduk.
% strell,strel, morfolojik i?lemlerde kullan?lan yap?sal filtre eleman?d?r. 
%Morfolojik i?lemleri hangi ?ekil ve parametrelerle uygulayaca??m?z? strel ile belirleriz.se=strel('disk',12,0); 

%Resimde herhangi bir birle?ik madeni para olu?mu?sa, onu ay?rd?k.
%imdilate: açma i?lemini yapar.
%imerode: a??nd?rma i?lemi yapar.bw2=imerode(bw,se); 
figure(5),imshow(bw2);

% Madeni para uzunluklar?n? belirlendi ve bu de?er B uzunlu?una atand?.
[B,L] = bwboundaries(bw2);
%B = bwboundaries(BW), ikili görüntü BW'de nesnelerin d?? s?n?rlar?n? ve bu nesnelerin içindeki deliklerin s?n?rlar?n? izler. bwboundaries ayr?ca en d??taki nesnelere izler ve onlar? takip sürer. S?n?r piksel konumlar?n?n bir hücre dizisi olan B'yi döndürür.
stats = regionprops(bw2, 'Area','Centroid');
%ikili görüntüdeki BW'deki her 8 ba?lant?l? nesne için bir dizi özellik için ölçümleri döndürür.
figure(6),imshow(imageorj);    
total = 0;  %baslangic degerleri atandi. Tum paralar ?c?n
count1=0;   %1 tlyi say
count50=0;  %50kr say
count25=0;  %25kr say
count10=0;  %1 tl'yi say
count5=0;   %5kr say
for n=1:length(B) 
  %Para alanlar? bulundu ve foto?raftaki ile e?lenip e?lenmedi?ini sorgulamak için bir loop etraf?nda incelendi.       
  
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

