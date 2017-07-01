package LolCatalyst::Lite::Translator::LOLCAT;
use Data::Dumper;
use Moose;
use Acme::LOLCAT;
use namespace::autoclean -except => 'meta';

sub translate {
  my ($self, $text) = @_;
  return Acme::LOLCAT::translate($text);
}
# has 'default_target' => (
#   is => 'ro', isa => 'Str', required => 1, default => 'LOLCAT'
# );

# has 'translators' => (
#   is => 'ro', isa => 'HashRef', lazy_build => 1
# );

# sub _build_translators {
#   my ($self) = @_;
#   #return { LOLCAT => LolCatalyst::Lite::Translator::LOLCAT->new };
#   my $base = __PACKAGE__;

#   my $mp = Module::Pluggable::Object->new( search_path => [$base]);
#   my @classes = $mp->plugins;

#   my %translators = (); 
#   foreach my $class (@classes) {
#     Class::MOP::load_class($class);
#     (my $name = $class) =~ s/^\Q${base}::\E//;
#     print Dumper(\$name);
#     $translators{$name} = $class->new;
#   }

#   return \%translators;
# }

# sub translate {
#   my ($self, $text) = @_;
#   $self->translate_to($self->default_target, $text);
# }

# sub translate_to {
#   my ($self, $target, $text) = @_;
#   $self->translators->{$target}->translate($text);
# }

__PACKAGE__->meta->make_immutable;

1;
