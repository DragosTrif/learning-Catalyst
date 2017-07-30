package DBAuthTest::Controller::AuthUsers;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

DBAuthTest::Controller::AuthUsers - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched DBAuthTest::Controller::AuthUsers in AuthUsers.');
}

sub base : Chained('/'): PathPart('authusers'): CaptureArgs(0) {
   my ($self, $c) = @_;
   $c->stash(users_rc => $c->model('test_auth::User'));
}

sub add : Chained('base'): PathPart('add'): Args(0) {
  my ($self, $c) = @_;

  if(lc $c->req->method eq 'post') {
    my $params = $c->req->params;

    # retrive the user_rc stashed by the base action
    my $users_rc = $c->stash->{users_rc};
    # use Email::Valid;
    # if (!Email::Valid->address($params->{email})) {
    #   $c->stash(errors => {email => 'invalid'});
    #   return $c->res->redirect($c->uri_for($c->controller()->action_for('add')));
    #   # empty argument to $c->controller defaults to current controllet
    # }
    ## create new user
    my $new_user = eval {$users_rc->create({
      username => $params->{username},
      email => $params->{email},
      password => $params->{password},
    })};

    if ($@) {
      $c->log->debug(
        "User tryed ro log in with an invalid email"
      );
      $c->stash(errors => {email => 'invalid'}, err => $@);
      return;
    }

    return $c->res->redirect($c->uri_for($c->controller('AuthUsers')->action_for('profile'),[$new_user->id]));
  }
}

sub user: Chained('base'): PathPart(''): CaptureArgs(1) {
  my ($self, $c, $userid) = @_;

  if ($userid =~ /\D/) {
    die "Misuse of url id does not contain only digits\n";
  }
  my $user = $c->stash->{users_rc}->find( {id => $userid},
                                          {key => 'primary'});

  die 'No such user' if !$user;
  $c->stash(user => $user);

}

sub profile: Chained('user'): PathPart('profile'): Args(0) {
  my ($self, $c) = @_;
}


=encoding utf8

=head1 AUTHOR

Dragos,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
