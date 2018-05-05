% Prepare train data and labels

labels = ['A','B','C','D','E','F','G',...
    'H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',...
    '0','2','3','4','5','6','7','8','9'];

dataPath = './Extracted Chars/';
trainData =  uint8(zeros(size(labels,2),35));
trainLabels = repmat('0',size(labels,2),1);
count = 1;

for i = 1:size(labels,2)
   fpath = strcat(dataPath,labels(1,i),'.jpg');
   I = imread(fpath);
   %I = rgb2gray(I);
   level = graythresh(I);
   img = im2bw(I,level);
   %imshow(img)
   img = imresize(img,[5,7]);
   %x = imgaussfilt(int8(img),0.5);
   x=imresize(img(:,:),[1,35]);
   trainData(count,:) = x;
   %imshow(imresize(x,[20,20]));
   trainLabels(count) = char(labels(i));
   count = count+1; 
end

% Read segmented characters

inputPath = './Segmentation Samples';
imageFiles = dir(fullfile(inputPath,'*.jpg')); 
noOfImages = size(imageFiles,1);
test = uint8(zeros(noOfImages,35));
imageFileNames={imageFiles.name};
imageFileNames=sort_nat(imageFileNames);

for k = 1:noOfImages
    file1 = fullfile(inputPath,char(imageFileNames(k)));
    I = imread(file1);
    level = graythresh(I);
    img = im2bw(I,level);
    %imshow(img)
    %img = imgaussfilt(int8(img),0.5);
    img = imresize(img(:,:),[5,7],'bilinear');
    test(k,:) = imresize(img(:,:),[1,35]);
end

% Train kNN Classifier

model = fitcknn(trainData,trainLabels,'NumNeighbors',1)
class = predict(model,test)