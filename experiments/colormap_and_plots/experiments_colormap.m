close all;
clc;
clear all;

filedir_optimized = '../data/mat_real_exp/optimized/experiment_47.mat';
load(filedir_optimized);
 
k = 1;
total = size(gp_normal,1);

while k <= total
    m = gp_normal(k,1);
    n = gp_normal(k,2);
    if (m ~= 0)
        matrix(m,n) = info_normal(k,1);
    end
    k = k + 1;
end
matrix(matrix == 0) = max(info_normal(:,1)) * 1.1;

figure
imagesc(matrix)
colormap(jet(10000))
colormap(pink);
colorbar
%title(['Minimum original costs with ' num2str(total) ' cells']);
set(gca,'XTick',linspace(1,size(matrix,2),size(matrix,2)));
set(gca,'YTick',linspace(1,size(matrix,1),size(matrix,1)));
axis equal
box on
set(gcf, 'Color', 'White')

matrix = [];
k = 1;
total = size(gp_energy,1);
while k <= total
    m = gp_energy(k,1);
    n = gp_energy(k,2);
    if (m ~= 0)
    matrix(m,n) = info_energy(k,1);
    end
    k = k + 1;
end
matrix(matrix == 0) = max(info_energy(:,1)) * 1.1;

figure
imagesc(matrix);
colormap(jet(10000));
colormap(pink);
colorbar;
%title(['Minimum energy costs with ' num2str(total) ' cells']);
set(gca,'XTick',linspace(1,size(matrix,2),size(matrix,2)));
set(gca,'YTick',linspace(1,size(matrix,1),size(matrix,1)));
axis equal
box on
set(gcf, 'Color', 'White')
