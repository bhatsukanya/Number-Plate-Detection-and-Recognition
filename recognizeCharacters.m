function [ch] = recognizeCharacters(im)
i=~im;
ch=' ';
% if size(im,3)==3 
%     im=rgb2gray(im);
%     figure,imshow(im);
% end
% threshold = graythresh(im);
% i =~im2bw(im,threshold);
%figure,imshow(im2);
%im1=imcrop(im2,[15,56,125,52]);
%i=imrotate(im1,180);
%figure,imshow(i);
% fid = fopen('text.txt', 'wt');
load templates;
global templates;
num=size(templates,2);
i = bwareaopen(i,30);
k=i;
[L Ne] = bwlabel(i);
for n=1:Ne
    i=k;
    [f co]=find(L==n);
    inew=i(min(f):max(f),min(co):max(co));
  %  figure,imshow(inew);
    inew1=imresize(inew,[42 24]);
   comp=[ ];
for ptr=1:num
%     imshow(templates{1,i});
      sem=corr2(templates{1,ptr},inew1);
       
%     norm1 = norm(inew1-templates{1,n},'fro');    
%     figure,imshow(templates{1,n});
      comp=[comp sem];
%      comp=[comp norm1];
end
% ind=find(comp==max(comp));
ind=find(comp==max(comp(:)));
% ind=find(comp==min(comp));
if ind==1
% fprintf(fid,'%s','A');
ch='A';
elseif ind==2
% fprintf(fid,'%s','B');
ch='B';
elseif ind==3
% fprintf(fid,'%s','C');
ch='C';
elseif ind==4
% fprintf(fid,'%s','D');
ch='D';
elseif ind==5
% fprintf(fid,'%s','E');
ch='E';
elseif ind==6
% fprintf(fid,'%s','F');
ch='F';
elseif ind==7
% fprintf(fid,'%s','G');
ch='G';
elseif ind==8
% fprintf(fid,'%s','H');
ch='H';
elseif ind==9
% fprintf(fid,'%s','I');
ch='I';
elseif ind==10
% fprintf(fid,'%s','J');
ch='J';
elseif ind==11
% fprintf(fid,'%s','K');
ch='K';
elseif ind==12
% fprintf(fid,'%s','L');
ch='L';
elseif ind==13
% fprintf(fid,'%s','M');
ch='M';
elseif ind==14
% fprintf(fid,'%s','N');
ch='N';
elseif ind==15
%fprintf(fid,'%s','O');
ch='O';
elseif ind==16
%fprintf(fid,'%s','P');
ch='P';
elseif ind==17
%fprintf(fid,'%s','Q');
ch='Q';
elseif ind==18
%fprintf(fid,'%s','R');
ch='R';
elseif ind==19
%fprintf(fid,'%s','S');
ch='S';
elseif ind==20
%fprintf(fid,'%s','T');
ch='T';
elseif ind==21
%fprintf(fid,'%s','U');
ch='U';
elseif ind==22
%fprintf(fid,'%s','V');
ch='V';
elseif ind==23
%fprintf(fid,'%s','W');
ch='W';
elseif ind==24
%fprintf(fid,'%s','X');
ch='X';
elseif ind==25
%fprintf(fid,'%s','Y');
ch='Y';
elseif ind==26
%fprintf(fid,'%s','Z');
ch='Z';
elseif ind==27
%fprintf(fid,'%s','0');
ch='0';
elseif ind==28
%fprintf(fid,'%s','1');
ch='1';
elseif ind==29
%fprintf(fid,'%s','2');
ch='2';
elseif ind==30
%fprintf(fid,'%s','3');
ch='3';
elseif ind==31
%fprintf(fid,'%s','4');
ch='4';
elseif ind==32
%fprintf(fid,'%s','5');
ch='5';
elseif ind==33
%fprintf(fid,'%s','6');
ch='6';
elseif ind==34
%fprintf(fid,'%s','7');
ch='7';
elseif ind==35
%fprintf(fid,'%s','8');
ch='8';
elseif ind==36
%fprintf(fid,'%s','9');
ch='9';
end 
co=[ ];
f=[];
end

%fid = fopen('text.txt');
%url2=fscanf(fid,'%s')
%url1='http://www.oxforddictionaries.com/definition/english/';
 %   url=[url1 url2];
  %  [stat,h]= web(url);
 %fclose(fid);
% winopen('text.txt')
end