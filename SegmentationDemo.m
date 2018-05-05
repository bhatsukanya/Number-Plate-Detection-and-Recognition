[testImgName,path] = uigetfile('*.jpg');
testImg=imread(strcat(path,'/',testImgName));
charSegments=segmentCharacters(testImg);
totalSegments=size(charSegments,3);

targetFolder='./Segmentation Results/';
[filepath,name,~] = fileparts(testImgName);
subFolder=name;
subFolderPath=strcat(targetFolder,subFolder,'/');
mkdir(subFolderPath);

ext='.jpg';

for i=1:totalSegments
    currentSegment=charSegments(:,:,i);
    outputPath=strcat(subFolderPath,num2str(i),ext);
    imwrite(currentSegment,outputPath);
end
% imwrite(plateImg,targetFilePath);
