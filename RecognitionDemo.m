[testImgName,path] = uigetfile('*.jpg');
testImg=imread(strcat(path,'/',testImgName));
txt=recognizeCharacters(testImg);
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1);
imshow(testImg);
axis off;
subplot(1,2,2);
set(gca,'visible','off') %hide the current axes
text(0.5,0.5,txt,'Color','black','FontSize',86);

