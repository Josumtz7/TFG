function channel_concat = same_num_channel(downsepoch,chann_concat, folder_dim,num_valid_record)
    % This function creates a struct matrix with each channel for the whole
    % database. It will be used to have conclusions of each channels in
    % different behaviors

        %Input: 
            % -dowsnepoch: matrix with the downsampled epoch, used only for
            % dimensions            
            % -chann_concat: this is a matrix with all the concatenated
            % channels, p.e. the column number 1 will have all the channel
            % number 1 of the database
            % -folder_dim: number of folders we want to analyse
            % -num_valid_record: matrix with the number of valid epoch
            % recordings for each channel
         %Output:
            % -channel_concat: struct matrix with the recordins of each
            % channel of the whole database, p.e. cn1 contains all the
            % recordings of the channel number 1 


    %Inizialization
    cn1 = zeros(length(downsepoch),num_valid_record(1,1)); i_cn1 = 1;
    cn2 = zeros(length(downsepoch),num_valid_record(2,1)); i_cn2 = 1;
    cn3 = zeros(length(downsepoch),num_valid_record(3,1)); i_cn3 = 1;
    cn4 = zeros(length(downsepoch),num_valid_record(4,1)); i_cn4 = 1;
    cn5 = zeros(length(downsepoch),num_valid_record(5,1)); i_cn5 = 1;
    cn6 = zeros(length(downsepoch),num_valid_record(6,1)); i_cn6 = 1;
    cn7 = zeros(length(downsepoch),num_valid_record(7,1)); i_cn7 = 1;
    cn8 = zeros(length(downsepoch),num_valid_record(8,1)); i_cn8 = 1;
    cn9 = zeros(length(downsepoch),num_valid_record(9,1)); i_cn9 = 1;
    cn10 = zeros(length(downsepoch),num_valid_record(10,1)); i_cn10 = 1;
    cn11= zeros(length(downsepoch),num_valid_record(11,1)); i_cn11 = 1;
    cn12 = zeros(length(downsepoch),num_valid_record(12,1)); i_cn12 = 1;
    cn13 = zeros(length(downsepoch),num_valid_record(13,1)); i_cn13 = 1;
    cn14 = zeros(length(downsepoch),num_valid_record(14,1)); i_cn14 = 1;
    cn15 = zeros(length(downsepoch),num_valid_record(15,1)); i_cn15 = 1;
    min_concat = 1;
    for i_concat = 1:folder_dim
        min_cn = 1 + ((min_concat-1)*length(downsepoch)); 
        max_cn = min_cn + length(downsepoch) - 1;
        for j_concat = 1:size(chann_concat,2)
            if j_concat == 1 && chann_concat(min_cn,j_concat) ~= 0 
                cn1((1:length(downsepoch)),i_cn1) = chann_concat((min_cn:max_cn),j_concat);
                i_cn1 = i_cn1 + 1;
            elseif j_concat == 2 && chann_concat(min_cn,j_concat) ~= 0 
                cn2((1:length(downsepoch)),i_cn2) = chann_concat((min_cn:max_cn),j_concat);
                i_cn2 = i_cn2 + 1;
            elseif j_concat == 3 && chann_concat(min_cn,j_concat) ~= 0 
                cn3((1:length(downsepoch)),i_cn3) = chann_concat((min_cn:max_cn),j_concat);
                 i_cn3 = i_cn3 + 1;
            elseif j_concat== 4 && chann_concat(min_cn,j_concat) ~= 0
                cn4((1:length(downsepoch)),i_cn4) = chann_concat((min_cn:max_cn),j_concat);
                i_cn4 = i_cn4 + 1;
            elseif j_concat == 5 && chann_concat(min_cn,j_concat) ~= 0 
                cn5((1:length(downsepoch)),i_cn5) = chann_concat((min_cn:max_cn),j_concat);
                i_cn5 = i_cn5 + 1;
            elseif j_concat == 6 && chann_concat(min_cn,j_concat) ~= 0   
                cn6((1:length(downsepoch)),i_cn6) = chann_concat((min_cn:max_cn),j_concat);
                i_cn6 = i_cn6 + 1;
            elseif j_concat == 7 && chann_concat(min_cn,j_concat) ~= 0    
                cn7((1:length(downsepoch)),i_cn7) = chann_concat((min_cn:max_cn),j_concat);
                i_cn7 = i_cn7 + 1;
            elseif j_concat == 8 && chann_concat(min_cn,j_concat) ~= 0   
                cn8((1:length(downsepoch)),i_cn8) = chann_concat((min_cn:max_cn),j_concat);
                i_cn8 = i_cn8 + 1;
            elseif j_concat == 9  && chann_concat(min_cn,j_concat) ~= 0    
                cn9((1:length(downsepoch)),i_cn9) = chann_concat((min_cn:max_cn),j_concat);
                i_cn9 = i_cn9 + 1;
            elseif j_concat == 10 && chann_concat(min_cn,j_concat) ~= 0   
                cn10((1:length(downsepoch)),i_cn10) = chann_concat((min_cn:max_cn),j_concat);
                i_cn10 = i_cn10 + 1;
            elseif j_concat == 11 && chann_concat(min_cn,j_concat) ~= 0   
                cn11((1:length(downsepoch)),i_cn11) = chann_concat((min_cn:max_cn),j_concat);
                i_cn11 = i_cn11 + 1;
            elseif j_concat == 12 && chann_concat(min_cn,j_concat) ~= 0   
                cn12((1:length(downsepoch)),i_cn12) = chann_concat((min_cn:max_cn),j_concat);
                i_cn12 = i_cn12 + 1;
            elseif j_concat == 13 && chann_concat(min_cn,j_concat) ~= 0   
                cn13((1:length(downsepoch)),i_cn13) = chann_concat((min_cn:max_cn),j_concat);
                i_cn13 = i_cn13 + 1;
            elseif j_concat == 14 && chann_concat(min_cn,j_concat) ~= 0  
                cn14((1:length(downsepoch)),i_cn14) = chann_concat((min_cn:max_cn),j_concat);
                i_cn14 = i_cn14 + 1;
            elseif j_concat == 15  && chann_concat(min_cn,j_concat) ~= 0    
                cn15((1:length(downsepoch)),i_cn15) = chann_concat((min_cn:max_cn),j_concat);
                i_cn15 = i_cn15 + 1;
            end
        end
        min_concat = min_concat + 1;
    end
    channel_concat = struct('cn1', cn1, 'cn2', cn2, 'cn3', cn3, 'cn4', cn4, 'cn5', cn5, 'cn6', cn6, 'cn7', cn7, 'cn8', cn8, 'cn9', cn9, 'cn10', cn10, 'cn11', cn11, 'cn12', cn12, 'cn13', cn13,'cn14', cn14, 'cn15', cn15); 
end