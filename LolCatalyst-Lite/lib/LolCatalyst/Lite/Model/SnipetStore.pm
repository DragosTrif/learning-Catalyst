use strict;
use warnings;

use aliased 'LolCatalyst::Lite::SnipetStore';

sub COMPONENT { SnipetStore->new;
}

1;
