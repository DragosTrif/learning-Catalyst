use strict;
use warnings;
use Test::More  'no_plan';
use Data::Dumper;
use File::Spec;
use Path::Class;
require File::Spec::Mac;
use lib 'lib';

BEGIN { 
  use_ok('LolCatalyst::Lite::Translator' , 'loads driver class');
  use_ok('LolCatalyst::Lite::Translator::LOLCAT', 'loads traslator');
}
 ok(LolCatalyst::Lite::Translator::LOLCAT->new(), 'create object');
 my $obj = LolCatalyst::Lite::Translator::LOLCAT->new();

 my $t = $obj->default_target;
 
my $mod = Path::Class::File->new("Acme","$t");
diag($mod);
my $class = join '::', ('Acme', $t);
use_ok($class);
done_testing();
