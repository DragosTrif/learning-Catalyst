package LolCatalyst::Lite::SnipetStore;

use Moose;
use lib 'lib';
use aliased 'LolCatalyst::Lite::Snnipet';
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
  # $new->{id} = @{$self->_snipets} + 1;
  # push @{$self->_snipets}, $new;
  # return $new;
  my $snippet = Snnipet->new(
    %$new,
    id => (@{$self->_snipets} + 1),
  );

  push @{$self->_snipets}, $snippet;
  return $snippet;
}

__PACKAGE__->meta->make_immutable;
1;
