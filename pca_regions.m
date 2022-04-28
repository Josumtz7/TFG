function [regions , explained_cort, explained_hippo] = pca_regions(aggroupation)

%This function is used to reduce each aggroupation to the first 
%principal component of each group by Principal Component Analysis

    % Input: 

        %   - aggroupation: struct with the matrix of the different
        %   physiological parts of the brain

    % Output:
        
        %   - regions: matrix with the final results of the cortex,
        %   hippocampus, thalamus and suppramamilary nucleus
        %   - explained_cort, explained_hippo: used to plot the principal
        %   component's explained variance
        
    cortex = aggroupation.cortex;
    hippocampus = aggroupation.hippocampus;
     
 %  Analysis of the cortex
    [coeff_cort,~,~,~,explained_cort] = pca(cortex); % "coeff" are the principal component vectors.
    % Calculate eigenvalues and eigenvectors of the covariance matrix
    covarianceMatrixCortex = cov(cortex);
    % Multiplying the original data by the principal component vectors to get the
    % projections of the original data on the principal component vector space.
    dataInPrincipalComponentSpaceCortex = cortex*coeff_cort;
    %To show the orthogonality between columns
    corrcoef(dataInPrincipalComponentSpaceCortex); 
     % For looking at the eigenvectors of the covariance matrix.
    [V,D] = eig(covarianceMatrixCortex);


 %  Analysis of the hippocampus
    [coeff_hippo,~,~,~,explained_hippo] = pca(hippocampus);
    covarianceMatrixHippocampus = cov(hippocampus);
    dataInPrincipalComponentSpaceHippocampus = hippocampus*coeff_hippo;
    corrcoef(dataInPrincipalComponentSpaceHippocampus); 
    [V,D] = eig(covarianceMatrixHippocampus);

    % Save the values in the final matrix    
    regions = zeros(length(cortex),4);
    regions(:,1) = dataInPrincipalComponentSpaceCortex(:,1);
    regions(:,2) = aggroupation.thalamus;
    regions(:,3) = dataInPrincipalComponentSpaceHippocampus(:,1);
    regions(:,4) = aggroupation.supram_nucleus;
    
    % Plotting the results to see the the principal component's explained variance
    figure
    subplot(121)
    pareto(explained_cort)
    title('Cortex')
    xlabel('Principal Component')
    ylabel('Variance explained (%)')
    
    subplot(122)
    pareto(explained_hippo)
    title('Hippocampus')
    xlabel('Principal Component')
    ylabel('Variance explained (%)')
   
end

