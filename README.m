# Traffic-density-control-using-real-time-image-processing
clear all;
close all;
%%

rpi = raspi('169.254.110.223','pi','raspberry');
s = servo (rpi, 4);
cam = webcam(rpi);
area=zeros(1, 4);
for j = 1:4
writePosition(s, (j-1)*60);
pause(5);
for i = 1:30
if(i == 10)
background = snapshot(cam);
figure;
image(background);
drawnow;
disp("Background Set");
pause(2);
figure;
else
foreground = snapshot(cam);
image(foreground);
drawnow;
end;
end;
a = background;
b = foreground;
c=b-a;
d=imbinarize(rgb2gray(c)); me thres
e=imopen(d,strel('square', 3));
blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
'AreaOutputPort', false, 'CentroidOutputPort', false, ...
'MinimumBlobArea', 150);
bbox=step(blobAnalysis,e);
for i=1:size(bbox,1)
p=bbox(i,:);
area(j)=area(j)+p(1)*p(2);
end
display(area(j));
result=insertShape(b,'Rectangle',bbox,'Color','green');
figure;
imshow(result);
drawnow;
Page | 23
end;
red=[0,0,0,0];
yellow=[0,0,0,0];
green=[0,0,0,0];
t1
= area(1);
t2 = area(2);
t3 = area(3);
t4
= area(4);
a
= [t1, t2, t3, t4];
a
pins = [12:23];
[p,ind] = max(a);
q = min(a);
while
1 ==
1
green(ind)=1;
for i=1:4
yellow(i)=0;
if i~=ind
green(i)=0;
red(i)=1;
end
end
for i=1:3:12
writeDigitalPin(rpi,pins(i),red((i+2)/3));
writeDigitalPin(rpi,pins(i+1),yellow((i+2)/3));
writeDigitalPin(rpi,pins(i+2),green((i+2)/3));
end;
pause(3);
green(ind)=0;
yellow(ind)=1;
a(ind)
=
q
-1;
[p,ind]
= max(a);
q
= min(a);
for i=1:3:12
writeDigitalPin(rpi,pins(i),red((i+2)/3));
writeDigitalPin(rpi,pins(i+1),yellow((i+2)/3));
writeDigitalPin(rpi,pins(i+2),green((i+2)/3));
end;
pause(1.2);
yellow(ind)=1;
red(ind)=0;
for i=1:3:12
writeDigitalPin(rpi,pins(i),red((i+2)/3));
writeDigitalPin(rpi,pins(i+1),yellow((i+2)/3));
writeDigitalPin(rpi,pins(i+2),green((i+2)/3));
end;
pause(0.8);
end
