%% get_id_birdlife
% gets id of name in birdlife

%%
function [id_birdlife id_avibase] = get_id_birdlife(my_pet, open)
% created 2021/08/02 by Bas Kooijman

%% Syntax
% [id_birdlife id_avibase] = <../get_id_birdlife.m *get_id_birdlife*>(my_pet, open)

%% Description
% Gets identifier for birdlife
%
% Input:
%
% * my_pet: character string with name of a taxon
% * open: optional boolean for opening in browser (default: 0)
%
% Output:
%
% * id_birdlife: character string with id in birdlife
% * id_avibase: character string with id in avibase

%% Remarks
% Outputs empty strings if identification was not successful.
% Does not work perfectly, since id is derive from twitter name in avibase.
% Possible problems e.g. corn-crake, rather than corncrake

%% Example of use
% [id_birdlife id_avibase] = get_id_birdlife('Passer_domesticus', 1)

address = 'http://datazone.birdlife.org/species/factsheet/';
address_avibase = 'https://avibase.bsc-eoc.org/species.jsp?lang=EN&avibaseid=';

if ~exist('open','var')
  open = 0;
end

id_avibase = get_id_avibase(my_pet); if isempty(id_avibase); id_birdlife = []; return; end
% url = urlread(['https://avibase.bsc-eoc.org/species.jsp?lang=EN&avibaseid=', id_avibase]);
% i_0 = strfind(url,'name="twitter:title" content="') + 30;
% i_1 = strfind(url(i_0:end), '"') + i_0(1) - 2;
% id = lower(url(i_0(1): i_1(1))); 
% id = strrep(id, '- ', '-'); id = strrep(id, ' ', '-'); id = strrep(id, '''', '');
% 
% id_birdlife = id;

my_pet = strrep(my_pet,'_','+'); 
my_pet = strrep(my_pet,' ','+'); 

url = urlread(['http://datazone.birdlife.org/quicksearch?qs=', my_pet]);
i_0 = strfind(url,'factsheet/') + 10; i_1 = strfind(url(i_0(1):end),'"') - 2;
id_birdlife = url(i_0(1): i_1(1));

if open
  web([address, id_birdlife],'-browser');
  web([address_avibase, id_avibase],'-browser');
end

