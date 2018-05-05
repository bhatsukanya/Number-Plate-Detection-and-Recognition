function [ rOI ] = localize(originalImg,imageFileName,imageFileNameext)
%LOCALIZE Summary of this function goes here
%   Detailed explanation goes here

[h,w]=size(originalImg);
sharpImg = imsharpen(originalImg);
if size(sharpImg,3)==3
    grayscaleImg=rgb2gray(sharpImg);  %grey values are btwn 0 to 1 or 0 to 255
end

binaryImg =~im2bw(grayscaleImg,0.7); 
filterBinaryImg = bwareaopen(binaryImg,30); 
filterBinaryImg= bwareaopen(filterBinaryImg,6500); 

picture1=~filterBinaryImg;
picture2=bwareaopen(picture1,2500);  %those things that have less than 2500 pixels are removed ie excluding nmbr plate
diffImg=picture1-picture2;  %only number plate is left
diffImg=bwareaopen(diffImg,50);

HYPO1=8;
HYPO2=20;
se= strel('rectangle',[HYPO1 HYPO2]);
morphImg=imclose(diffImg,se);
boxes=regionprops(morphImg,'Perimeter','BoundingBox','FilledArea');

perimeter=[boxes.Perimeter];
filledArea=[boxes.FilledArea];
circularities=perimeter.^2 ./ (4*pi*filledArea);


noOfBoxes=length(boxes);
success=0;
plateCount=1;
for k = 1 : noOfBoxes
    thisBB = boxes(k).BoundingBox;
    X=round(thisBB(1));
    Y=round(thisBB(2));
    width=thisBB(3);
    height=thisBB(4);    
    area = width * height;
    if( circularities(k)>=1.1 && circularities(k)<3.5 )
%         rectangle('Position', [X,Y,width,height],...
%             'EdgeColor','r','LineWidth',2 )
        %Assuming that images are horizontal
        if( width/height >= 3 && area > 1000)
            success=1;
            Yend=Y+height-1;
            Xend=X+width-1;
            rOI=grayscaleImg(Y:Yend,X:Xend);
%             imshow(rOI);
            plateCount=plateCount+1;
        end        
    end
end



if(success==0)
    rOI=zeros(50,50);    
%     outputPath=strcat('./Segments/G1/',imageFileNameext);
%     imwrite(rOI,strcat(outputPath));
end

end

