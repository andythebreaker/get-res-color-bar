%C
G = imread('G.jpg');
%B=imgaussfilt(C,1.6);
%G = rgb2gray(B);
% 2D->1D
D=reshape (G, 1, numel(G)); 
count = hist(D,0:1:255);


r1=round(256*0.1);
r2=round(256*0.9);
CT=count(r1:r2)
%[pks,locs] = findpeaks(count);
x=r1:r2;
plot(x,CT);
[pks,locs] = findpeaks(CT,'MinPeakDistance',50);
findpeaks(CT,x)

text(locs+.02,pks,num2str((1:numel(pks))'))

[spa,spb]=sort(CT(locs));
ph=locs(spb(end));
pl=locs(spb(end-1));
pot=(ph+pl)/2.0;
Z=imbinarize(G,pot/255.0);
szg=size(G);
zpm=zeros(szg(1),szg(2));
zpm(G>=pot)=1;
%zpm(G<pot)=0;

figure

xplh=pl:1:ph;
cplh=count(pl:ph);
TF = islocalmin(cplh,'SamplePoints',xplh);
plot(xplh,cplh,xplh(TF),cplh(TF),'r*')

% var Z , size is 400*640, which y=400, y goes first
zs=size(Z);
ar=[];
% how to make it arry , fast?
for i=1:1:zs(1)
    thisrow=Z(i,:);
    var_tmp_bef_log=false;
    arcount=0;
    for j=1:1:zs(2)
        var_change=0;
        if j==1
            this_tmp_bef_log=thisrow(j);
        else
            if this_tmp_bef_log~=thisrow(j)
                    var_change=1;
            end
            this_tmp_bef_log=thisrow(j);
        end
        arcount=arcount+var_change;
    end
    ar=[ar,arcount];
end
zi=uint8(Z);
ar8=find(ar==8);
zi(ar8,:)=2;
figure;
imagesc(zi);
tmp_size_ar8_array=size(ar8);
presentage=double(tmp_size_ar8_array(2))/double(zs(1));
%%

TF = islocalmin(count,'MinSeparation',100,'SamplePoints',x);
plot(x,count,x(TF),count(TF),'r*')
%%
plot(x,count,x(locs),pks,'or')
xlabel('Year')
ylabel('Number')
axis tight

