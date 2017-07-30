use utf8;
package test_auth::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

test_auth::Schema::Result::User

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 password

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 last_modified

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "password",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "last_modified",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<username>

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->add_unique_constraint("username", ["username"]);

=head1 RELATIONS

=head2 user_roles

Type: has_many

Related object: L<test_auth::Schema::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "test_auth::Schema::Result::UserRole",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-07-23 19:09:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:caZqj1rFtTGEspclQpVnwg
use Email::Valid;
sub new {
  my ($class, $args) = @_;

  if(exists $args->{email} && !Email::Valid->address($args->{email})) {
    die 'Email invalid';
  }

  return $class->next::method($args);
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->add_columns('last_modified',
  {
    %{__PACKAGE__->column_info('last_modified')},
    set_on_create => 1,
    set_on_update => 1
  }
);


__PACKAGE__->meta->make_immutable;
1;
