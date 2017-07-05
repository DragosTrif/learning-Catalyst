use strict;
use warnings;

use aliased 'LolCatalyst::Lite::SnipetStore';

sub COMPONENT { SnnipetStore->new;
}

1;
