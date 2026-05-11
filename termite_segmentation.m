clear
video_name=453;
a=VideoReader('D:\sreekrishna\453\GOPR0453.MP4');
start=700;
list=0:480:62880;
list=list';
list_append=start+list;
la=list_append;
[n,m] = size(la);
o_ans=zeros(n,1);
er_oop=zeros(n,1);
r_ans=zeros(n,1);
r_er= zeros(n,1);
time= zeros(n,1);

filename=strcat(num2str(video_name),num2str(la,'%06d'));
filename=['123456789' ; filename];
tic
for i=1:n
toc
javaaddpath 'C:\Program Files\MATLAB\R2016a\java\mij.jar'
javaaddpath 'C:\Program Files\MATLAB\R2016a\java\ij.jar'
addpath 'C:\Users\Admin\Downloads\fiji-win64\Fiji.app\scripts'
Miji(false)
MIJ.start
find_and_replace('wekaopen.ijm',filename(i,:),filename(i+1,:));
% a=mijread('file7822225.jpg');
% MIJ.run('Open...', 'path=[C:\\Users\\lenovo\\Documents\\MATLAB\\auto782\\file7822225.jpg]');
MIJ.run('Install...', 'install=D:\\sreekrishna\\453\\wekaopen.ijm');
MIJ.run('wekaopen');
MIJ.run('Trainable Weka Segmentation');
pause(1);
trainableSegmentation.Weka_Segmentation.loadClassifier('D:\\sreekrishna\\453\\classifier_453.model');
pause(1);
toc
trainableSegmentation.Weka_Segmentation.getResult;
toc
pause(1);
MIJ.run('8-bit');
MIJ.run('Threshold','setThreshold(0, 120)');
% MIJ.run('Invert');
MIJ.run('Set Measurements...', 'area mean standard modal min centroid center perimeter bounding fit shape integrated median skewness kurtosis area_fraction stack redirect=None decimal=3');
MIJ.run('Analyze Particles...', 'size=150-520 circularity=0.01-.99 show=[Overlay Masks] display exclude clear include summarize add in_situ');%the limit was 45o for frame 235
ij.IJ.deleteRows(0, 1000);
I=read(a,la(i,1));
% MIJ.selectWindow('file7822225.jpg');%%is this really important??
[bw, jk]=createMask(I);
MIJ.createImage(jk);
% MIJ.selectWindow('ROI Manager');
% MIJ.selectWindow('ROI Manager');
%Click the measure button in ROI manually
find_and_replace('wekathis.ijm',filename(i,:),filename(i+1,:));
MIJ.run('Install...', 'install=D:\\sreekrishna\\453\\wekathis.ijm');
MIJ.run('wekathis');
toc
a782=MIJ.getResultsTable();
T782=MIJ.getListColumns();
MIJ.run('Install...', 'install=D:\\sreekrishna\\453\\wekaclose.ijm');
MIJ.run('wekaclose');
% c=MIJ.getColumn('Area');
% fig7822225=imread('file7822225.jpg');%%I would do
fig=imshow(I);
% [y1,x1,z1] = size(fig7822225);
x0=926.5;
y0=543.5;
[N,M] = size(a782);
              x_d=a782(:,7);
              y_d=a782(:,8);
              x_m=a782(:,9);
              y_m=a782(:,10);
              hold on
              plot(x_d,y_d,'r.','MarkerSize',5) 
              hold on
              plot(x_m,y_m,'g.','MarkerSize',5) 
              
                         

    x_c=a782(:,7)-x0;
    y_c=a782(:,8)-y0;
    u=-a782(:,7)+a782(:,9);
    v=-a782(:,8)+a782(:,10);
    u_n=u./sqrt(u.^2+v.^2);
    v_n=v./sqrt(u.^2+v.^2);
    u_n(isnan(u_n)) = 0;
    v_n(isnan(v_n)) = 0;
    x_n=x_c./sqrt(x_c.^2+y_c.^2);
    y_n=y_c./sqrt(x_c.^2+y_c.^2);
              radi=sqrt(x_c.^2+y_c.^2);

    hold on
    q=quiver(x_c+x0,y_c+y0,u_n*30,v_n*30,0.5,'color',[1 0 0],'linewidth',1,'maxheadsize',2);
hold on
    q=quiver(x_c+x0,y_c+y0,-y_n,x_n,0.5,'color',[0 1 0],'linewidth',1,'maxheadsize',2);
%     q.LineWidth=0.7;
%     q.MaxHeadSize=0.3;

% hold on
%  theta=atand(-v./u);
% quiver(x_c,y_c,theta/10,theta/10)
hold off
oop=-u_n.*y_n+v_n.*x_n;
answer=sum(oop(:))/N
o_ans(i,1)=answer;
er_oop(i,1) = mad(oop);

r_ans(i,1)=mean(radi);
r_er(i,1) = mad(radi);
 title(['OOP value is' num2str(answer), 'number of segments = ' num2str(N) ''])

% saveas(fig,'result_7822225.jpgg') 
    filename2 = ['Result3',filename(i+1,:),''];
    print(gcf,filename2,'-djpeg');
    save(filename2)
 toc  
  time(i,1)=toc;
% MIJ.exit
% clear java clears everything
end
filename3 = ['Plot',video_name,''];
scatter(list/25,o_ans);
print(gcf,filename3,'-djpeg');
save(filename3)
figure(3)
yyaxis left
semilogx(list/25,o_ans,'-mo',...
'LineWidth',2,...
'MarkerEdgeColor','b',...
'MarkerFaceColor',[.49 1 .63],...
'MarkerSize',10);

yyaxis right
semilogx(list/25,r_ans,'-mo',...
'LineWidth',2,...
'MarkerEdgeColor','r',...
'MarkerFaceColor',[.49 1 .63],...
'MarkerSize',10);
print(gcf,filename3,'-dpng');
find_and_replace('wekaopen.ijm',filename(end,:),'1234567');
find_and_replace('wekathis.ijm',filename(end,:),'1234567');
clear java