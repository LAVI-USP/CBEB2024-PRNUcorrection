close all
clear
clc

folder = ['E:\Renann\Doutorado\Paper CBEB\Images Organizadas_\Images Organizadas_\PMMA\FFDM\RAW\34kVp_80mAs_OK\65\'];
mAs = [80];


imgNames = dir([folder]);imgNames(1:2) = [];

for i=1:size(imgNames,1)
    
    img_FD(:,:,i) = double(dicomread([imgNames(i).folder '\' imgNames(i).name ]));
end
%img_MeanFD = flip(img_FD,2);

img_MeanFD = mean(img_FD,3);

img_F = img_MeanFD(200:end-200,200:end-200);
[X,Y]=meshgrid(200:size(img_MeanFD,2)-200,200:size(img_MeanFD,1)-200);
F=fit([X(:),Y(:)],img_F(:),'poly22');
[X2,Y2]=meshgrid(1:size(img_MeanFD,2),1:size(img_MeanFD,1));
FlatField_Fit(:,:)=F(X2,Y2);

%figure,mesh(FlatField_Fit),axis([0 2500 0 3000 8000 8800])
%figure,mesh(img_MeanFD),axis([0 2500 0 3000 8000 8800])
save(['FlatField_Fit_GE_FFDM_4.mat'],'FlatField_Fit')
f = figure;
%f.Position = [100 300 1700 700];
f.Position = [100 185 1350 550];
subplot(2,2,[1 3])
h = mesh(FlatField_Fit,'LineWidth',2),hold on, grid on
h.EdgeColor = [0.65 0.65 0.65];
h.FaceColor = [0.65 0.65 0.65];

[X Y] = meshgrid(1:size(img_MeanFD(:,:,1),2),1:size(img_MeanFD(:,:,1),1));
y = mesh(X(1:50:end,1:50:end),Y(1:50:end,1:50:end),img_MeanFD(1:50:end,1:50:end,1),'FaceAlpha','0.1','FaceColor','flat'),hold on;
c = colorbar;c.Location = 'northoutside';
%y.EdgeColor = [1 0.2 0.2]
t = text (-400,round(size(FlatField_Fit(:,:,1),1)/2), min(FlatField_Fit(:)),'Chest wall','FontSize',14);t.Rotation = -25;
axis([0 2000 0 3000 8000 8800])
xlabel('y coordinate','Rotation',15)
ylabel('x coordinate','Rotation',-25)
caxis([8300 8600])
aux = FlatField_Fit(round(size(FlatField_Fit(:,:,1),1)/2),1:10:end,1);
%h=mesh(repmat(X(round(size(FlatField_Fit(:,:,1),1)/2),1:100:end),[2 1]),repmat(Y(round(size(FlatField_Fit(:,:,1),1)/2),1:100:end),[2 1]),aux,'FaceColor',[0 0 0],'LineWidth',50),hold on
xx = X(round(size(FlatField_Fit(:,:,1),1)/2),1:10:end);
yy = Y(round(size(FlatField_Fit(:,:,1),1)/2),1:10:end);
plot3(xx,yy,aux,'k','LineWidth',7)

aux = FlatField_Fit(1:10:end,round(size(FlatField_Fit(:,:,1),2)/2),1);
%h=mesh(repmat(X(round(size(FlatField_Fit(:,:,1),1)/2),1:100:end),[2 1]),repmat(Y(round(size(FlatField_Fit(:,:,1),1)/2),1:100:end),[2 1]),aux,'FaceColor',[0 0 0],'LineWidth',50),hold on
xx = X(1:10:end,round(size(FlatField_Fit(:,:,1),2)/2));
yy = Y(1:10:end,round(size(FlatField_Fit(:,:,1),2)/2));
plot3(xx,yy,aux,'b','LineWidth',7)

legend('Noise-free signal estimated','High dose uniform image','Horizontal radiometric profile','Vertical radiometric profile','Location','northwest')


subplot(2,2,2),
aux = repmat(FlatField_Fit(round(size(FlatField_Fit(:,:,1),1)/2),1:10:end,1),[2 1]);

mesh(repmat(X(round(size(FlatField_Fit(:,:,1),1)/2),1:10:end),[2 1]),repmat(Y(round(size(FlatField_Fit(:,:,1),1)/2),1:10:end),[2 1]),aux,'EdgeColor',[0.65 0.65 0.65],'LineWidth',3),hold on

aux = repmat(img_MeanFD(round(size(img_MeanFD(:,:,1),1)/2),1:10:end,1), [2 1]);
mesh(repmat(X(round(size(FlatField_Fit(:,:,1),1)/2),1:10:end),[2 1]),repmat(Y(round(size(FlatField_Fit(:,:,1),1)/2),1:10:end),[2 1]),aux,'LineStyle' ,'--','FaceAlpha','0.3','FaceColor','interp'),hold on,caxis([8265.0 8601.0])
view(0,0)   % XZ
caxis([8300 8600])
axis([0 size(FlatField_Fit,2) 0 3000 8300 8700])
xlabel('y coordinate')
ax = gca
ax.XColor = 'k';
ax.XAxis.LineWidth = 2;
%ax.XAxis.FontSize = 15;
ax.XAxis.FontWeight = 'bold';
%ax.XAxis.Color = 'k';
%%
subplot(2,2,4),
aux = repmat(FlatField_Fit(1:10:end,round(size(FlatField_Fit(:,:,1),2)/2),1),[1 2]);
mesh(repmat(X(1:10:end,round(size(FlatField_Fit(:,:,1),2)/2)),[1 2]),repmat(Y(1:10:end,round(size(FlatField_Fit(:,:,1),2)/2)),[1 2]),aux,'EdgeColor',[0.65 0.65 0.65],'LineWidth',3),hold on

aux = repmat(img_MeanFD(1:10:end,round(size(FlatField_Fit(:,:,1),2)/2),1), [1 2]);
mesh(repmat(X(1:10:end,round(size(FlatField_Fit(:,:,1),2)/2)),[1 2]),repmat(Y(1:10:end,round(size(FlatField_Fit(:,:,1),2)/2)),[1 2]),aux,'LineStyle' ,'--','FaceAlpha','0.3','FaceColor','interp'),hold on,caxis([8265.0 8601.0])
view(90,0)   % XZ
caxis([8300 8600])
axis([0 2500 0 size(FlatField_Fit,1) 8300 8700])
ylabel('x coordinate')
ax = gca
ax.YColor = 'b';
ax.YAxis.LineWidth = 2;
%ax.XAxis.FontSize = 15;
ax.YAxis.FontWeight = 'bold';
%ax.XAxis.Color = 'k';


