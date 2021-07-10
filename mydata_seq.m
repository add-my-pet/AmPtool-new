%% mydata_seq
% example of how to use dist_mean in seqlinkage
% 2021/07/10 by Bas Kooijman
% If the matlab command window gives red warnings, please type "clear all"

close all

species = select('Squalomorphi');
% traits = {'a_m'; 'a_p'; 'a_b'; 'Ww_i'; 'Ww_p'; 'Ww_b'; 'R_i'; 's_s'; 's_Hbp'; 'p_M'; 'v'; 'kap'; 'E_Hb'; 'E_Hp'};
traits = {'a_m'; 'a_p'; 'a_b'; 'Ww_i'; 'Ww_p'; 'Ww_b'; 'R_i'; 's_s'; 's_Hbp'; 'p_M'};
% traits = {'Ww_i'; 'Ww_p'; 'Ww_b'; 'R_i'; 's_s'; 's_Hbp'};
taxa = {'Squatiniformes'
        'Pristiophoriformes'
        'Squaliformes'
        'Hexanchiformes'
       };

% first compute distance-matrix and pass it to seqlinkage
dist_spec = dist_traits(species, traits);
dist_taxa = dist_mean(dist_spec, taxa);

PhyloTree = seqlinkage(dist_taxa, 'complete', taxa);
view(PhyloTree);