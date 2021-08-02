%% get_id_fishbase
% gets id of accepted species name in fishbase

%%
function id = get_id_fishbase(my_pet, open)
% created 2021/08/02 by Bas Kooijman

%% Syntax
% id = <../get_id_fishbase.m *get_id_fishbase*>(my_pet, open)

%% Description
% Gets identifier for fishbase
%
% Input:
%
% * my_pet: character string with name of a taxon
% * open: optional boolean for opening in browser (default: 0)
%
% Output:
%
% * id: character string with id in fishbase

%% Remarks
% Outputs empty strings if identification was not successful.

%% Example of use
% id = get_id_fishbase('Squalus_acanthias')

address = 'https://www.fishbase.se/summary/';
if ~exist('open','var')
  open = 0;
end

id = strrep(my_pet,'_','-'); 
id = strrep(id,' ','-'); 

if open
  web([address, id],'-browser');
end
