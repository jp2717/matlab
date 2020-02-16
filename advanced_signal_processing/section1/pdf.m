function pdf(random_process,bins)
%pdf Plots and returns the values of the estimated pdf of a random process

mean_rand = [];
sample_num = length(random_process(1,:));
for i = 1:sample_num
    mean_rand = [mean_rand mean(random_process(:,i))];
end

histogram(mean_rand,bins,'Normalization', 'pdf');
xlabel('Bins'); ylabel('Probability Density'); title('Estimate PDF');

end

