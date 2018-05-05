function [charSegments]=segmentCharacters(plateImg)
%Input: plateImg - Extracted Number Plate
%Output: charSegments - multi-demnsional Matrix containing characters as
%images

% charSegments=zeros(5);

plateImg=LCS(plateImg);

[imHeight,imWidth]=size(plateImg);
%Hyperparameters
maxZero=4;
Xstart=20;
Xend=imWidth-3;
Ystart=3;
Yend=imHeight-3;

diffImg=uint8(ones(imHeight,imWidth).*255)-plateImg;

binaryImg=im2bw(diffImg,0.4);

binaryImg=~binaryImg(Ystart:Yend,Xstart:Xend);
binaryImg=bwareaopen(binaryImg,5);
% imshow(binaryImg);
%  txt=ocr(binaryImg);
% CC = bwconncomp(binaryImg,8);

% filteredImg = medfilt2(binaryImg);
% imshowpair(binaryImg,filteredImg,'montage');

verticalProjs=sum(binaryImg);
% subplot(2,1,1);imshow(binaryImg);
% displayProjs=ones(imHeight,imWidth);
% displayProjMat=repmat(verticalProjs,imHeight,1);
% displayProjMat1=LCS(displayProjMat);
% subplot(2,1,2);imshow(displayProjMat1);
% figure,subplot(1,2,1),imshow(diffImg);
% subplot(1,2,2),imshow(binaryImg);
verticalProjs(verticalProjs<maxZero)=0;

ne0 = find(verticalProjs~=0);                                   % Nonzero Elements
ne1 = find(verticalProjs==0);

indices1=unique([ne0(1) ne0(diff([0 ne0])>1)]);
indices2=[ne1(diff([0 ne1])>1) ne0(end)];
ix0 =  indices1;
ix1 =  indices2;
% ix0 = unique([ne0(1) ne0(diff([0 ne0])>1)]);        % Segment Start Indices
% found=find(diff([0 ne0])>1);
% ix1 = ne0([found-1 length(ne0)]);   % Segment End Indices


% ne0 = find(verticalProjs~=0);  % Indices where we get nonzero elements
% ele1=diff([0 ne0])>1; %elements having 0 or 1 where we got diff > 1
% ele2=ne0(ele1);%get indices
% ele3 = diff([ne0(ele2(1)) find(ele1==0)])>1;
% matrix1=[ne0(1) ele2];
% ix0 = unique(matrix1);        % Segment Start Indices
% found=find(ele1);
% ele4 = ne0(ele3);
% ix1 = [ele4 ne0(end)];
% ix1 = ne0([found-1 length(ne0)]);   % Segment End Indices
totalSegments=length(ix0);

% [Ix,Iy]=imgradientxy(binaryImg);
% figure,subplot(1,3,1),imshow(binaryImg);
% subplot(1,3,2),imshow(Ix);
% subplot(1,3,3),imshow(Iy);
% multi=cat(3,binaryImg,Ix,Iy);
% figure,montage(multi,map);
% imshow(binaryImg);
maxWidth=max(ix1)-max(ix0);

% seg=zeros(imHeight,imHeight,totalSegments);
segSize=max(maxWidth,imHeight);
requiredSize=20;
charSegments=zeros(requiredSize,requiredSize,totalSegments);
% figure;
for k1 = 1:totalSegments
    %     section{k1} = verticalProjs(ix0(k1):ix1(k1));
    currentSegment=zeros(segSize,segSize);
    %     currentSegment1=zeros(20,20);
    extract=binaryImg(:,ix0(k1):ix1(k1));
    %     figure, imshow(extract);
    %      subplot(1,totalSegments,k1);
    %      imshow(extract);
    currentWidth=ix1(k1)-ix0(k1)+1;
    currentHeight=size(extract,1);
    translation=segSize/2-currentWidth/2;
    
    currentSegment(1:currentHeight,1:currentWidth)=(extract);
    
    transImg =imtranslate(currentSegment,[translation,0]);
    currentSegment1 =imresize(transImg,[20 20]);
    currentSegment2 = imsharpen(currentSegment1);
    currentSegment3=im2bw(currentSegment2,0.1);
    charSegments(:,:,k1)=~currentSegment3;
    
 
end
end