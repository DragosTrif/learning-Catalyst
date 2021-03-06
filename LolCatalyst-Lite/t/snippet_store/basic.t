use strict;
use warnings;

use Test::More 'no_plan';
use Test::Exception;
use lib 'lib';
use_ok('LolCatalyst::Lite::SnipetStore');

# my $store = LolCatalyst::Lite::SnipetStore->new();

dies_ok{
  LolCatalyst::Lite::SnipetStore->new()
} 'Create with out trasnlator object fails';

my $store = LolCatalyst::Lite::SnipetStore->new(translator => 'DUMMY');
my $num_snips = 3;
my @snips;
ok(
  (@snips = map $store->create({ text => "snippet $_"}), 1 .. $num_snips),
  "Creates ok"
);

cmp_ok (scalar @snips, '==', $num_snips, "$num_snips created");
diag("here");
diag(@snips);
diag( $store->all );
diag("here");
is_deeply(\@snips, [ $store->all ], 'deep snipet check');

foreach my $snip (@snips) {
  my $id = $snip->{id};
  is($snip->{text}, $store->find($id)->{text}, "find by id ($id) is ok");
}
