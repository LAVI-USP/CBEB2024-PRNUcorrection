% src/plotResults.m

function plotResults(Medias22, variancias22, Medias1, variancias1, P1, P2)
f2 = fit(Medias22, variancias22, 'poly2');
f1 = fit(Medias1, variancias1, 'poly2');

figure, plot(Medias22, variancias22, '*'), axis([0 5600 0 400]), grid on, hold on
plot((0:5500), f2(0:5500), '-', 'Color', [0 0.45 0.75]), hold on
p_aux1=plot(5000:100:6000,5000:100:6000,'-*','Color',[0 0.45 0.75]); axis([0 5600 0 400]),grid on, hold on

plot(Medias1, variancias1, 'o', 'Color', [0.9 0.7 0.12]), axis([0 5600 0 400]), grid on, hold on
plot((0:5500), f1(0:5500), '-', 'Color', [0.9 0.7 0.12]), hold on
p_aux2=plot(5000:100:6000,5000:100:6000,'-o','Color',[0.9 0.7 0.12]); axis([0 5600 0 400]),grid on, hold on

first_line = ['\sigma^2 = ' num2str(round(P1(1),6)) '\mu^2 + ' num2str(round(P1(2),2)) '\mu + ' num2str(round(P1(3),2))];
second_line = ['\sigma^2 = ' num2str(round(P2(1),6)) '\mu^2 + ' num2str(round(P2(2),2)) '\mu + ' num2str(round(P2(3),2))];
[l,h_legend] = legend([p_aux2 p_aux1],{first_line,second_line},'Location','northwest','FontSize',10);
xlabel('Mean Pixel Value (\mu)')
ylabel('Variance (\sigma^{2})')
legend('boxoff')
end
