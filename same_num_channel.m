function channel_concat = same_num_channel(downsepoch,chann_concat, folder_dim)
    

    cn1 = zeros(length(downsepoch),folder_dim); 
    cn2 = zeros(length(downsepoch),folder_dim); 
    cn3 = zeros(length(downsepoch),folder_dim);
    cn4 = zeros(length(downsepoch),folder_dim); 
    cn5 = zeros(length(downsepoch),folder_dim); 
    cn6 = zeros(length(downsepoch),folder_dim); 
    cn7 = zeros(length(downsepoch),folder_dim); 
    cn8 = zeros(length(downsepoch),folder_dim);
    cn9 = zeros(length(downsepoch),folder_dim); 
    cn10 = zeros(length(downsepoch),folder_dim); 
    cn11= zeros(length(downsepoch),folder_dim); 
    cn12 = zeros(length(downsepoch),folder_dim); 
    cn13 = zeros(length(downsepoch),folder_dim); 
    cn14 = zeros(length(downsepoch),folder_dim); 
    cn15 = zeros(length(downsepoch),folder_dim); 
    for j_concat = 1:folder_dim
        min_cn = 1 + ((j_concat-1)*length(downsepoch)); 
        max_cn = min_cn + length(downsepoch) - 1;
        if chann_concat(min_cn,1) ~= 0            
            cn1((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),1);
            cn2((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),2);
            cn3((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),3);
            cn4((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),4);
            cn5((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),5);
            cn6((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),6);
            cn7((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),7);
            cn8((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),8);
            cn9((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),9);
            cn10((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),10);
            cn11((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),11);
            cn12((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),12);
            cn13((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),13);
            cn14((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),14);
            cn15((1:length(downsepoch)),j_concat) = chann_concat((min_cn:max_cn),15);
        end
    end
    
    channel_concat = struct('cn1', cn1, 'cn2', cn2, 'cn3', cn3, 'cn4', cn4, 'cn5', cn5, 'cn6', cn6, 'cn7', cn7, 'cn8', cn8, 'cn9', cn9, 'cn10', cn10, 'cn11', cn11, 'cn12', cn12, 'cn13', cn13,'cn14', cn14, 'cn15', cn15); 
end