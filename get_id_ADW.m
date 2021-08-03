%% get_id_ADW
% gets id of ADW

%%
function id = get_id_ADW(my_pet, open)
% created 2021/08/03 by Bas Kooijman

%% Syntax
% id = <../get_id_ADW.m *get_id_ADW*>(my_pet, open)

%% Description
% Gets identifier for Animal Diversity Web
%
% Input:
%
% * my_pet: character string with name of a taxon
% * open: optional boolean for opening in browser (default: 0)
%
% Output:
%
% * id: character string with id accepted name in ADW

%% Remarks
% Outputs empty string if identification was not successful.

%% Example of use
% id = get_id_ADW('Bufo_bufo',1)

address = 'https://animaldiversity.org/accounts/';
if ~exist('open','var')
  open = 0;
end

id = strrep(my_pet,' ','_'); 

try
  urlread([address, id]);
catch
  id = []; return
end

if open
  web([address, id],'-browser');
end

