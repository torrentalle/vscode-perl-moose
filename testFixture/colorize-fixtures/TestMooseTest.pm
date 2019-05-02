=pod
Perl Moose Test packages to test VSCode colorize
This file is used to to test VSCode Colorization
=cut    


###############################################
# Test:       Moose Test syntax               #
# Repository: moose_packages                  #
###############################################


use Test::More plan => 1;
use Test::Moose;
 
meta_ok($class_or_obj, "... Foo has a ->meta");
does_ok($class_or_obj, $role, "... Foo does the Baz role");
has_attribute_ok($class_or_obj, $attr_name, "... Foo has the 'bar' attribute");
