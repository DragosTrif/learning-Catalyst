package LolCatalyst::Lite::Controller::Translate;
use Data::Dumper;

use strict;
use warnings;

use parent qw(Catalyst::Controller);

sub base :Chained('/') :PathPart('translate') :CaptureArgs(0) {
  my ($self, $c) = @_;
  $c->stash(collection => $c->model('SnipetStore'));
}

sub create :Chained('base') :PathPart('') :Args(0) {
  my ($self, $c) = @_;

  my $req = $c->req;

  if ($req->method eq 'POST' && (my $lol = $req->body_params->{lol})) {
    my $snnipet = $c->stash->{collection}->create({text => $lol});

    $c->stash(object => $snnipet);
    $c->detach('view');
  }
}

sub view :Chained('object') :PathPart('') :Args(0) {
  my ($self, $c) = @_;

  my $object = $c->stash->{object};
  # $c->stash(
  #   result => $c->model('Translator')->translate($object->{text})
  # );
  $c->stash(result => $object->translated);
}

sub object :Chained('base') :PathPart('') :CaptureArgs(1) {
  my ($self, $c, $id) = @_;

  my $object = $c->stash->{collection}->find($id);
  $c->detach('/error_404') unless $object;
  $c->stash(object => $object);
  my $o = $c->stash->{object};
  #$c->log->debug("\$var_2 is:", Dumper($o));
}

sub trasnlate_to :Chained('object') :PathPart('to') :Args(1) {
  my ($self, $c, $to) = @_;

  my $object = $c->stash->{object};
  unless ($object->can_translate_to($to)) {
    $c->detach('/error_404');
  }
  $c->stash(
    result => $object->translated_to($to),
  );

  my $test = $c->stash->{result};
  $c->log->debug("\$var_3 is: $test" );
  $c->stash(template => 'translate/view.tt');
}
__PACKAGE__->meta->make_immutable;

1;
