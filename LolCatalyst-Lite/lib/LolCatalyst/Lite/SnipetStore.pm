package LolCatalyst::Lite::SnipetStore;

use Moose;
use namespace::clean -except => 'meta';

has '_snipets' => (is => 'ro', default => sub { [] });

sub find {
  my ($self, $id) = @_;
  return $self->_snipets->[$id - 1];
}

sub all {
  my ($self) = @_;
  return @{$self->_snipets};
}

sub create {
  my ($self, $new) = @_;
  $new->{id} = @{$self->_snipets} + 1;
  push @{$self->_snipets}, $new;
  return $new;
}

__PACKAGE__->meta->make_immutable;
1;
