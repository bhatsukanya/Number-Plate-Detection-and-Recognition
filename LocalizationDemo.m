[testImgName,path] = uigetfile('*.jpg');
testImg=imread(strcat(path,'/',testImgName));
plateImg=localize(testImg);
targetFolder='./Localization Results/';
targetFilePath=strcat(targetFolder,testImgName);
imwrite(plateImg,targetFilePath);
