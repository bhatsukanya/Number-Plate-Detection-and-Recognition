[testImgName,path] = uigetfile('*.jpg');
testImg=imread(strcat(path,'/',testImgName));
plateImg=localize(testImg);
targetFolder='./Localization Results/';
mkdir(targetFolder);
targetFilePath=strcat(targetFolder,testImgName);
imwrite(plateImg,targetFilePath);
