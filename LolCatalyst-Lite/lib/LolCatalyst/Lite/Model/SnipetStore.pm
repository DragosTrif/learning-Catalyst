package LolCatalyst::Lite::Model::SnipetStore;
use strict;
use warnings;
use lib 'lib';
use aliased 'LolCatalyst::Lite::SnipetStore';
use aliased 'LolCatalyst::Lite::Translator';

sub  COMPONENT { SnipetStore->new(translator => Translator->new);}

1;
