%Created by Amir Hossein Shiati
%Note that this program is sensitive to fonts 
clc;
close all;
clear;
%Change the name of im2 to the image you'd like it to solve
im2 = imread('k1.png');
%///////////////////////
plus =imread('plus.png');
mines = imread('mines.png');

im =~im2bw(im2);
plus =~im2bw(plus);
mines =~im2bw(mines);

erotion = imerode(im , plus);
n = size(im,1);
m = size(im,2);
counter = 0;
for i=1:n
    for j=1:m
        if(erotion(i,j) == 1)
            counter = 1;
        end
    end
end
if(counter == 1)
    dilation = imdilate(erotion,plus);
else
    erotion = imerode(im , mines);
    dilation = imdilate(erotion,mines);
end

[x,y] = find(dilation == 1);
min_row = min(y);
max_row = max(y);

im_num_1 =im(1:n,1:min_row - 1);
im_num_2 =im(1:n,max_row + 1:m);

%Number detection ++++++
 C = [0,0];
 E = [0,0];
for i=9:-1:0
    name_str = num2str(i) + ".png";
    im_num = imread(name_str);
    im_num = ~im2bw(im_num);
    [x,y] = find(im_num == 1);
    min_row = min(x);
    max_row = max(x);
    min_col = min(y);
    max_col = max(y);
    im_num = im_num(min_row:max_row,min_col:max_col);
%     imshow(im_num);
    for d=1:2
        if(d ==1)
         erotion = imerode(im_num_1,im_num);
         n = size(im_num_1,1);
         m = size(im_num_1,2);
        end
        if(d ==2)
         erotion = imerode(im_num_2,im_num);
         n = size(im_num_2,1);
         m = size(im_num_2,2);
        end
            
      for a=1:n
        for b=1:m
            if(erotion(a,b) == 1)
                if(d==1)
                  C = [b,i;C];
                dilation = imdilate(erotion,im_num);
               [t,z] = find(dilation == 1);
                minrow = min(t);
                maxrow = max(t);
                mincol = min(z);
                maxcol = max(z);
                im_num_1(minrow:maxrow,mincol:maxcol) = 0;
                                imshow(im_num_1);
                figure;
                end
                if(d==2)
                   E = [b,i;E];
                dilation = imdilate(erotion,im_num);
               [t,z] = find(dilation == 1);
                minrow = min(t);
                maxrow = max(t);
                mincol = min(z);
                maxcol = max(z);
                im_num_2(minrow:maxrow,mincol:maxcol) = 0;
                imshow(im_num_2);
                figure;
                end
            end
        end
      end 
    end
end
%++++++

%NUM 1
n = size(C,1);
num_str_1 = "";
C(n,:) =[];
n = size(C,1);
for i=1:n
   [a, b] = min(C(:,1));
    num_str_1 = num_str_1 + num2str(C(b,2));
    C(b,:) = [];
end
%+++
%NUM 2
n = size(E,1);
num_str_2 = "";
E(n,:) =[];
n = size(E,1);
for i=1:n
   [a, b] = min(E(:,1));
    num_str_2 = num_str_2 + num2str(E(b,2));
    E(b,:) = [];
end
%+++

NUM1 = str2num(num_str_1);
NUM2 = str2num(num_str_2);

if(counter == 1)
    answer = NUM1 + NUM2;
end
if(counter == 0)
    answer = NUM1 - NUM2;
end
equal = imread('equal.png');
equal =~im2bw(equal);
erotion = imerode(im , equal);
dilation = imdilate(erotion,equal);
[x,y] = find(dilation == 1);
max_row = max(y);
max_col = max(x);
min_col = min(x);
pos2 = (max_col + min_col) /2.3;
pos1 = max_row + 5;
final = im2double(im2);
txt = num2str(answer);
finalim = insertText(final, [pos1,pos2], txt , 'FontSize',30);
imshow(finalim);
