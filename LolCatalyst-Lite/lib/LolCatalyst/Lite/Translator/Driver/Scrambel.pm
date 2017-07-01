package LolCatalyst::Lite::Translator::Driver::Scrambel;
use Moose;

sub shuffle {
  for (my $i = @_; --$i;) {
    my $j = int(rand($i+1));
    @_[$i,$j] = @_[$j,$i];
  }
}

sub _scarambel_word {
  my $word = shift || return '';
  my @piece = split //, $word;

  shuffle(@piece[1..$#piece-1]) if @piece > 2;
  join('', @piece);
}

sub _scarambel_block {
  my $text = shift;

  ${$text} =~ s{
               (
               (?:(?<=[^[:alpha:]])|(?<=\A))
                (?<!&)(?-x)(?<!&#)(?x)
                (?:
                  ['[:alpha:]]+|(?<!-)-(?!)
                )+
                (?=[^[:alpha:]]|\z)
               )
               }{_scarambel_word($1)}gex;
}

use namespace::autoclean -except => 'meta';

sub translate {
  my ($self, $text) = @_;
  _scarambel_block(\$text);
  return $text;
}

1;