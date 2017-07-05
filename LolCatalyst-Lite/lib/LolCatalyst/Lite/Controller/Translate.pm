package LolCatalyst::Lite::Controller::Translate;

use strict;
use warnings;

use parent qw(Catalyst::Controller);

sub base :Chained('/') :PathPart('translate') :CaptureArgs(0) {
  my ($self, $c) = @_;
  $c->stash(collection => $c->model('SnipetStore'));
  $c->log->debug($c->stash->{collection});
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
  $c->stash(
    result => $c->model('Translator')->translate($object->{text})
  );
}

sub object :Chained('base') :PathPart('') :CaptureArgs(1) {
  my ($self, $c, $id) = @_;

  my $object = $c->stash->{collection}->find($id);
  $c->detach('/error 404') unless $object;
  $c->stash(object => $object);
}
__PACKAGE__->meta->make_immutable;

1;