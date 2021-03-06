package LolCatalyst::Lite::Translator;
use aliased 'LolCatalyst::Lite::Interface::TranslationDriver';
use Moose;
use Module::Pluggable::Object;
use namespace::autoclean -except => 'meta';

has 'default_target' => (
  is => 'ro', isa => 'Str', required => 1, default => 'LOLCAT'
);

has 'translators' => (
  is => 'ro', isa => 'HashRef', lazy_build => 1
);

sub _build_translators {
  my ($self) = @_;
  my $base = __PACKAGE__."::Driver";

  my $mp = Module::Pluggable::Object->new( search_path => [$base]);
  my @classes = $mp->plugins;
  my %translators = ();
  foreach my $class (@classes) {
    Class::Load::load_class($class);
   unless ($class->does(TranslationDriver)) {
      confess "Class ${class} in ${base}:: namespace dose not implement TranslationDriver";
   }
    (my $name = $class) =~ s/^\Q${base}::\E//;
    $translators{$name} = $class->new;
  }
  return \%translators;
}

sub translate {
  my ($self, $text) = @_;
  $self->translate_to($self->default_target, $text);
}

sub translate_to {
  my ($self, $target, $text) = @_;
  $self->translators->{$target}->translate($text);
}

sub can_translate_to {
  my ($self, $target) = @_;

  return exists $self->translators->{$target};
}
__PACKAGE__->meta->make_immutable;

1;
