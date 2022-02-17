%% get_addStat
% adds all pars and stats to allStat.mat for specified entries

%%
function allStat = get_addStat(entries, T, f)
% created 2016/04/22 by Bas Kooijman

%% Syntax
% allStat = <get_addStat *get_addStat*> (taxa, T, f)

%% Description
% gets model, MRE, SMSE, CLOMPLETE, author, date_subm, date_acc, all parameters and statistics of specified entries.
% Parameters are always expressed at T_ref, i.e. C2K(20), irrespective of input T.
%
% Input:
%
% * entries: cell string with taxa to be added
% * T: optional scalar with body temperature in Kelvin for ststistics (default T_typical, which is entry-specific)
% * f: optional scalar with scaled functional response (default 1)
%
% Output:
% 
% * allStat: structure with all parameters and statistics values

%% Remarks
% Statistics are given at T_typical or T. 
% Meant to be used in combination with <write_addStat.html *write_addStat*>, which checks presence in sister-directory entries.
% See <get_addStat.html *get_addStat*> for all entries of select.
% The

%% Example of use
% see write_addStat
  
  if ~exist('T', 'var') || isempty(T)
    set_T = 0; % identyfier for temperature setting
  else 
    set_T = 1;
  end
 
  if ~exist('f', 'var') || isempty(f) 
    f = 1;
  end

  load allStat.mat %allUnits.mat allLabel.mat
  
  ne = length(entries);
  WD = cdCur; % store current path and goto AmP/curation
  cd(['../../deblab/add_my_pet/entries/',entries{1}]) % goto entries

  try
    for i = 1:ne
      cd (['../', entries{i}])
      fprintf([num2str(i), ': ', entries{i}, '\n']); % show progress on screen (takes some time)
      load (['results_', entries{i}])
      
      % metaData
      allStat.(entries{i}).species = metaData.species; 
        %allUnits.species = '-'; allLabel.species = 'taxon';
      allStat.(entries{i}).species_en = metaData.species_en; 
        %allUnits.species_en = '-'; allLabel.species_en = 'common name';
      allStat.(entries{i}).family  = metaData.family;  
        %allUnits.family = '-';  allLabel.family = 'taxon';
      allStat.(entries{i}).order   = metaData.order;   
        %allUnits.order = '-';   allLabel.order = 'taxon';
      allStat.(entries{i}).class   = metaData.class;   
        %allUnits.class = '-';   allLabel.class = 'taxon';
      allStat.(entries{i}).phylum  = metaData.phylum;  
        %allUnits.phylum = '-';  allLabel.phylum = 'taxon';
      if isfield(metaData.links, 'id_CoL')
        allStat.(entries{i}).id_CoL  = metaData.links.id_CoL; 
          %allUnits.id_CoL = '-'; allLabel.id_CoL = 'id Cat of Life';
      else
        allStat.(entries{i}).id_CoL  = ''; 
          %allUnits.id_CoL = '-'; allLabel.id_CoL = 'id Cat of Life';
      end
      allStat.(entries{i}).ecoCode.climate = metaData.ecoCode.climate; allStat.(entries{i}).units.ecoCode.climate = '-'; allStat.(entries{i}).label.ecoCode.climate = 'ecoCode climate';
      allStat.(entries{i}).ecoCode.ecozone = metaData.ecoCode.ecozone; allStat.(entries{i}).units.ecoCode.ecozone = '-'; allStat.(entries{i}).label.ecoCode.ecozone = 'ecoCode ecozone';
      allStat.(entries{i}).ecoCode.habitat = metaData.ecoCode.habitat; allStat.(entries{i}).units.ecoCode.habitat = '-'; allStat.(entries{i}).label.ecoCode.habitat = 'ecoCode habitat';
      allStat.(entries{i}).ecoCode.embryo  = metaData.ecoCode.embryo;  allStat.(entries{i}).units.ecoCode.embryo  = '-'; allStat.(entries{i}).label.ecoCode.embryo  = 'ecoCode embryo';
      allStat.(entries{i}).ecoCode.migrate = metaData.ecoCode.migrate; allStat.(entries{i}).units.ecoCode.migrate = '-'; allStat.(entries{i}).label.ecoCode.migrate = 'ecoCode migrate';
      allStat.(entries{i}).ecoCode.food    = metaData.ecoCode.food;    allStat.(entries{i}).units.ecoCode.food    = '-'; allStat.(entries{i}).label.ecoCode.food    = 'ecoCode food';
      allStat.(entries{i}).ecoCode.gender  = metaData.ecoCode.gender;  allStat.(entries{i}).units.ecoCode.gender  = '-'; allStat.(entries{i}).label.ecoCode.gender  = 'ecoCode gender';
      allStat.(entries{i}).ecoCode.reprod  = metaData.ecoCode.reprod;  allStat.(entries{i}).units.ecoCode.reprod  = '-'; allStat.(entries{i}).label.ecoCode.reprod  = 'ecoCode reprod';

      % data/model
      allStat.(entries{i}).model = metaPar.model; 
        %allUnits.model = '-'; allLabel.model = 'DEB model';
      allStat.(entries{i}).MRE = metaPar.MRE; 
        %allUnits.MRE = '-'; allLabel.MRE = 'Mean Relative Error';
      allStat.(entries{i}).SMSE = metaPar.SMSE; 
        %allUnits.SMSE = '-'; allLabel.SMSE = 'Symmetric Mean Squared Error';
      allStat.(entries{i}).COMPLETE = metaData.COMPLETE; 
        %allUnits.COMPLETE = '-'; allLabel.COMPLETE = 'completeness';
      allStat.(entries{i}).data = [metaData.data_0(:); metaData.data_1(:)]; 
        %allUnits.data = '-'; allLabel.data = 'data types';
      % submission
      allStat.(entries{i}).author = get_author(metaData); 
        %allUnits.author = '-'; allLabel.author = 'submitting author';
      allStat.(entries{i}).date_subm = metaData.date_subm; 
        %allUnits.date_subm = '-'; allLabel.date_subm = 'submitting date';
      % acceptance
      allStat.(entries{i}).date_acc = metaData.date_acc; 
        %allUnits.date_acc = '-'; allLabel.date_acc = 'acceptance date';
      % typical body temp
      allStat.(entries{i}).T_typical = metaData.T_typical;  
        %allUnits.T_typical = 'K'; allLabel.T_typical = 'typical body temperature';
            
     % parameters
      coreParFields = get_parfields(metaPar.model, 1); % get coreParFileds, including chemical pars
      par = rmfield_wtxt(par, 'free');   % remove substructure free from par
      [nm, nst] = fieldnmnst_st(par);    % get number of parameter fields
      for j = 1:nst % add core parameters at T_ref
        if ismember(nm{j},coreParFields)
          allStat.(entries{i}).(nm{j}) = par.(nm{j});
            %allUnits.(nm{j}) = txtPar.units.(nm{j}); allLabel.(nm{j}) = txtPar.label.(nm{j});
        end
      end
      
      % statistics
      allStat.(entries{i}).f = f; % overwrite scaled function response
      if set_T == 0
        [stat, txtStat] = statistics_st(metaPar.model, par, metaData.T_typical, f);
      else
        [stat, txtStat] = statistics_st(metaPar.model, par, T, f);
      end
      [nm, nst] = fieldnmnst_st(stat);    % get number of parameter fields
      for j = 1:nst % add all statistis at T or T_typical
        allStat.(entries{i}).(nm{j}) = stat.(nm{j});
          %allUnits.(nm{j}) = txtStat.units.(nm{j}); allLabel.(nm{j}) = txtStat.label.(nm{j});
      end
    end
   
  catch 
    disp(['Warning from get_addStat: Statistics of entry ', entries{i},' could not be extracted'])
    keyboard
  end
   
  cd(WD)                   % goto original path
end
