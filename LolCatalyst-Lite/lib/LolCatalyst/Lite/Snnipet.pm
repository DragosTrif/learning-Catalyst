package LolCatalyst::Lite::Snnipet;

use Moose;
use namespace::clean -except => 'meta';

has 'id' => (is => 'ro', requierd => 1);
has 'text' => (is => 'ro', requierd => 1);

__PACKAGE__->meta->make_immutable;

1;
