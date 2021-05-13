[y,e]=cmdscale(dist_traits(select('Carnivora'),{'a_m'; 'a_p'; 'a_b'; 'Ww_i'; 'Ww_p'; 'Ww_b'; 'R_i'; 's_s'; 's_Hbp'; 'p_M'}));
  legend_Carnivora = {...
    {'o', 8, 3, [0 0 0], [0 0 0]}, 'Feloidea'; ...
    {'o', 8, 3, [0 0 1], [0 0 0]}, 'Viverroidea'; ...
    {'o', 8, 3, [0 0 1], [0 0 1]}, 'Eupleridae'; ...
    
    {'o', 8, 3, [0 0 1], [1 0 1]}, 'Canidae'; ....
    {'o', 8, 3, [0 0 1], [1 0 0]}, 'Ursidae'; ....
    {'o', 8, 3, [1 0 1], [1 0 1]}, 'Gliriformes'; ....
    {'o', 8, 3, [1 0 1], [1 0 0]}, 'Musteloidea'; ....
    {'o', 8, 3, [1 0 0], [1 0 0]}, 'Pinnipedia'; ....
  };

plot3(y(:,1),y(:,2),y(:,3),'.k')