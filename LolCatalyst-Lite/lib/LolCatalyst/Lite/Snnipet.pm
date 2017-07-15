package LolCatalyst::Lite::Snnipet;

use Moose;
use namespace::clean -except => 'meta';

has 'id' => (is => 'ro', required => 1);
has 'text' => (is => 'ro', required => 1);
has '_translator' =>(is => 'ro', required => 1, init_arg => 'translator');

sub translated {
  my ($self) = @_;
  $self->_translator->translate($self->text);
}

sub translated_to {
  my ($self, $to) = @_;
  $self->_translator->translate_to($to, $self->text);
}
__PACKAGE__->meta->make_immutable;

1;
